//
//  SSAddGoodVC.h
//  SunSum
//
//  Created by hank on 2019/3/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSAddGoodVC : SSBaseVC
- (instancetype)initWithProductId:(NSString *)productId;
@property (nonatomic, copy) kMeBasicBlock finishAddBlock;
@end

NS_ASSUME_NONNULL_END
