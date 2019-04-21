//
//  SSClerkNotFollowUpMember.h
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkNotFollowUpMember : SSBaseModel

@property (nonatomic, assign) NSInteger  seven_day;
@property (nonatomic, assign) NSInteger  fifteen_day;
@property (nonatomic, assign) NSInteger  thirty_day;

@end

NS_ASSUME_NONNULL_END
