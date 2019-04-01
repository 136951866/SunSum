//
//  SSCouponDetailModel.h
//  SunSum
//
//  Created by hank on 2019/1/24.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSCouponDetailModel : SSBaseModel

@property (nonatomic, assign) CGFloat unfinish_promotion_amount;
@property (nonatomic, assign) CGFloat finish_promotion_amount;
@property (nonatomic, assign) CGFloat commission_amount;
@property (nonatomic, assign) CGFloat withdrawal;

@end

NS_ASSUME_NONNULL_END
