//
//  SSEditClerkLogCell.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSEditClerkLogCell.h"

@interface SSEditClerkLogCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end

@implementation SSEditClerkLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (IBAction)notciAction:(UIButton *)sender {
    kMeCallBlock(_notichBlock);
}

- (IBAction)markAction:(UIButton *)sender {
    kMeCallBlock(_markBlock);
}


- (void)setUIWIthModel:(id)model{
    NSString *str = kMeUnNilStr(@"对洒喝点酒洒喝豆浆洒喝豆浆洒喝豆浆洒好的借口大厦酒店会撒娇和第三空间啊好的借口");
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH-50) lineH:0];
    _consTitleHeight.constant = sh>17?sh:17;
    [_lblContent setAtsWithStr:kMeUnNilStr(str) lineGap:0];
}

+ (CGFloat)getCellHeightWithModel:(NSObject *)model{
    CGFloat height = kSSEditClerkLogCellHeight - 17;
    NSString *str = kMeUnNilStr(@"对洒喝点酒洒喝豆浆洒喝豆浆洒喝豆浆洒好的借口大厦酒店会撒娇和第三空间啊好的借口");
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH-50) lineH:0];
    height += sh>17?sh:17;
    return height;
}





@end
