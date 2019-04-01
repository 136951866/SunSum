//
//  SSPayStatusVC.h
//  SunSum
//
//  Created by hank on 2018/9/15.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@interface SSPayStatusVC : SSBaseVC

- (instancetype)initWithSucessConfireBlock:(kMeBasicBlock)block;
- (instancetype)initWithFailRePayBlock:(kMeBasicBlock)rePayBlock CheckOrderBlock:(kMeBasicBlock)checkOrderBlock;

@end
