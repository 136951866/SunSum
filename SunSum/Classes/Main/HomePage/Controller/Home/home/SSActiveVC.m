//
//  SSActiveVC.m
//  SunSum
//
//  Created by hank on 2018/10/15.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSActiveVC.h"
#import "TDWebViewCell.h"
//#import "SSSkuBuyView.h"
#import "SSGoodDetailModel.h"
#import "SSGoodModel.h"
#import "SSMakeOrderVC.h"
#import "SSLoginVC.h"
#import "SSMakeOrderAttrModel.h"
#import "SSPayStatusVC.h"
#import "SSMyOrderDetailVC.h"



@interface SSActiveVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *_order_sn;
    BOOL _isPayError;//防止跳2次错误页面
}
@property (nonatomic, strong) UITableView           *tableView;
@property (strong, nonatomic) TDWebViewCell                  *webCell;
//@property (nonatomic, strong) SSSkuBuyView *purchaseView;
@property (nonatomic, strong) SSGoodDetailModel *model;
@property (nonatomic, strong) UIButton *btnAppoint;
@end

@implementation SSActiveVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
    [self initWithSomeThing];
    kTDWebViewCellDidFinishLoadNotification
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WechatSuccess:) name:WX_PAY_RESULT object:nil];
    // Do any additional setup after loading the view.
}

kTDWebViewCellDidFinishLoadNotificationMethod

- (void)initWithSomeThing{
    kMeWEAKSELF
    [SSPublicNetWorkTool postGoodsComboDetailWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        SSGoodDetailModel *model = [SSGoodDetailModel mj_objectWithKeyValues:responseObject.data];
        model.buynum = 1;
        [strongSelf setUIWIthModel:model];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];

}

- (void)setUIWIthModel:(SSGoodDetailModel *)model{
    _model = model;
    
    NSMutableArray *arrSpc = [NSMutableArray array];
    
    [kMeUnArr(model.spec) enumerateObjectsUsingBlock:^(SSGoodDetailSpecModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {\
        SSGoodSpecModel *model = kMeUnArr(obj.spec_value)[0];
        [arrSpc addObject:@(model.idField).description];
    }];
    NSString *str = [arrSpc componentsJoinedByString:@","];
    _model.spec_ids = str;
    
    [self.view addSubview:self.tableView];
    NSLog(@"%@",kCurrentUser.mobile);
    if(![kCurrentUser.mobile isEqualToString:AppstorePhone]){
        [self.view addSubview:self.btnAppoint];
        [self.btnAppoint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(50));
            make.width.equalTo(@(self.view.width));
            make.top.equalTo(@(self.view.bottom-50));
        }];
    }else{
        self.tableView.frame = CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight);
    }
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    NSString *header = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>",width];
    [self.webCell.webView loadHTMLString:[NSString stringWithFormat:@"%@%@",header,kMeUnNilStr(_model.content)] baseURL:nil];
    [MBProgressHUD showMessage:@"获取详情中" toView:self.view];
}

#pragma mark - Acion

- (void)appointAction:(UIButton *)btn{
    if([SSUserInfoModel isLogin]){
//        [self creatOrder];
        SSMakeOrderVC *vc = [[SSMakeOrderVC alloc]initWithIsinteral:NO goodModel:_model];
        vc.isProctComd = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
//            [strongSelf creatOrder];
            SSMakeOrderVC *vc = [[SSMakeOrderVC alloc]initWithIsinteral:NO goodModel:strongSelf->_model];
            vc.isProctComd = YES;
            [strongSelf.navigationController pushViewController:vc animated:YES];
        } failHandler:nil];
    }
}

