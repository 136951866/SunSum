//
//  SSNewAddressVC.h
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@class SSAddressModel;
@interface SSNewAddressVC : SSBaseVC

- (instancetype)initWithModel:(SSAddressModel *)model;
@property (nonatomic, copy) kMeBasicBlock reloadBlock;

@end
