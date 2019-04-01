//
//  SSAppointmentSelectStoreVC.h
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@interface SSAppointmentSelectStoreVC : SSBaseVC

@property (nonatomic, copy) kMeObjBlock stroeBlock;

- (instancetype)initWithStoreId:(NSInteger)storId;

@end
