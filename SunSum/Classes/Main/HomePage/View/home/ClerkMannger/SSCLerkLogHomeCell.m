//
//  SSCLerkLogHomeCell.m
//  SunSum
//
//  Created by hank on 2019/4/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCLerkLogHomeCell.h"

@interface SSCLerkLogHomeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;

@end

@implementation SSCLerkLogHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithModel:(id)model{
    NSString *str = kMeUnNilStr(@"对洒喝点酒洒喝豆浆洒喝豆浆洒喝豆浆洒好的借口大厦酒店会撒娇和第三空间啊好的借口");
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH-50) lineH:0];
    _consTitleHeight.constant = sh>17?sh:17;
    [_lblContent setAtsWithStr:kMeUnNilStr(str) lineGap:0];
    // 剩 169DFF 完成999999 逾期 FE913C
    // 完成 隐藏btnEdit
}

+ (CGFloat)getCellHeightWithModel:(NSObject *)model{
    CGFloat height = kSSCLerkLogHomeCellHeight - 17;
    NSString *str = kMeUnNilStr(@"对洒喝点酒洒喝豆浆洒喝豆浆洒喝豆浆洒好的借口大厦酒店会撒娇和第三空间啊好的借口");
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH-50) lineH:0];
    height += sh>17?sh:17;
//    完成 -56
    return height;
}
@end
