//
//  SSCoupleHomeMainContentCell.m
//  SunSum
//
//  Created by hank on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCoupleHomeMainContentCell.h"
#import "SSCoupleModel.h"

@interface SSCoupleHomeMainContentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblLinePrice;

@end

@implementation SSCoupleHomeMainContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblPrice.adjustsFontSizeToFitWidth = YES;
    _lblLinePrice.adjustsFontSizeToFitWidth = YES;
    self.backgroundColor = kSSfbfbfb;
    // Initialization code
}

- (void)setUIWIthModel:(SSCoupleModel *)model{
    [_imgPic sd_setImageWithURL:[NSURL URLWithString:kMeUnNilStr(model.pict_url)] placeholderImage:kImgPlaceholder];
    _lblTitle.text = kMeUnNilStr(model.title);
    NSString *commStr = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.zk_final_price).floatValue)];
    [_lblLinePrice setLineStrWithStr:commStr];
    _lblPrice.text = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.truePrice).floatValue)];

    
}

@end
