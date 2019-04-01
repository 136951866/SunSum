//
//  SSStoreApplyParModel.m
//  SunSum
//
//  Created by hank on 2019/3/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSStoreApplyParModel.h"

@implementation SSStoreApplyParModel

+ (instancetype)getModel{
    SSStoreApplyParModel *model = [SSStoreApplyParModel new];
    model.token = kMeUnNilStr(kCurrentUser.token);
    model.mask_imgModel = [SSBynamicPublishGridModel modelWithImage:[UIImage imageNamed:@"icon_bynamicAdd"] isAdd:YES];
    model.mask_info_imgModel = [SSBynamicPublishGridModel modelWithImage:[UIImage imageNamed:@"icon_bynamicAdd"] isAdd:YES];
    model.business_imagesModel = [SSBynamicPublishGridModel modelWithImage:[UIImage imageNamed:@"icon_bynamicAdd"] isAdd:YES];
    return model;
}

@end
