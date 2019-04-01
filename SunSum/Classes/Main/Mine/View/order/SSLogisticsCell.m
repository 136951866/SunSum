//
//  SSLogisticsCell.m
//  SunSum
//
//  Created by hank on 2018/10/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSLogisticsCell.h"
#import "SSLogistModel.h"


@interface SSLogisticsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgTip;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTipW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consStatuHeight;



@end

@implementation SSLogisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _consTipW.constant = 70 * kMeFrameScaleX();
    // Initialization code
}

- (void)setUIWIthModel:(SSLogistDataModel *)model isSelect:(BOOL)isSelect{
     NSString *str = kMeUnNilStr(model.context);
    _lblTime.text = kMeUnNilStr(model.ftime);
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:14] width:(SCREEN_WIDTH- (70 * kMeFrameScaleX())) lineH:0];
    _consStatuHeight.constant = sh>17?sh:17;
    [_lblStatus setAtsWithStr:kMeUnNilStr(str) lineGap:0];
    if(isSelect){
        _imgTip.image = [UIImage imageNamed:@"icon-sjrhfaiy"];
        _lblTime.textColor = kSSPink;
        _lblStatus.textColor = kSSPink;
    }else{
        _imgTip.image = [UIImage imageNamed:@"icon-doqcsjrhfaiy"];
        _lblTime.textColor = kSSblack;
        _lblStatus.textColor = kSSblack;
    }
}

+ (CGFloat)getCellHeightWithModel:(SSLogistDataModel *)model{
    CGFloat height = kSSLogisticsCellHeight - 17;
    NSString *str = kMeUnNilStr(model.context);
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:14] width:(SCREEN_WIDTH- (70 * kMeFrameScaleX())) lineH:0];
    height += sh>17?sh:17;
    height = height <kSSLogisticsCellHeight?kSSLogisticsCellHeight:height;
    return height;
}


@end
