//
//  SSClerkPlanAchieveHomeCell.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkPlanAchieveHomeCell.h"
#import "QLCycleProgressView.h"
#import "SSClerkPlanAchieveClerkHeaderModel.h"

@interface SSClerkPlanAchieveHomeCell ()

@property (weak, nonatomic) IBOutlet UIView *viewForProgress;
@property (weak, nonatomic) IBOutlet UILabel *lblAchieveed;
@property (weak, nonatomic) IBOutlet UILabel *lblAchieveNot;

@property (strong, nonatomic) QLCycleProgressView *progressView;

@end

@implementation SSClerkPlanAchieveHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    [_viewForProgress addSubview:self.progressView];
}

- (void)setUIWIthModel:(SSClerkPlanAchieveClerkHeaderModel *)model{
    CGFloat rate = (CGFloat)((CGFloat)(model.finish_task)/(CGFloat)(model.total_task));
    self.progressView.progress = rate;
    self.progressView.content = [NSString stringWithFormat:@"全部任务:%@",@(model.total_task).description];
    _lblAchieveed.text = @(model.finish_task).description;
    _lblAchieveNot.text = @(model.unfinish_task).description;
}

- (QLCycleProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[QLCycleProgressView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, 221)];
        _progressView.mainColor = [UIColor colorWithHexString:@"7c68ff"];
        _progressView.content = @"全部任务:0";
    }
    return _progressView;
}

@end
