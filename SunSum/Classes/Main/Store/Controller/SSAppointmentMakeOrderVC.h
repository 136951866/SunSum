//
//  SSAppointmentMakeOrderVC.h
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@class SSServiceDetailsModel;
@class SSAppointAttrModel;
@interface SSAppointmentMakeOrderVC : SSBaseVC

- (instancetype)initWithAttrModel:(SSAppointAttrModel *)attrModel serviceDetailModel:(SSServiceDetailsModel *)serviceDetailModel;

@end
