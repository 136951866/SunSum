//
//  SSMakeOrderAttrModel.m
//  SunSum
//
//  Created by hank on 2018/9/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMakeOrderAttrModel.h"
#import "SSGoodDetailModel.h"

@implementation SSMakeOrderAttrModel


- (instancetype)initWithGoodDetailModel:(SSGoodDetailModel *)model{
    if(self = [super init]){
        self.product_id = [NSString stringWithFormat:@"%@",@(model.product_id)];
        self.spec_ids = model.spec_ids;
        self.num = [NSString stringWithFormat:@"%@",@(model.buynum)];
        self.token = kMeUnNilStr(kCurrentUser.token);
        self.order_type = @"1";
        self.store_id = @"1";
        self.share_id = @"0";
        self.remark = @"";
        self.user_address = @"";
        self.channel = @"app";
    }
    return self;
}


@end
