//
//  SSClerkPlanAchieveClerkHeaderModel.h
//  SunSum
//
//  Created by hank on 2019/4/17.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkPlanAchieveClerkHeaderModel : SSBaseModel

@property (nonatomic, assign) NSInteger finish_task;
@property (nonatomic, assign) NSInteger unfinish_task;
@property (nonatomic, assign) NSInteger total_task;

@end

NS_ASSUME_NONNULL_END
