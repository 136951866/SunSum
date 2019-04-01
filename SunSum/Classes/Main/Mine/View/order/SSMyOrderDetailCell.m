//
//  SSMyOrderDetailCell.m
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMyOrderDetailCell.h"

@interface SSMyOrderDetailCell (){
    NSArray *_arrTitle;
    NSArray *_arrAppointTitle;
}

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFristBuy;

@end

@implementation SSMyOrderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _arrTitle = SSOrderSettlmentStyleTitle;
    _arrAppointTitle = SSAppointmentSettlmentStyleTitle;
    // Initialization code
}

- (void)setUIWithModel:(NSString *)title Type:(SSOrderSettlmentStyle)type orderType:(SSOrderStyle)orderType{
    _lblFristBuy.hidden = YES;
    _lblTitle.text = _arrTitle[type];
    if(orderType == SSAllNeedPayOrder && type == SSSettlmemtRealPay){
        _lblTitle.text = @"应付金额";
    }
    _lblSubTitle.text = title;
}

- (void)setAppointUIWithModel:(id)title appointType:(SSAppointmentSettlmentStyle)type orderType:(SSAppointmenyStyle)orderType;{
    if(type == SSAppointmentSettlmentFristBuy){
        _lblFristBuy.hidden = NO;
        _lblTitle.hidden = YES;
        _lblSubTitle.hidden = YES;
        _lblFristBuy.text = _arrAppointTitle[type];
    }else{
        _lblFristBuy.hidden = YES;
        _lblTitle.hidden = NO;
        _lblSubTitle.hidden = NO;
        _lblTitle.text = _arrAppointTitle[type];
        _lblSubTitle.text = title;
    }

}
@end
