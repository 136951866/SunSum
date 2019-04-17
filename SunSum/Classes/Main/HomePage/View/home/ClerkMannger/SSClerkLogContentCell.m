//
//  SSClerkLogContentCell.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkLogContentCell.h"
#import "SSNewClerkManngerModel.h"

@interface SSClerkLogContentCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end

@implementation SSClerkLogContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWIthModel:(SSNewClerkManngerClerkTaskclientModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 服务于%@",kMeUnNilStr(model.nick_name),kMeUnNilStr(model.service_at)]];
    NSUInteger firstLoc = [[aString string] rangeOfString:@" "].location + 1;
    NSUInteger secondLoc = aString.length;
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    [aString addAttribute:NSForegroundColorAttributeName value:kSS999999 range:range];
    [aString addAttribute:NSFontAttributeName value:kMeFont(9) range:range];
    _lblContent.attributedText = aString;
}

@end
