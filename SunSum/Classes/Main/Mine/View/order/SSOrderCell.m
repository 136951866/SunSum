//
//  SSOrderCell.m
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSOrderCell.h"
#import "SSOrderModel.h"
#import "SSMyChildOrderContentCell.h"
#import "SSMyOrderVC.h"
#import "SSMyOrderDetailVC.h"
//#import "SSLogisticsVC.h"
#import "SSMySelfExtractionOrderVC.h"

@interface SSOrderCell ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrType;
    SSOrderModel *_model;
    SSOrderStyle _type;
    //yes 未自提
    BOOL _isSelf;
}

@property (weak, nonatomic) IBOutlet UILabel *lblOrderNum;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelOrder;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTableViewHeight;


@end

@implementation SSOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _arrType = SSOrderStyleTitle;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMyChildOrderContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSMyChildOrderContentCell class])];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _tableView.rowHeight = kSSMyChildOrderContentCellHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    // Initialization code
}

- (void)setUIWithModel:(SSOrderModel *)model Type:(SSOrderStyle)type{
    _isSelf = NO;
    _type = type;
    _consTableViewHeight.constant =  (kSSMyChildOrderContentCellHeight * kMeUnArr(model.children).count);
    _model = model;
    _btnCancelOrder.hidden = type!=SSAllNeedPayOrder;
    //|| type == SSAllNeedReceivedOrder ||type == SSAllFinishOrder
    if(type == SSAllNeedPayOrder  ){
        _btnPay.hidden = NO;
    }else{
        _btnPay.hidden = YES;
    }
//    if(type == SSAllNeedPayOrder){
//        [_btnPay setTitle:@"立即支付" forState:UIControlStateNormal];
//    }
//    else{
//        [_btnPay setTitle:@"查看物流" forState:UIControlStateNormal];
//    }
    _lblOrderNum.text = kMeUnNilStr(model.order_sn);
    [self.tableView reloadData];
}

- (void)setSelfUIWithModel:(SSOrderModel *)model{
    _isSelf = YES;
    _consTableViewHeight.constant =  (kSSMyChildOrderContentCellHeight * kMeUnArr(model.children).count);
    _model = model;
    _btnCancelOrder.hidden = YES;
    _btnPay.hidden = YES;
    _lblOrderNum.text = kMeUnNilStr(model.order_sn);
    [self.tableView reloadData];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kMeUnArr(_model.children).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSMyChildOrderContentCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSMyChildOrderContentCell class]) forIndexPath:indexPath];
    SSOrderGoodModel *model = kMeUnArr(_model.children)[indexPath.row];
    if(_isSelf){
        [cell setSelfUIWithModel:model extractStatus:_model.get_status];
    }else{
        [cell setUIWithModel:model];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(_isSelf){
        if(_touchBlock){
            kMeCallBlock(_touchBlock);
            return;
        }
        SSMySelfExtractionOrderVC *orderVC = (SSMySelfExtractionOrderVC *)[SSCommonTool getVCWithClassWtihClassName:[SSMySelfExtractionOrderVC class] targetResponderView:self];
        SSMyOrderDetailVC *vc = [[SSMyOrderDetailVC alloc]initSelfWithType:[_model.order_status integerValue] orderGoodsSn:kMeUnNilStr(_model.order_sn)];
        [orderVC.navigationController pushViewController:vc animated:YES];
    }else{
        SSMyOrderVC *orderVC = (SSMyOrderVC *)[SSCommonTool getVCWithClassWtihClassName:[SSMyOrderVC class] targetResponderView:self];
        SSMyOrderDetailVC *vc = [[SSMyOrderDetailVC alloc]initWithType:[_model.order_status integerValue] orderGoodsSn:kMeUnNilStr(_model.order_sn)];
        [orderVC.navigationController pushViewController:vc animated:YES];
    }

}

- (IBAction)payAction:(UIButton *)sender {
    SSMyOrderVC *orderVC = (SSMyOrderVC *)[SSCommonTool getVCWithClassWtihClassName:[SSMyOrderVC class] targetResponderView:self];
    if(orderVC){
        if(_type==SSAllNeedPayOrder){
            SSMyOrderDetailVC *vc = [[SSMyOrderDetailVC alloc]initWithType:[_model.order_status integerValue] orderGoodsSn:kMeUnNilStr(_model.order_sn)];
            [orderVC.navigationController pushViewController:vc animated:YES];
        }else if (_type == SSAllNeedReceivedOrder){
//            SSLogisticsVC*vc  = [[SSLogisticsVC alloc]initWithOrderGoodsSn:kMeUnNilStr(_model.order_sn)];
//            [orderVC.navigationController pushViewController:vc animated:YES];
        }else if (_type == SSAllFinishOrder){
//            SSLogisticsVC*vc  = [[SSLogisticsVC alloc]initWithOrderGoodsSn:kMeUnNilStr(_model.order_sn)];
//            [orderVC.navigationController pushViewController:vc animated:YES];
        }else{
            
        }
    }
}

- (IBAction)cancelOrderAction:(UIButton *)sender {
    SSAlertView *aler = [[SSAlertView alloc] initWithTitle:@"" message:@"确定要取消该订单吗?"];
    [aler addButtonWithTitle:@"取消"];
    kMeWEAKSELF
    [aler addButtonWithTitle:@"确定" block:^{
        kMeSTRONGSELF
        [SSPublicNetWorkTool postDelOrderWithOrderSn:strongSelf->_model.order_sn successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            kMeCallBlock(strongSelf->_cancelOrderBlock);
            kNoticeReloadOrder
        } failure:nil];
    }];
    [aler show];
}

+ (CGFloat)getCellHeightWithModel:(SSOrderModel *)model Type:(SSOrderStyle)type{
    CGFloat height;
    //|| type==SSAllNeedReceivedOrder || type==SSAllFinishOrder
    if(type==SSAllNeedPayOrder ){
         height = (kSSMyChildOrderContentCellHeight * kMeUnArr(model.children).count) +kSSOrderCellNeedPayBtnHeight;
    }else{
         height = (kSSMyChildOrderContentCellHeight * kMeUnArr(model.children).count) +kSSOrderCellNoPayedBtnHeight;
    }
    return height;
}

+ (CGFloat)getCellSelfHeightWithModel:(SSOrderModel *)model{
    CGFloat height;
    height = (kSSMyChildOrderContentCellHeight * kMeUnArr(model.children).count) +kSSOrderCellNoPayedBtnHeight;
    return height;
}

@end
