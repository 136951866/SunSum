//
//  SSClerkOperationDailyModel.h
//  SunSum
//
//  Created by hank on 2019/4/18.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkOperationDailydailyWorkReportModel : SSBaseModel

@property (nonatomic, assign) NSInteger new_customer;
@property (nonatomic, assign) NSInteger potential_customer;
@property (nonatomic, assign) NSInteger Intention_customer;
@property (nonatomic, assign) NSInteger regular_customer;

@end

@interface SSClerkOperationDailylogCompletionModel : SSBaseModel
@property (nonatomic, assign) NSInteger today_task_total;
@property (nonatomic, assign) NSInteger today_task_finish;
@end

@interface SSClerkOperationDailyModel : SSBaseModel
@property (nonatomic, strong) SSClerkOperationDailydailyWorkReportModel * dailyWorkReport;
@property (nonatomic, strong) SSClerkOperationDailylogCompletionModel * logCompletion;

@end

NS_ASSUME_NONNULL_END
