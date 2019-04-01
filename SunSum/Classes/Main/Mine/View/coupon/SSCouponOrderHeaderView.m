//
//  SSCouponOrderHeaderView.m
//  SunSum
//
//  Created by hank on 2018/12/27.
//  Copyright © 2018 hank. All rights reserved.
//

#import "SSCouponOrderHeaderView.h"
#import "SSCouponDetailModel.h"

@interface SSCouponOrderHeaderView(){
    
}
//可提现
@property (weak, nonatomic) IBOutlet UILabel *lblCanUserCommsion;
//已结算
@property (weak, nonatomic) IBOutlet UILabel *lblUsedCommsion;
//未结算
@property (weak, nonatomic) IBOutlet UILabel *lblNotUseCommsion;
@property (weak, nonatomic) IBOutlet UILabel *lblGetingCommsion;

@end

@implementation SSCouponOrderHeaderView

- (void)setUIWithModel:(SSCouponDetailModel *)model{
    _lblCanUserCommsion.text = [SSCommonTool changeformatterWithFen:@(model.commission_amount)];
    _lblUsedCommsion.text = [SSCommonTool changeformatterWithFen:@(model.finish_promotion_amount)];
    _lblNotUseCommsion.text = [SSCommonTool changeformatterWithFen:@(model.unfinish_promotion_amount)];
    _lblGetingCommsion.text= [SSCommonTool changeformatterWithFen:@(model.withdrawal)];
}

- (IBAction)touchAction:(UIButton *)sender {
    kMeCallBlock(_block);
}

@end
