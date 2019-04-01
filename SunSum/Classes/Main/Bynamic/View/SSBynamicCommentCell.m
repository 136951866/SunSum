//
//  SSBynamicCommentCell.m
//  SunSum
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBynamicCommentCell.h"
#import "SSBynamicHomeModel.h"

#define kSSBynamicCommentCellMagin (10+36+10+10+10+10)

@interface SSBynamicCommentCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;

@end

@implementation SSBynamicCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
//    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, self.bounds.size.width);
    // Initialization code
}

- (void)setUIWithModel:(SSBynamicHomecommentModel *)model{
    NSString *str = [NSString stringWithFormat:@"%@:%@",kMeUnNilStr(model.nick_name),kMeUnNilStr(model.content)];
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:SCREEN_WIDTH-kSSBynamicCommentCellMagin lineH:0 maxLine:0];
    _consTitleHeight.constant = titleHeight>17?titleHeight:17;
//    [_lblTitle setAtsWithStr:str lineGap:0];
    _lblTitle.text = nil;
    _lblTitle.lineBreakMode = UILineBreakModeCharacterWrap;
    _lblTitle.attributedText = [str attributeWithRangeOfString:[NSString stringWithFormat:@"%@:",kMeUnNilStr(model.nick_name)] color:kSS466889];
    
}

+ (CGFloat)getCellHeightWithhModel:(SSBynamicHomecommentModel *)model{
    CGFloat height = 8;
    NSString *str = [NSString stringWithFormat:@"%@:%@",kMeUnNilStr(model.nick_name),kMeUnNilStr(model.content)];
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:SCREEN_WIDTH-kSSBynamicCommentCellMagin lineH:0 maxLine:0];
    height+=titleHeight>17?titleHeight:17;
    return height;
}



@end
