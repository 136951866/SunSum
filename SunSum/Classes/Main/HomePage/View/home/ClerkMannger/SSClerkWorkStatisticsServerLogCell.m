//
//  SSClerkWorkStatisticsServerLogCell.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkWorkStatisticsServerLogCell.h"
#import "SSClerkWorkStatisticsServerLogModel.h"

@interface SSClerkWorkStatisticsServerLogCell (){
    CGFloat _cellW;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAll;
@property (weak, nonatomic) IBOutlet UILabel *lblFinish;
@property (weak, nonatomic) IBOutlet UILabel *lblfinishPercent;
@property (weak, nonatomic) IBOutlet UILabel *lblOnTime;
@property (weak, nonatomic) IBOutlet UILabel *lblOntimePercent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consRate;


@end

@implementation SSClerkWorkStatisticsServerLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _cellW = SCREEN_WIDTH - 40;
    // Initialization code
}

- (void)setUiWIthMOdel:(SSClerkWorkStatisticsServerLogModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblName.text = kMeUnNilStr(model.nick_name);
    _lblAll.text = [NSString stringWithFormat:@"共计%@个",@(model.total)];
    _lblFinish.text = [NSString stringWithFormat:@"(%@个)",@(model.finish).description];
    _lblfinishPercent.text = kMeUnNilStr(model.finish_percent);
    _lblOnTime.text = [NSString stringWithFormat:@"准时完成日志(%@个)",@(model.finish_on_time).description];
    _lblOntimePercent.text = kMeUnNilStr(model.finish_on_time_percent);
    CGFloat rate = (CGFloat)((CGFloat)model.finish/(CGFloat)model.total);
    NSInteger ratenum = rate * _cellW;
    if(ratenum<0){
        ratenum = 0;
    }
    _consRate.constant = ratenum;
    [self layoutIfNeeded];
}

@end
