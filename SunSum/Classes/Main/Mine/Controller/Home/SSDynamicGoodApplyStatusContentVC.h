//
//  SSDynamicGoodApplyStatusContentVC.h
//  SunSum
//
//  Created by hank on 2019/3/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SSDynamicGoodApplyStatusContentWaitType = 1,
    SSDynamicGoodApplyStatusContentSucessType = 2,
    SSDynamicGoodApplyStatusContentFailType = 3,
} SSDynamicGoodApplyStatusContentType;
@interface SSDynamicGoodApplyStatusContentVC : SSBaseVC

- (instancetype)initWithType:(SSDynamicGoodApplyStatusContentType)type;
@end

NS_ASSUME_NONNULL_END
