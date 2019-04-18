//
//  SSClerkWorkDaliyModel.h
//  SunSum
//
//  Created by hank on 2019/4/17.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkWorkDaliyModel : SSBaseModel

@property (nonatomic, assign) NSInteger new_customer;
@property (nonatomic, assign) NSInteger potential_customer;
@property (nonatomic, assign) NSInteger Intention_customer;
@property (nonatomic, assign) NSInteger regular_customer;

@end

NS_ASSUME_NONNULL_END
