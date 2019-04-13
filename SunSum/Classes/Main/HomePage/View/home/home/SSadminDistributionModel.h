//
//  SSadminDistributionModel.h
//  SunSum
//
//  Created by hank on 2018/11/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

@interface SSadminDistributionModel : SSBaseModel

@property (nonatomic, strong) NSString * admin_id;
@property (nonatomic, assign) NSInteger admin_team;
@property (nonatomic, strong) NSString * level;
@property (nonatomic, assign) CGFloat ratio_money;
@property (nonatomic, strong) NSString * superior;
@property (nonatomic, assign) CGFloat use_money;

@property (nonatomic, assign) CGFloat commission_money;
@end
