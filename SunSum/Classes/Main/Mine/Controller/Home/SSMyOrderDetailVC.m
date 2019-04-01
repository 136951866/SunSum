//
//  SSMyOrderDetailVC.m
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMyOrderDetailVC.h"
#import "SSMyOrderDetailCell.h"
#import "SSOrderDetailView.h"
#import "SSOrderDetailContentCell.h"
#import "SSOrderDetailModel.h"
#import "SSOrderModel.h"
#import "SSPayStatusVC.h"
#import "SSMyOrderVC.h"

@interface SSMyOrderDetailVC ()<UITableViewDelegate, UITableViewDataSource>{
    SSOrderStyle _orderType;
    NSString *_orderGoodsSn;
    SSOrderDetailModel *_detaliModel;
    BOOL _isPayError;//防止跳2次错误页面
    BOOL _isSelf;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSArray *arrDataStr;
@property (nonatomic, strong) SSOrderDetailView *headerView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *bottomSelfExtractView;

@end

@implementation SSMyOrderDetailVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (instancetype)initWithOrderGoodsSn:(NSString *)orderGoodsSn{
    if(self = [super init]){
        _isSelf = NO;
        _orderGoodsSn = orderGoodsSn;
    }
    return self;
}

- (instancetype)initWithType:(SSOrderStyle)type orderGoodsSn:(NSString *)orderGoodsSn{
    if(self = [super init]){
        _isSelf = NO;
        _orderType = type;
        _orderGoodsSn = orderGoodsSn;
    }
    return self;
}

- (instancetype)initSelfWithType:(SSOrderStyle)type orderGoodsSn:(NSString *)orderGoodsSn{
    if(self = [super init]){
        _isSelf = YES;
        _orderType = type;
        _orderGoodsSn = orderGoodsSn;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    kMeWEAKSELF
    [SSPublicNetWorkTool getOrderDetailWithGoodSn:_orderGoodsSn successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_detaliModel = [SSOrderDetailModel mj_objectWithKeyValues:responseObject.data];
        strongSelf->_orderType = [strongSelf->_detaliModel.order_status integerValue];
        if(kMeUnNilStr(strongSelf->_detaliModel.remark).length){
            strongSelf.arrData =  @[@(SSSettlmemtFreight),@(SSSettlmemtRealPay),@(SSSettlmemtExpressCompany),@(SSSettlmemtExpressNum),@(SSSettlmemtRemark)];
            strongSelf.arrDataStr = @[[NSString stringWithFormat:@"¥%@",kMeUnNilStr(strongSelf->_detaliModel.all_freight)],[NSString stringWithFormat:@"¥%@",kMeUnNilStr(strongSelf->_detaliModel.order_amount)],kMeUnNilStr(strongSelf->_detaliModel.express.express_company),kMeUnNilStr(strongSelf->_detaliModel.express.express_num),kMeUnNilStr(strongSelf->_detaliModel.remark)];
        }else{
            strongSelf.arrData =  @[@(SSSettlmemtFreight),@(SSSettlmemtRealPay),@(SSSettlmemtExpressCompany),@(SSSettlmemtExpressNum)];
            strongSelf.arrDataStr = @[[NSString stringWithFormat:@"¥%@",kMeUnNilStr(strongSelf->_detaliModel.all_freight)],[NSString stringWithFormat:@"¥%@",kMeUnNilStr(strongSelf->_detaliModel.order_amount)],kMeUnNilStr(strongSelf->_detaliModel.express.express_company),kMeUnNilStr(strongSelf->_detaliModel.express.express_num)];
        }
        strongSelf.tableView.tableHeaderView = strongSelf.headerView;
        if(strongSelf->_orderType == SSAllNeedPayOrder && strongSelf->_isSelf==NO){
            strongSelf.tableView.tableFooterView = strongSelf.bottomView;
        }
        if(strongSelf->_isSelf==YES &&
           strongSelf->_detaliModel.store_get &&
           strongSelf->_detaliModel.store_get.get_status==SSOSelfNotExtractionrderStyle)
        {
            strongSelf.tableView.tableFooterView = strongSelf.bottomSelfExtractView;
        }
        [strongSelf.view addSubview:strongSelf.tableView];
        [strongSelf.tableView reloadData];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WechatSuccess:) name:WX_PAY_RESULT object:nil];
}

#pragma mark - Pay

- (void)WechatSuccess:(NSNotification *)noti{
    [self payResultWithNoti:[noti object] result:WXPAY_SUCCESSED];
}

- (void)payResultWithNoti:(NSString *)noti result:(NSString *)result{
    PAYJUDGE
    kMeWEAKSELF
    if ([noti isEqualToString:result]) {
        if(_isPayError){
            [self.navigationController popViewControllerAnimated:NO];
        }
        kNoticeReloadOrder
        NSLog(@"支付成功");
        _isPayError = NO;
        SSPayStatusVC *svc = [[SSPayStatusVC alloc]initWithSucessConfireBlock:^{
            kMeSTRONGSELF
            SSMyOrderVC *orderVC = (SSMyOrderVC *)[SSCommonTool getClassWtihClassName:[SSMyOrderVC class] targetVC:self];
            if(orderVC){
                [strongSelf.navigationController popToViewController:orderVC animated:YES];
            }
        }];
        [self.navigationController pushViewController:svc animated:YES];

    }else{
        if(!_isPayError){
            SSPayStatusVC *svc = [[SSPayStatusVC alloc]initWithFailRePayBlock:^{
                kMeWEAKSELF
                [SSPublicNetWorkTool postPayOrderWithOrder_sn:kMeUnNilStr(self->_orderGoodsSn) successBlock:^(ZLRequestResponse *responseObject) {
                    kMeSTRONGSELF
                    SSPayModel *model = [SSPayModel mj_objectWithKeyValues:responseObject.data];
                    BOOL isSucess =  [LVWxPay wxPayWithPayModel:model VC:strongSelf price:strongSelf->_detaliModel.order_amount];
                    if(!isSucess){
                        [SSShowViewTool showMessage:@"支付错误" view:kMeCurrentWindow];
                    }
                } failure:^(id object) {
                    
                }];
            } CheckOrderBlock:^{
                kMeSTRONGSELF
                [strongSelf.navigationController popToViewController:self animated:YES];
                //                kMeSTRONGSELF
                //                SSMyOrderDetailVC *vc = [[SSMyOrderDetailVC alloc]initWithType:SSAllNeedPayOrder orderGoodsSn:kMeUnNilStr(strongSelf->_order_sn)];
                //                [strongSelf.navigationController pushViewController:vc animated:YES];
            }];
            [self.navigationController pushViewController:svc animated:YES];
        }
        NSLog(@"支付失败");
        _isPayError = YES;
    }
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section){
        return _arrData.count;
    }else{
        return kMeUnArr(_detaliModel.children).count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section){
        SSMyOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSMyOrderDetailCell class]) forIndexPath:indexPath];
        ;
        [cell setUIWithModel:_arrDataStr[indexPath.row] Type:[_arrData[indexPath.row] integerValue] orderType:_orderType];
        return cell;
    }else{
        SSOrderDetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSOrderDetailContentCell class]) forIndexPath:indexPath];
        SSOrderGoodModel *orderModel = kMeUnArr(_detaliModel.children)[indexPath.row];
        [cell setUIWithChildModel:orderModel];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section?kSSMyOrderDetailCellHeight:kSSOrderDetailContentCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?kSSMyOrderDetailCellHeight:0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section){
        UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSSMyOrderDetailCellHeight)];
        UILabel *lblTitle = [[UILabel alloc]init];
        [sectionView addSubview:lblTitle];
        lblTitle.text = @"结算";
        lblTitle.font = [UIFont systemFontOfSize:16];
        lblTitle.textColor = kSSHexColor(@"333333");
        [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sectionView.mas_left).offset(15);
            make.right.equalTo(sectionView.mas_right).offset(15);
            make.top.equalTo(sectionView);
            make.bottom.equalTo(sectionView);
        }];
        return sectionView;
    }else{
        return [UIView new];
    }
}

