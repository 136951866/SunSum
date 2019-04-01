//
//  SSMoneyDetailedCell.m
//  SunSum
//
//  Created by hank on 2018/9/26.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMoneyDetailedCell.h"
#import "SSMoneyDetailedModel.h"

@interface SSMoneyDetailedCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@end

@implementation SSMoneyDetailedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblPrice.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWithModel:(SSMoneyDetailedModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.member.header_pic));
    _lblTitle.text = kMeUnNilStr(model.member.name);
    _lblTime.text = kMeUnNilStr(model.updated_at);
    _lblPrice.text = [NSString stringWithFormat:@"获得金额:%@",kMeUnNilStr(model.money)];
}

@end
