//
//  SSMakeOrderVC.m
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMakeOrderVC.h"
#import "SSMakeOrderCell.h"
#import "SSMakeOrderSelectAddressView.h"
#import "SSMakeOrderHeaderCell.h"
#import "SSSelectAddressVC.h"
#import "SSGoodDetailModel.h"
#import "SSAddressModel.h"
#import "SSMakeOrderAttrModel.h"
#import "SSPayStatusVC.h"
#import "SSMyOrderDetailVC.h"

//#import "SSProductDetailsVC.h"
#import "SSThridProductDetailsVC.h"

#import "SSMineExchangeDetailVC.h"

@interface SSMakeOrderVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _hasAdress;
    NSArray *_arrType;
    BOOL _isInteral;
    SSGoodDetailModel *_goodModel;
    SSAddressModel *_addressModel;
    NSString *_strMeaasge;
    NSString *_order_sn;
    BOOL _isPayError;//防止跳2次错误页面
    NSArray *_arrData;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) SSMakeOrderSelectAddressView *sAddressView;
@property (weak, nonatomic) IBOutlet UILabel *lblAllPrice;
@property (strong, nonatomic) UIView *notAddressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;

@end

@implementation SSMakeOrderVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

#pragma mark - LifeCycle

- (instancetype)initWithIsinteral:(BOOL)isInteral goodModel:(SSGoodDetailModel *)goodModel{
    if (self = [super init]){
        _isInteral = isInteral;
        _goodModel = goodModel;
        _isPayError= NO;
        _arrData = [NSArray array];
        self.isProctComd = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生成订单";
    _topMargin.constant = kMeNavBarHeight;
    kMeWEAKSELF
    [SSPublicNetWorkTool postAddressDefaultAddressWithsuccessBlock:^(ZLRequestResponse *responseObject) {
        SSAddressModel *model = [SSAddressModel mj_objectWithKeyValues:responseObject.data];
        kMeSTRONGSELF
        if(model){
            strongSelf->_hasAdress = YES;
            strongSelf->_addressModel = [SSAddressModel mj_objectWithKeyValues:responseObject.data];
            [strongSelf initSomeThing];
        }else{
            [strongSelf initSomeThing];
        }
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf initSomeThing];
    }];
//    [self initSomeThing];
    // Do any additional setup after loading the view from its nib.
}

- (void)initSomeThing {
    if(_isInteral){
        _arrType = @[@(SSMakrOrderCellDistribution),@(SSMakrOrderCellExhange),@(SSMakrOrderCellMessage)];
        CGFloat allBean = [kMeUnNilStr(_goodModel.psmodel.integral_lines) floatValue] * _goodModel.buynum;
        _lblAllPrice.text = [NSString stringWithFormat:@"%.2f美豆",allBean];
        _arrData = @[[NSString stringWithFormat:@"¥%@",kMeUnNilStr(_goodModel.postage)],[NSString stringWithFormat:@"%.2f美豆",allBean],@""];
    }else{
        CGFloat allPrice = 0;
        if(self.isProctComd){
            allPrice = [kMeUnNilStr(_goodModel.money) floatValue];
        }else{
            if(_goodModel.is_seckill==1){
                allPrice = [kMeUnNilStr(_goodModel.psmodel.seckill_price) floatValue] * _goodModel.buynum;
            }else{
                allPrice = [kMeUnNilStr(_goodModel.psmodel.goods_price) floatValue] * _goodModel.buynum;
            }
        }
        _arrType = @[@(SSMakrOrderCellMessage)];
        _arrData = @[@""];
        _lblAllPrice.text = [NSString stringWithFormat:@"%.2f",allPrice];
    }
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMakeOrderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSMakeOrderCell class])];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMakeOrderHeaderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSMakeOrderHeaderCell class])];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    if(_hasAdress){
        self.sAddressView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [SSMakeOrderSelectAddressView getViewHeightWithModel:_addressModel]);
        [self.sAddressView setUIWithModel:_addressModel];
        _tableView.tableHeaderView = self.sAddressView;
    }else{
        _tableView.tableHeaderView = self.notAddressView;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WechatSuccess:) name:WX_PAY_RESULT object:nil];
}

