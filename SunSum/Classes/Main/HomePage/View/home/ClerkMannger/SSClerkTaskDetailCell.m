//
//  SSClerkTaskDetailCell.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkTaskDetailCell.h"

@interface SSClerkTaskDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblTask;

@end

@implementation SSClerkTaskDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
}

- (void)setUIWIthModel:(id)model{
    NSString *str = kMeUnNilStr(@"对洒喝点酒洒喝豆浆洒喝豆浆洒喝豆浆洒好的借口大厦酒店会撒娇和第三空间啊好的借口");
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:12] width:(SCREEN_WIDTH- 40) lineH:0];
    _consTitleHeight.constant = sh>15?sh:15;
    [_lblContent setAtsWithStr:kMeUnNilStr(str) lineGap:0];
}
+ (CGFloat)getCellHeightWithModel:(NSObject *)model{
    CGFloat height = kSSClerkTaskDetailCellHeight - 15;
    NSString *str = kMeUnNilStr(@"对洒喝点酒洒喝豆浆洒喝豆浆洒喝豆浆洒好的借口大厦酒店会撒娇和第三空间啊好的借口");
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:12] width:(SCREEN_WIDTH-50) lineH:0];
    height += sh>15?sh:15;
    return height;
}

@end
