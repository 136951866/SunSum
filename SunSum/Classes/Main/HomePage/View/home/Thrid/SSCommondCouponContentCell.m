//
//  SSCommondCouponContentCell.m
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCommondCouponContentCell.h"
#import "SSPinduoduoCoupleModel.h"

@interface SSCommondCouponContentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblJuan;


@end

@implementation SSCommondCouponContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblPrice.adjustsFontSizeToFitWidth = YES;
    _lblJuan.adjustsFontSizeToFitWidth = YES;
}

- (void)setUIWithModel:(SSPinduoduoCoupleModel *)model{
     [_imgPic sd_setImageWithURL:[NSURL URLWithString:kMeUnNilStr(model.goods_thumbnail_url)] placeholderImage:kImgPlaceholder];
    _lblPrice.text = [NSString stringWithFormat:@"¥%@", [SSCommonTool changeformatterWithFen:@(model.min_group_price)]];
    _lblJuan.text = [NSString stringWithFormat:@"%@元券",[SSCommonTool changeformatterWithFen:@(model.coupon_discount)]];
}

@end