#pragma mark - UITableViewDelegate
#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrType.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!indexPath.row){
        SSMakeOrderHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSMakeOrderHeaderCell class]) forIndexPath:indexPath];
        [cell setUIWithModle:_goodModel isComb:self.isProctComd isInteral:_isInteral];
        return cell;
    }else{
        // -1 是第一个给详情cell
        SSMakrOrderCellStyle type = [_arrType[indexPath.row-1] integerValue];
        SSMakeOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSMakeOrderCell class]) forIndexPath:indexPath];
        NSString *data = _arrData[indexPath.row-1];
        [cell setUIWithType:type model:data];
        if(type == SSMakrOrderCellMessage){
            kMeWEAKSELF
            cell.messageBlock = ^(NSString *str) {
                NSLog(@"%@",str);
                kMeSTRONGSELF
                strongSelf->_strMeaasge = str;
            };
            cell.returnBlock = ^{
                kMeSTRONGSELF
                [strongSelf.view endEditing:YES];
            };
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row?kSSMakeOrderCellHeight:kSSMakeOrderHeaderCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
        SSPayStatusVC *svc = [[SSPayStatusVC alloc]initWithSucessConfireBlock:^{
            kMeSTRONGSELF
            if(strongSelf->_isInteral){
                SSMineExchangeDetailVC *vc = (SSMineExchangeDetailVC *)[SSCommonTool getClassWtihClassName:[SSMineExchangeDetailVC class] targetVC:strongSelf];
                if(vc){
                    [strongSelf.navigationController popToViewController:vc animated:YES];
                }else{
                    [strongSelf.navigationController popToViewController:strongSelf animated:YES];
                }
            }else{
                SSThridProductDetailsVC *vc = (SSThridProductDetailsVC *)[SSCommonTool getClassWtihClassName:[SSThridProductDetailsVC class] targetVC:strongSelf];
                if(vc){
                    [strongSelf.navigationController popToViewController:vc animated:YES];
                }else{
                    [strongSelf.navigationController popToViewController:strongSelf animated:YES];
                }
            }
        }];
        [self.navigationController pushViewController:svc animated:YES];
        NSLog(@"支付成功");
        _isPayError = NO;
    }else{
        if(!_isPayError){
            kMeWEAKSELF
            SSPayStatusVC *svc = [[SSPayStatusVC alloc]initWithFailRePayBlock:^{
                [SSPublicNetWorkTool postPayOrderWithOrder_sn:kMeUnNilStr(self->_order_sn) successBlock:^(ZLRequestResponse *responseObject) {
                    kMeSTRONGSELF
                    SSPayModel *model = [SSPayModel mj_objectWithKeyValues:responseObject.data];
                    CGFloat f = [strongSelf->_goodModel.money floatValue] * (strongSelf->_goodModel.buynum);
                    BOOL isSucess =  [LVWxPay wxPayWithPayModel:model VC:strongSelf price:@(f).description];
                    if(!isSucess){
                        [SSShowViewTool showMessage:@"支付错误" view:kMeCurrentWindow];
                    }
                } failure:^(id object) {

                }];
            } CheckOrderBlock:^{
                kMeSTRONGSELF
                SSMyOrderDetailVC *vc = [[SSMyOrderDetailVC alloc]initWithType:SSAllNeedPayOrder orderGoodsSn:kMeUnNilStr(strongSelf->_order_sn)];
                [strongSelf.navigationController pushViewController:vc animated:YES];
            }];
            [self.navigationController pushViewController:svc animated:YES];
        }
        NSLog(@"支付失败");
        _isPayError = YES;
    }
}
 
#pragma mark - Private

