//
//  SSClerkTaskContentCell.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkTaskContentCell.h"

@interface SSClerkTaskContentCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;


@end

@implementation SSClerkTaskContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWIthModel:(id)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(kCurrentUser.header_pic));
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 任务完成%@",kMeUnNilStr(kCurrentUser.name),@"50%"]];
    NSUInteger firstLoc = [[aString string] rangeOfString:@"成"].location + 1;
    NSUInteger secondLoc = aString.length;
//    [[aString string] rangeOfString:@"元"].location;
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    [aString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"108EE9"] range:range];
    // 改变字体大小及类型
//    [aString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:27] range:range];
    _lblContent.attributedText = aString;
}

@end
