//
//  SSClerkDiagnosisResultmodel.h
//  SunSum
//
//  Created by hank on 2019/4/17.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkResultthisMonthCustomerCountmodel : SSBaseModel

@property (nonatomic, assign) NSInteger last_month_count;
@property (nonatomic, assign) NSInteger this_month_count;

@end

@interface SSClerkResultthisMonthCustomerGrowthmodel : SSBaseModel

@property (nonatomic, assign) NSInteger new_customer;
@property (nonatomic, assign) NSInteger potential_customer;
@property (nonatomic, assign) NSInteger Intention_customer;
@property (nonatomic, assign) NSInteger regular_customer;

@end

@interface SSClerkResultAnalysisChartmodel : SSBaseModel
@property (nonatomic, strong) SSClerkResultthisMonthCustomerGrowthmodel * this_month;
@property (nonatomic, strong) SSClerkResultthisMonthCustomerGrowthmodel * last_month;
@end

@interface SSClerkDiagnosisResultmodel : SSBaseModel
@property (nonatomic, strong) SSClerkResultthisMonthCustomerGrowthmodel * thisMonthCustomerGrowth;
@property (nonatomic, strong) SSClerkResultAnalysisChartmodel * transformationAnalysisChart;
@property (nonatomic, strong) SSClerkResultthisMonthCustomerCountmodel * lastMonthAndThisMonthCustomerCount;

@end



NS_ASSUME_NONNULL_END
