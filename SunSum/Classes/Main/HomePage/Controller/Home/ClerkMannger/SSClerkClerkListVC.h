//
//  SSClerkClerkListVC.h
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkClerkListVC : SSBaseVC
- (instancetype)initWithArr:(NSArray *)arrClerId;
@property (nonatomic, copy) kMeArrBlock block;
@end

NS_ASSUME_NONNULL_END
