//
//  SSWebTitleCell.m
//  SunSum
//
//  Created by hank on 2018/12/4.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSWebTitleCell.h"
#import "SSArticelDetailModel.h"

@interface SSWebTitleCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consHeight;

@end

@implementation SSWebTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUiWithModel:(SSArticelDetailModel *)model{
//    _lblTitle.text = kMeUnNilStr(model.title);
    _lblAuthor.text = kMeUnNilStr(model.author);
    _consHeight.constant = [NSAttributedString heightForAtsWithStr:kMeUnNilStr(model.title) font:[UIFont systemFontOfSize:17] width:(SCREEN_WIDTH -20) lineH:0 maxLine:0];
    [_lblTitle setAtsWithStr:kMeUnNilStr(model.title) lineGap:0];
}

+ (CGFloat)getCellHeightWithModel:(SSArticelDetailModel *)model{
    CGFloat titleHeight = 20;
    CGFloat viewHeight = 66-titleHeight;
    CGFloat titleRealHeight = [NSAttributedString heightForAtsWithStr:kMeUnNilStr(model.title) font:[UIFont systemFontOfSize:17] width:(SCREEN_WIDTH -20) lineH:0 maxLine:0];
    CGFloat height = (viewHeight + titleRealHeight)>66?(viewHeight + titleRealHeight):66;
    return height;
    
}


@end
