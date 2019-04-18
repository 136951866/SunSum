//
//  SSClerkWorkStatisticsServerLogHeaderModel.h
//  SunSum
//
//  Created by hank on 2019/4/18.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkWorkStatisticsServerLogHeaderModel : SSBaseModel

@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger finish;
@property (nonatomic, assign) NSInteger finishOnTime;
@property (nonatomic, strong) NSString *finish_percent;
@property (nonatomic, strong) NSString * finishOnTime_percent;

@end

NS_ASSUME_NONNULL_END
