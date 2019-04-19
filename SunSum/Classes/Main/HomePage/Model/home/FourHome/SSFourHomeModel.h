//
//  SSFourHomeModel.h
//  SunSum
//
//  Created by hank on 2019/4/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSFourHomejobPerformancepercentModel : SSBaseModel

@property (nonatomic, assign) NSInteger today_task_total;
@property (nonatomic, assign) NSInteger today_task_finish;


@end

@interface SSFourHomejobPerformanceModel : SSBaseModel

@property (nonatomic, assign) NSInteger share_count;
@property (nonatomic, assign) NSInteger follow_up_count;
@property (nonatomic, assign) NSInteger task_count;
@property (nonatomic, assign) NSInteger follow_up_member_count;
@property (nonatomic, assign) NSInteger today_share_count;
@property (nonatomic, assign) NSInteger today_follow_up_count;
@property (nonatomic, assign) NSInteger today_finished_task;
@property (nonatomic, strong) SSFourHomejobPerformancepercentModel *today_task_finished_percent;

@end

@interface SSFourHomeclerkTaskFinishStateModel : SSBaseModel

@property (nonatomic, assign) NSInteger finish_task;
@property (nonatomic, assign) NSInteger unfinish_task;
@property (nonatomic, assign) NSInteger total_task;

@end

@interface SSFourHomejobAccountModel : SSBaseModel

@property (nonatomic, assign) NSInteger client_total;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger finish_task_count;
@property (nonatomic, assign) NSInteger reservation_count;
@property (nonatomic, assign) NSInteger reservation_num;
@property (nonatomic, strong) NSString *reservation_percent;
@property (nonatomic, strong) SSFourHomejobPerformancepercentModel *today_task_finished_percent;

@end

@interface SSFourHomeModel : SSBaseModel

@property (nonatomic, strong) SSFourHomeclerkTaskFinishStateModel * clerkTaskFinishState;
@property (nonatomic, strong) SSFourHomejobAccountModel * jobAccount;
@property (nonatomic, strong) SSFourHomejobPerformanceModel * jobPerformance;

@end

NS_ASSUME_NONNULL_END
