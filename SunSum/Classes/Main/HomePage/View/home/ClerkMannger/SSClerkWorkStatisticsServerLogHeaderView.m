//
//  SSClerkWorkStatisticsServerLogHeaderView.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkWorkStatisticsServerLogHeaderView.h"
#import "SSClerkWorkStatisticsServerLogHeaderModel.h"
#import "SSClerkWorkStatisticsServerLogHeaderModel.h"

@interface SSClerkWorkStatisticsServerLogHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *lblfinishPercent;
@property (weak, nonatomic) IBOutlet UILabel *lblontimePrcent;
@property (weak, nonatomic) IBOutlet UILabel *lblf;
@property (weak, nonatomic) IBOutlet UILabel *lblontime;


@end

@implementation SSClerkWorkStatisticsServerLogHeaderView

- (void)setUiWIthModel:(SSClerkWorkStatisticsServerLogHeaderModel *)model{
    _lblfinishPercent.text = kMeUnNilStr(model.finish_percent);
    _lblontimePrcent.text = kMeUnNilStr(model.finishOnTime_percent);
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"完成度 (%@/%@)",@(model.finish),@(model.total)]];
    NSUInteger firstLoc = [[aString string] rangeOfString:@" "].location + 1;
    NSUInteger secondLoc = aString.length;
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    [aString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FECEAA"] range:range];
    [aString addAttribute:NSFontAttributeName value:kMeFont(9) range:range];
    _lblf.attributedText = aString;
    
    
    NSMutableAttributedString *bString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"准时完成度 (%@/%@)",@(model.finishOnTime),@(model.total)]];
    NSUInteger bfirstLoc = [[bString string] rangeOfString:@" "].location + 1;
    NSUInteger bsecondLoc = bString.length;
    NSRange brange = NSMakeRange(bfirstLoc, bsecondLoc - bfirstLoc);
    [bString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FECEAA"] range:brange];
    [bString addAttribute:NSFontAttributeName value:kMeFont(9) range:brange];
    _lblontime.attributedText = bString;
 
    
}

@end
