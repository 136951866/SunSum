//
//  SSClerkTaskContentCell.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkTaskContentCell.h"
#import "SSNewClerkManngerModel.h"

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

- (void)setUIWIthModel:(SSNewClerkManngerClerkTaskpercentModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 任务完成%@",kMeUnNilStr(model.name),kMeUnNilStr(model.finish_percent)]];
    NSUInteger firstLoc = [[aString string] rangeOfString:@"成"].location + 1;
    NSUInteger secondLoc = aString.length;
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    [aString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"108EE9"] range:range];
    _lblContent.attributedText = aString;
}

@end
