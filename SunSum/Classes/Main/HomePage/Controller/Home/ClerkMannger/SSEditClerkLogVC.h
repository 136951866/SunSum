//
//  SSEditClerkLogVC.h
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@class SSCLerkTaskHomeModel;
@interface SSEditClerkLogVC : SSBaseVC
- (instancetype)initWithModel:(SSCLerkTaskHomeModel *)model;
@property (nonatomic , copy) kMeBasicBlock finishBlock;
@end

NS_ASSUME_NONNULL_END
