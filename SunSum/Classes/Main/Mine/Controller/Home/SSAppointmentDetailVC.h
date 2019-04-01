//
//  SSAppointmentDetailVC.h
//  SunSum
//
//  Created by hank on 2018/9/15.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@interface SSAppointmentDetailVC : SSBaseVC

- (instancetype)initWithOrderreserve_sn:(NSString *)reserve_sn;
- (instancetype)initWithReserve_sn:(NSString *)reserve_sn userType:(SSClientTypeStyle)userType;

@end
