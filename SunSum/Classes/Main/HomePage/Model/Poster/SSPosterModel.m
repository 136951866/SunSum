//
//  SSPosterModel.m
//  SunSum
//
//  Created by hank on 2018/11/30.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSPosterModel.h"


@implementation SSPosterChildrenModel

SSModelIdToIdField

@end

@implementation SSPosterModel

SSModelIdToIdField
SSModelObjectClassInArrayWithDic(@{@"children" : [SSPosterChildrenModel class]})

@end
