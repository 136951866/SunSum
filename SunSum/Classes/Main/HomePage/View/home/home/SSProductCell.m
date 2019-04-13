//
//  SSProductCell.m
//  SunSum
//
//  Created by hank on 2018/9/7.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSProductCell.h"
#import "SSGoodModel.h"

#define kLblWdith (37 * kMeFrameScaleX())

@interface SSProductCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conlblWdith;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblIntergal;
@property (weak, nonatomic) IBOutlet UIButton *btnAppoint;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;

@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;


@end

@implementation SSProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _conlblWdith.constant = kLblWdith;
    _lblPrice.adjustsFontSizeToFitWidth = YES;
    _lblIntergal.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWithModel:(SSGoodModel *)model WithKey:(NSString *)key{
    [self setUIWithModel:model];
    if(kMeUnNilStr(key).length>0){
        _lblTitle.text = nil;
        _lblTitle.attributedText = [kMeUnNilStr(model.title) attributeWithRangeOfString:key color:kSSPink];
    }
}

- (void)setUIWithModel:(SSGoodModel *)model{
    _lblSubTitle.hidden = YES;
    _btnAppoint.hidden = YES;
    _imgIcon.hidden = NO;
    _lblIntergal.hidden = NO;
    [_imgPic sd_setImageWithURL:[NSURL URLWithString:SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.images))] placeholderImage:kImgPlaceholder];
    _lblPrice.text = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.market_price).floatValue)];
    _lblIntergal.text = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.money).floatValue)];
    _lblTitle.text = kMeUnNilStr(model.title);
}

- (void)setServiceUIWithModel:(SSGoodModel *)model{
    _lblSubTitle.hidden = YES;
     _btnAppoint.hidden = NO;
    _imgIcon.hidden = YES;
    _lblIntergal.hidden = YES;
    [_imgPic sd_setImageWithURL:[NSURL URLWithString:SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.images))] placeholderImage:kImgPlaceholder];
    _lblPrice.text = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.market_price).floatValue)];
    _lblIntergal.text = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.money).floatValue)];
    _lblTitle.text = kMeUnNilStr(model.title);
}
@end