- (void)toExtract:(UIButton *)btn{
    SSAlertView *aler = [[SSAlertView alloc] initWithTitle:@"" message:@"确定提取?"];
    [aler addButtonWithTitle:@"取消"];
    kMeWEAKSELF
    [aler addButtonWithTitle:@"确定" block:^{
        kMeSTRONGSELF
        [SSPublicNetWorkTool postcheckStoreGetOrderStatusWithGoodSn:kMeUnNilStr(strongSelf->_detaliModel.order_sn) successBlock:^(ZLRequestResponse *responseObject) {
            kNoticeReloadSelfExtractOrder
            [strongSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(id object) {
            
        }];
    }];
    [aler show];
}

- (void)toPay:(UIButton *)btn{
    kMeWEAKSELF
    [SSPublicNetWorkTool postPayOrderWithOrder_sn:kMeUnNilStr(self->_orderGoodsSn) successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        PAYPRE
        strongSelf->_isPayError= NO;
        SSPayModel *model = [SSPayModel mj_objectWithKeyValues:responseObject.data];
        BOOL isSucess =  [LVWxPay wxPayWithPayModel:model VC:strongSelf price:strongSelf->_detaliModel.order_amount];
        if(!isSucess){
            [SSShowViewTool showMessage:@"支付错误" view:kMeCurrentWindow];
        }
    } failure:^(id object) {
        
    }];
}

#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMyOrderDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSMyOrderDetailCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSOrderDetailContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSOrderDetailContentCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (SSOrderDetailView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSOrderDetailView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [SSOrderDetailView getViewHeightWithType:_orderType Model:_detaliModel]);
        [_headerView setUIWithModel:_detaliModel orderType:_orderType];
    }
    return _headerView;
}

- (UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 75)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 45);
        [btn addTarget:self action:@selector(toPay:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = kSSPink;
        [btn setTitle:@"立即支付" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.cornerRadius = 5;
        btn.clipsToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_bottomView addSubview:btn];
    }
    return _bottomView;
}

- (UIView *)bottomSelfExtractView{
    if(!_bottomSelfExtractView){
        _bottomSelfExtractView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 75)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 45);
        [btn addTarget:self action:@selector(toExtract:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = kSSPink;
        [btn setTitle:@"立即提取" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.cornerRadius = 5;
        btn.clipsToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_bottomSelfExtractView addSubview:btn];
    }
    return _bottomSelfExtractView;
}


@end
