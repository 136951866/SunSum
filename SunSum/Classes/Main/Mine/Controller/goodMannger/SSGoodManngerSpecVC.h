//
//  SSGoodManngerSpecVC.h
//  SunSum
//
//  Created by hank on 2019/3/28.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseVC.h"

NS_ASSUME_NONNULL_BEGIN
@class SSAddGoodModel;
@interface SSGoodManngerSpecVC : SSBaseVC
- (instancetype)initWithModel:(SSAddGoodModel *)model;
@property (nonatomic, strong)NSString *token;
@property (nonatomic, copy)kMeBasicBlock finishBlcok;
@end

NS_ASSUME_NONNULL_END
