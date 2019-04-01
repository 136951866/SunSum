//
//  SSDistrbutionCell.m
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSDistrbutionCell.h"

@interface SSDistrbutionCell(){
    NSArray *_arrImage;
    NSArray *_arrTitle;

}
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;

@end

@implementation SSDistrbutionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _arrImage = SSDistrbutionCellStyleImage;
    _arrTitle = SSDistrbutionCellStyleTitle;
    // Initialization code
}

- (void)setUIWithtype:(SSDistrbutionCellStyle)type subtitle:(NSString *)subTitle{
    _lblSubTitle.hidden = type == SSMyCode;
    _imgPic.image = kMeGetAssetImage(_arrImage[type]);
    _lblTitle.text = _arrTitle[type];
    _lblSubTitle.text = kMeUnNilStr(subTitle);
}

@end
