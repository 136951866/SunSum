//
//  SSBStoreMannagerEditModel.m
//  SunSum
//
//  Created by hank on 2019/2/22.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBStoreMannagerEditModel.h"
#import "SSBStoreMannagerModel.h"

@implementation SSBStoreMannagerEditModel

+ (SSBStoreMannagerEditModel *)editModelWIthModel:(SSBStoreMannagerModel *)model{
    SSBStoreMannagerEditModel *editmodel = [SSBStoreMannagerEditModel new];
    editmodel.token = kMeUnNilStr(kCurrentUser.token);
    editmodel.store_name = kMeUnNilStr(model.store_name);
    editmodel.mobile = kMeUnNilStr(model.mobile);
    editmodel.id_number = kMeUnNilStr(model.id_number);
    editmodel.intro = kMeUnNilStr(model.intro);
    editmodel.address = kMeUnNilStr(model.address);
    editmodel.province = kMeUnNilStr(model.province);
    editmodel.city = kMeUnNilStr(model.city);
    editmodel.district = kMeUnNilStr(model.district);
    editmodel.latitude = kMeUnNilStr(model.latitude);
    editmodel.longitude = kMeUnNilStr(model.longitude);
    return editmodel;
}
@end
