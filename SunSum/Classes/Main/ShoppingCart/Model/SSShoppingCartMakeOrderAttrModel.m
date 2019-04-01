//
//  SSShoppingCartMakeOrderAttrModel.m
//  SunSum
//
//  Created by hank on 2018/9/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSShoppingCartMakeOrderAttrModel.h"

@implementation SSShoppingCartMakeOrderAttrModel

- (instancetype)init{
    if(self = [super init]){
        self.token = kMeUnNilStr(kCurrentUser.token);
        self.order_type = @"1";
        self.channel = @"app";
    }
    return self;
}

@end
