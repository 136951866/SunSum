//
//  SSBynamicPublishGridModel.m
//  SunSum
//
//  Created by hank on 2019/3/7.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBynamicPublishGridModel.h"

@implementation SSBynamicPublishGridModel

+ (SSBynamicPublishGridModel *)modelWithImage:(UIImage *)image isAdd:(BOOL)isAdd{
    SSBynamicPublishGridModel *model = [SSBynamicPublishGridModel new];
    model.image = image;
    model.isAdd = isAdd;
    model.status = SSBynamicPublishGridModelIdelStatus;
    return model;
}

@end
