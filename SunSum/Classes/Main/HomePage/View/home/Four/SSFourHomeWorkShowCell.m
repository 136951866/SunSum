//
//  SSFourHomeWorkShowCell.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSFourHomeWorkShowCell.h"
#import "SSFourHomeModel.h"

@interface SSFourHomeWorkShowCell (){
    CGFloat _cellWidth;
}


@property (weak, nonatomic) IBOutlet UILabel *lblPerShare;
@property (weak, nonatomic) IBOutlet UILabel *lblPerFol;
@property (weak, nonatomic) IBOutlet UILabel *lblPerTaskCount;
@property (weak, nonatomic) IBOutlet UILabel *lblPermember;

@property (weak, nonatomic) IBOutlet UILabel *lblPerTodayShare;
@property (weak, nonatomic) IBOutlet UILabel *lblPerTodayFoll;
@property (weak, nonatomic) IBOutlet UILabel *lblPertodayTask;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblPerRate;
@property (weak, nonatomic) IBOutlet UILabel *lblPerRateStr;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblFinRare;
@property (weak, nonatomic) IBOutlet UILabel *lblFinRateStr;




@property (weak, nonatomic) IBOutlet UILabel *lblJobTaskFinish;
@property (weak, nonatomic) IBOutlet UILabel *lblJobTaskTodayFinish;
@property (weak, nonatomic) IBOutlet UILabel *lblJobFinishRate;
@property (weak, nonatomic) IBOutlet UILabel *lblJobTaskTodayFinishRate;



@property (weak, nonatomic) IBOutlet UILabel *lblJobServerCount;
@property (weak, nonatomic) IBOutlet UILabel *lblJobServerStr;


@end

@implementation SSFourHomeWorkShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _cellWidth = SCREEN_WIDTH - 48;
    // Initialization code
}

- (void)setUIWithModel:(SSFourHomeModel *)model{
    
    _lblPerShare.text = @(model.jobPerformance.share_count).description;
    _lblPerFol.text = @(model.jobPerformance.follow_up_count).description;
    _lblPerTaskCount.text = @(model.jobPerformance.task_count).description;
    _lblPermember.text = @(model.jobPerformance.follow_up_member_count).description;
    _lblPerTodayShare.text = @(model.jobPerformance.today_share_count).description;
    _lblPerTodayFoll.text = @(model.jobPerformance.today_follow_up_count).description;
    _lblPertodayTask.text = @(model.jobPerformance.today_finished_task).description;
    
    CGFloat rate = 0;
    if(model.jobPerformance.today_task_finished_percent.today_task_total !=0){
        rate = (CGFloat)((CGFloat)model.jobPerformance.today_task_finished_percent.today_task_finish
                                 /(CGFloat)model.jobPerformance.today_task_finished_percent.today_task_total);
    }
    NSInteger ratenum = rate * _cellWidth;
    if(ratenum<0){
        ratenum = 0;
    }
    NSInteger ratenumStr = rate * 100;
    _lblPerRate.constant = ratenum;
    _lblPerRateStr.text = [@(ratenumStr).description stringByAppendingString:@"%"];;
    
    
    
    CGFloat rateFin = 0;
    if(model.clerkTaskFinishState.total_task != 0){
        rateFin = (CGFloat)((CGFloat)model.clerkTaskFinishState.finish_task
                                    /(CGFloat)model.clerkTaskFinishState.total_task);
    }
    NSInteger ratenumFin = rateFin * _cellWidth;
    if(ratenumFin<0){
        ratenumFin = 0;
    }
    NSInteger ratenumStrFin = rateFin * 100;
    _lblFinRare.constant = ratenumFin;
    _lblFinRateStr.text = [@(ratenumStrFin).description stringByAppendingString:@"%"];;
    
    
    
    
    //完成率
    CGFloat rateJobF = 0;
    if(model.jobAccount.total !=0){
        rateJobF = (CGFloat)((CGFloat)model.jobAccount.finish_task_count
                         /(CGFloat)model.jobAccount.total);
    }
    if(rateJobF<0){
        rateJobF = 0;
    }
    NSInteger rateJobFStr = rateJobF * 100;
    _lblJobTaskFinish.text = [@(rateJobFStr).description stringByAppendingString:@"%"];
    _lblJobFinishRate.text = [NSString stringWithFormat:@"完成率(%@/%@)",@(model.jobAccount.finish_task_count),@(model.jobAccount.total)];
    
    
    //当天完成率
    CGFloat rateJobtF = 0;
    if(model.jobAccount.today_task_finished_percent.today_task_total !=0){
        rateJobtF = (CGFloat)((CGFloat)model.jobAccount.today_task_finished_percent.today_task_finish
                             /(CGFloat)model.jobAccount.today_task_finished_percent.today_task_total);
    }
    if(rateJobtF<0){
        rateJobtF = 0;
    }
    NSInteger rateJobtFStr = rateJobtF * 100;
    _lblJobTaskTodayFinish.text = [@(rateJobtFStr).description stringByAppendingString:@"%"];
    _lblJobTaskTodayFinishRate.text = [NSString stringWithFormat:@"当天完成率(%@/%@)",@(model.jobAccount.today_task_finished_percent.today_task_finish),@(model.jobAccount.today_task_finished_percent.today_task_total)];
    
    
    
    [self layoutIfNeeded];
}

- (IBAction)planAchieveAction:(UIButton *)sender {
    kMeCallBlock(_planAchieveBlock);
}

- (IBAction)workFinishAction:(UIButton *)sender {
    kMeCallBlock(_workFinishBlock);
}





@end
