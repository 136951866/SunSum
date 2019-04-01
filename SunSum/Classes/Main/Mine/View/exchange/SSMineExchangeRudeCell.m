//
//  SSMineExchangeRudeCell.m
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMineExchangeRudeCell.h"

#define kFontOfTitle [UIFont systemFontOfSize:12]
#define kSSMineExchangeRudeCellRLMargin (15)
#define kSSMineExchangeRudeCellTBMargin (20)
#define kWidthOflblContent (SCREEN_WIDTH - (kSSMineExchangeRudeCellRLMargin*2))


@interface SSMineExchangeRudeCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation SSMineExchangeRudeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setUIWithModel:(id)model{
    _lblTitle.text = model;
    _consTitleHeight.constant = [NSAttributedString heightForAtsWithStr:kMeUnNilStr(model) font:kFontOfTitle width:kWidthOflblContent lineH:1 maxLine:0];
    [_lblTitle setAtsWithStr:kMeUnNilStr(model) lineGap:0];
}

+ (CGFloat)getCellHeight:(NSString *)title{
    CGFloat height = kSSMineExchangeRudeCellTBMargin;
    height += [NSAttributedString heightForAtsWithStr:kMeUnNilStr(title) font:kFontOfTitle width:kWidthOflblContent lineH:1 maxLine:0];
    return height;
}

@end
