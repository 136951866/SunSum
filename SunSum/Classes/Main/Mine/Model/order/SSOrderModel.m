//
//  SSOrderModel.m
//  SunSum
//
//  Created by hank on 2018/9/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSOrderModel.h"

@implementation SSOrderGoodModel
SSModelIdToIdField
@end

@implementation SSOrderModel

SSModelObjectClassInArrayWithDic(@{@"children" : [SSOrderGoodModel class]})

@end
