//
//  SSJDCoupleModel.m
//  SunSum
//
//  Created by hank on 2019/2/18.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSJDCoupleModel.h"

@implementation CouponContentInfo : SSBaseModel


@end

@implementation ImageContentInfo : SSBaseModel

@end

@implementation CouponInfo : SSBaseModel
SSModelObjectClassInArrayWithDic(@{@"couponList":[CouponContentInfo class]})
@end

@implementation ImageInfo : SSBaseModel

SSModelObjectClassInArrayWithDic(@{@"imageList":[ImageContentInfo class]})


@end

@implementation PriceInfo : SSBaseModel

@end

@implementation CommissionInfo : SSBaseModel

@end


@implementation SSJDCoupleModel

@end
