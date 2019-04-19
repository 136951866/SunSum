//
//  SSEditClerkInfoVC.h
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@class SSClerkFinishTaskModel;
@interface SSEditClerkInfoVC : SSBaseVC
- (instancetype)initWithMarkModel:(SSClerkFinishTaskModel *)model;
- (instancetype)initWithNoticeModel:(SSClerkFinishTaskModel *)model;
- (instancetype)initWithServerModel:(SSClerkFinishTaskModel *)model;
@property (nonatomic, copy) kMeTextBlock finifhBlock;

@end

NS_ASSUME_NONNULL_END
