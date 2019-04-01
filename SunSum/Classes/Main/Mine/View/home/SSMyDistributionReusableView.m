//
//  SSMyDistributionReusableView.m
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMyDistributionReusableView.h"
#import "SSDistributionCentreModel.h"
#import "SSadminDistributionModel.h"

@interface SSMyDistributionReusableView()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblCommandName;
@property (weak, nonatomic) IBOutlet UILabel *lblBeautDean;
@property (weak, nonatomic) IBOutlet UILabel *lblUsedBean;
@property (weak, nonatomic) IBOutlet UILabel *lblNotUseBean;

@property (weak, nonatomic) IBOutlet UILabel *lblBeautDeanTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblUsedBeanTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblNotUsedBeanTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnCase;

@end

@implementation SSMyDistributionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUIWithModel:(SSDistributionCentreModel *)model{
    _btnCase.hidden = YES;
    kSDLoadImg(_imgPic, kMeUnNilStr(kCurrentUser.header_pic));
    _lblName.text = kMeUnNilStr(kCurrentUser.name);
    _lblCommandName.text = [NSString stringWithFormat:@"推荐人:%@",kMeUnNilStr(model.parent_name)];
    _lblBeautDean.text = [NSString stringWithFormat:@"%@",@(model.integral)];
    _lblUsedBean.text = [NSString stringWithFormat:@"%@",@(model.use_integral)];
    _lblNotUseBean.text = [NSString stringWithFormat:@"%@",@(model.wait_integral)];
}

- (void)setUIBWithModel:(SSadminDistributionModel *)model{
    _btnCase.hidden = NO;
    _lblBeautDeanTitle.text = @"可使用佣金";
    _lblUsedBeanTitle.text = @"已结算佣金";
    _lblNotUsedBeanTitle.text = @"未结算佣金";
    _lblCommandName.hidden = YES;
    kSDLoadImg(_imgPic, kMeUnNilStr(kCurrentUser.header_pic));
    _lblName.text = kMeUnNilStr(kCurrentUser.name);
//    _lblCommandName.text = [NSString stringWithFormat:@"推荐人:%@",kMeUnNilStr(model.superior)];
    //可使用佣金
    _lblBeautDean.text = [NSString stringWithFormat:@"%.2f",model.commission_money];
    //已结算佣金
    _lblUsedBean.text = [NSString stringWithFormat:@"%.2f",model.use_money];
    //未结算佣金
    _lblNotUseBean.text = [NSString stringWithFormat:@"%.2f",model.ratio_money];
}

- (IBAction)caseAction:(UIButton *)sender {
    kMeCallBlock(_costBlock);
}

@end