- (void)selectAddress{
    SSSelectAddressVC *vc = [[SSSelectAddressVC alloc]init];
    kMeWEAKSELF
    vc.selectModelBlock = ^(SSAddressModel *addressModel) {
        kMeSTRONGSELF
        strongSelf->_addressModel = addressModel;
        strongSelf->_hasAdress = YES;
        strongSelf.sAddressView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [SSMakeOrderSelectAddressView getViewHeightWithModel:strongSelf->_addressModel]);
        [strongSelf.sAddressView setUIWithModel:strongSelf->_addressModel];
        strongSelf->_tableView.tableHeaderView = strongSelf.sAddressView;
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectAddress:(UITapGestureRecognizer *)ges{
    [self selectAddress];
}

- (IBAction)toPay:(UIButton *)sender {
    if(!_hasAdress){
        [SSShowViewTool showMessage:@"请先选择地址" view:self.view];
        return;
    }
    SSMakeOrderAttrModel *model = [[SSMakeOrderAttrModel alloc]initWithGoodDetailModel:_goodModel];
    model.remark = kMeUnNilStr(_strMeaasge);
    model.user_address = @(_addressModel.address_id).description;
    if(_isInteral){
        //积分
        model.order_type = @"4";
        //有运费需要支付
        kMeWEAKSELF
        [SSPublicNetWorkTool postCreateServiceOrderWithAttrModel:model successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_order_sn = responseObject.data[@"order_sn"];
            NSString *postageStr = responseObject.data[@"order_amount"];
            CGFloat postage = [postageStr floatValue];
            if(postage<=0){
                strongSelf->_isPayError= NO;
                SSPayStatusVC *svc = [[SSPayStatusVC alloc]initWithSucessConfireBlock:^{
                    if(strongSelf->_isInteral){
                        SSMineExchangeDetailVC *vc = (SSMineExchangeDetailVC *)[SSCommonTool getClassWtihClassName:[SSMineExchangeDetailVC class] targetVC:strongSelf];
                        if(vc){
                            [strongSelf.navigationController popToViewController:vc animated:YES];
                        }else{
                            [strongSelf.navigationController popToViewController:strongSelf animated:YES];
                        }
                    }else{
                        SSThridProductDetailsVC *vc = (SSThridProductDetailsVC *)[SSCommonTool getClassWtihClassName:[SSThridProductDetailsVC class] targetVC:strongSelf];
                        if(vc){
                            [strongSelf.navigationController popToViewController:vc animated:YES];
                        }else{
                            [strongSelf.navigationController popToViewController:strongSelf animated:YES];
                        }
                    }
                }];
                [strongSelf.navigationController pushViewController:svc animated:YES];
            }else{
                [SSPublicNetWorkTool postPayOrderWithOrder_sn:kMeUnNilStr(strongSelf->_order_sn) successBlock:^(ZLRequestResponse *responseObject) {
                    kMeSTRONGSELF
                    PAYPRE
                    strongSelf->_isPayError= NO;
                    SSPayModel *model = [SSPayModel mj_objectWithKeyValues:responseObject.data];
                    //CGFloat f = [strongSelf->_goodModel.money floatValue] * (strongSelf->_goodModel.buynum);
                    BOOL isSucess =  [LVWxPay wxPayWithPayModel:model VC:strongSelf price:@(postage).description];
                    if(!isSucess){
                        [SSShowViewTool showMessage:@"支付错误" view:kMeCurrentWindow];
                    }
                } failure:^(id object) {
                    
                }];
            }
        } failure:^(id object) {
            //下单
        }];
    }else{
        kMeWEAKSELF
        model.order_type = _goodModel.is_seckill==1? @"9":@"1";
        model.uid = kMeUnNilStr(self.uid);
        [SSPublicNetWorkTool postCreateOrderWithAttrModel:model successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_order_sn = responseObject.data[@"order_sn"];
            [SSPublicNetWorkTool postPayOrderWithOrder_sn:kMeUnNilStr(strongSelf->_order_sn) successBlock:^(ZLRequestResponse *responseObject) {
                kMeSTRONGSELF
                PAYPRE
                strongSelf->_isPayError= NO;
                SSPayModel *model = [SSPayModel mj_objectWithKeyValues:responseObject.data];
                CGFloat f = [strongSelf->_goodModel.money floatValue] * (strongSelf->_goodModel.buynum);
                BOOL isSucess =  [LVWxPay wxPayWithPayModel:model VC:strongSelf price:@(f).description];
                if(!isSucess){
                    [SSShowViewTool showMessage:@"支付错误" view:kMeCurrentWindow];
                }
            } failure:^(id object) {
                
            }];
        } failure:^(id object) {
            
        }];
    }

}

#pragma mark - Getter

- (SSMakeOrderSelectAddressView *)sAddressView{
    if(!_sAddressView){
        _sAddressView = [[[NSBundle mainBundle]loadNibNamed:@"SSMakeOrderSelectAddressView" owner:nil options:nil] lastObject];
        _sAddressView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kSSMakeOrderSelectAddressViewHeight);
        kMeWEAKSELF
        _sAddressView.selectAddressBlock = ^{
            kMeSTRONGSELF
            [strongSelf selectAddress];
        };
    }
    return _sAddressView;
}
- (UIView *)notAddressView{
    if(!_notAddressView){
        _notAddressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSSMakeOrderSelectAddressViewHeight)];
        
        UIImageView *img = [[UIImageView alloc]initWithImage:kMeGetAssetImage(@"inco-yytmtmda")];
        [_notAddressView addSubview:img];
        kMeWEAKSELF
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            kMeSTRONGSELF
            make.right.equalTo(strongSelf->_notAddressView).offset(-15);
            make.width.equalTo(@(7));
            make.height.equalTo(@(13));
            make.centerY.equalTo(strongSelf->_notAddressView);
        }];
        UILabel *lbl = [[UILabel alloc]init];
        [_notAddressView addSubview:lbl];
        lbl.text = @"请填写您的地址信息";
        lbl.font = kMeFont(15);
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            kMeSTRONGSELF
            make.right.equalTo(img).offset(-15);
            make.left.equalTo(strongSelf->_notAddressView).offset(15);
            make.centerY.equalTo(strongSelf->_notAddressView);
        }];
        _notAddressView.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAddress:)];
        [_notAddressView addGestureRecognizer:ges];
    }
    return _notAddressView;
}

#pragma mark - Setter

@end
