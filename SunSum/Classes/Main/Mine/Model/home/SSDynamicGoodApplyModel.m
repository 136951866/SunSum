//
//  SSDynamicGoodApplyModel.m
//  SunSum
//
//  Created by hank on 2019/3/25.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSDynamicGoodApplyModel.h"
#import "SSBynamicPublishGridModel.h"

@implementation SSDynamicGoodApplyModel

SSModelIdToIdField

+ (instancetype)getModel{
    SSDynamicGoodApplyModel *model = [SSDynamicGoodApplyModel new];
    model.token = kMeUnNilStr(kCurrentUser.token);
    model.images = [NSMutableArray array];
    SSBynamicPublishGridModel *imagemodel = [SSBynamicPublishGridModel modelWithImage:[UIImage imageNamed:@"icon_bynamicAdd"] isAdd:YES];
    [model.images addObject:imagemodel];
    return model;
}


@end
