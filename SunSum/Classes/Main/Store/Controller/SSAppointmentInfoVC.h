//
//  SSAppointmentInfoVC.h
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@class SSServiceDetailsModel;
@class SSAppointAttrModel;
@interface SSAppointmentInfoVC : SSBaseVC

//有block 是是在预约订单里进去 没有责是第一次进去
@property (nonatomic, copy) kMeObjBlock block;
//- (instancetype)initWithAttrModel:(SSAppointAttrModel *)attrmodel;
- (instancetype)initWithAttrModel:(SSAppointAttrModel *)attrmodel serviceDetailModel:(SSServiceDetailsModel *)serviceDetailModel;

@end
