//
//  SSCreatePosterVC.h
//  SunSum
//
//  Created by hank on 2018/11/30.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@class SSPosterChildrenModel;
@class SSActivePosterModel;
@interface SSCreatePosterVC : SSBaseVC

- (instancetype)initWithModel:(SSPosterChildrenModel *)model;
- (instancetype)initWithActiveModel:(SSActivePosterModel *)model;

@end
