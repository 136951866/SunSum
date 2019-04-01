//
//  SSCoupleMailDetalVC.h
//  SunSum
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@class SSCoupleModel;
@class SSPinduoduoCoupleModel;
@interface SSCoupleMailDetalVC : SSBaseVC

- (instancetype)initWithModel:(SSCoupleModel *)model;
- (instancetype)initWithPinduoudoModel:(SSPinduoduoCoupleModel *)model;
- (instancetype)initWithProductrId:(NSString *)ProductrId couponId:(NSString *)couponId couponurl:(NSString *)couponurl;

@end
