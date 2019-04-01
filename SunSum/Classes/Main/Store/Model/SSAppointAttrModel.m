//
//  SSAppointAttrModel.m
//  SunSum
//
//  Created by hank on 2018/10/19.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSAppointAttrModel.h"

@implementation SSAppointAttrModel

- (instancetype)initAttr{
    if(self = [super init]){
        self.token = kMeUnNilStr(kCurrentUser.token);
        self.store_id = 0;
        self.storeName = @"";
        self.reserve_number = 1;
    }
    return self;
}

@end