//- (void)creatOrder{
//    SSMakeOrderAttrModel *model = [[SSMakeOrderAttrModel alloc]initWithGoodDetailModel:_model];
//    kMeWEAKSELF
//    [SSPublicNetWorkTool postCreateCombOrderWithAttrModel:model successBlock:^(ZLRequestResponse *responseObject) {
//        kMeSTRONGSELF
//        strongSelf->_order_sn = responseObject.data[@"order_sn"];
//        [SSPublicNetWorkTool postPayOrderWithOrder_sn:kMeUnNilStr(strongSelf->_order_sn) successBlock:^(ZLRequestResponse *responseObject) {
//            kMeSTRONGSELF
//            PAYPRE
//            strongSelf->_isPayError= NO;
//            SSPayModel *model = [SSPayModel mj_objectWithKeyValues:responseObject.data];
//            CGFloat f = [strongSelf->_model.money floatValue] * (strongSelf->_model.buynum);
//            BOOL isSucess =  [LVWxPay wxPayWithPayModel:model VC:strongSelf price:@(f).description];
//            if(!isSucess){
//                [SSShowViewTool showMessage:@"支付错误" view:kMeCurrentWindow];
//            }
//        } failure:^(id object) {
//
//        }];
//    } failure:^(id object) {
//
//    }];
//}

//#pragma mark - Pay
//
//- (void)WechatSuccess:(NSNotification *)noti{
//    [self payResultWithNoti:[noti object] result:WXPAY_SUCCESSED];
//}

- (void)payResultWithNoti:(NSString *)noti result:(NSString *)result{

//    PAYJUDGE
//    kMeWEAKSELF
//    if ([noti isEqualToString:result]) {
//        if(_isPayError){
//            [self.navigationController popViewControllerAnimated:NO];
//        }
//        SSPayStatusVC *svc = [[SSPayStatusVC alloc]initWithSucessConfireBlock:^{
//            kMeSTRONGSELF
//            [strongSelf.navigationController popToViewController:self animated:YES];
//        }];
//        [self.navigationController pushViewController:svc animated:YES];
//        NSLog(@"支付成功");
//        _isPayError = NO;
//    }else{
//        if(!_isPayError){
//            kMeWEAKSELF
//            SSPayStatusVC *svc = [[SSPayStatusVC alloc]initWithFailRePayBlock:^{
//                [SSPublicNetWorkTool postPayOrderWithOrder_sn:kMeUnNilStr(self->_order_sn) successBlock:^(ZLRequestResponse *responseObject) {
//                    kMeSTRONGSELF
//                    SSPayModel *model = [SSPayModel mj_objectWithKeyValues:responseObject.data];
//                    CGFloat f = [strongSelf->_model.money floatValue] * (strongSelf->_model.buynum);
//                    BOOL isSucess =  [LVWxPay wxPayWithPayModel:model VC:strongSelf price:@(f).description];
//                    if(!isSucess){
//                        [SSShowViewTool showMessage:@"支付错误" view:kMeCurrentWindow];
//                    }
//                } failure:^(id object) {
//
//                }];
//            } CheckOrderBlock:^{
//                kMeSTRONGSELF
//                SSMyOrderDetailVC *vc = [[SSMyOrderDetailVC alloc]initWithType:SSAllNeedPayOrder orderGoodsSn:kMeUnNilStr(strongSelf->_order_sn)];
//                [strongSelf.navigationController pushViewController:vc animated:YES];
//            }];
//            [self.navigationController pushViewController:svc animated:YES];
//        }
//        NSLog(@"支付失败");
//        _isPayError = YES;
//    }
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return self.webCell;
    }else{
        return [UITableViewCell new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(!_webCell){
            return 0;
        }else{
            return [[self.webCell.webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] intValue];
        }
    }else{
        return 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.section);
    
}

#pragma mark - Set

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-k50WH) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDWebViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDWebViewCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (UIButton *)btnAppoint{
    if(!_btnAppoint){
        _btnAppoint = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAppoint.frame = CGRectMake(0, self.view.height - k50WH, SCREEN_WIDTH, k50WH);
        [_btnAppoint setTitle:@"立即订购" forState:UIControlStateNormal];
        [_btnAppoint setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnAppoint.backgroundColor = kSSPink;
        [_btnAppoint addTarget:self action:@selector(appointAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAppoint;
}

- (TDWebViewCell *)webCell{
    if(!_webCell){
        _webCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDWebViewCell class])];
    }
    return _webCell;
}

//- (SSSkuBuyView *)purchaseView{
//    if(!_purchaseView){
//        _purchaseView = [[SSSkuBuyView alloc]initPurchaseViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) serviceModel:_model WithSuperView:self.view];
//    }
//    return _purchaseView;
//}


@end
