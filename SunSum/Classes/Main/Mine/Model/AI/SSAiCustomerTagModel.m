//
//  SSAiCustomerTagModel.m
//  SS时代
//
//  Created by hank on 2019/4/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAiCustomerTagModel.h"


@implementation SSAiCustomerTagchildrenModel
SSModelIdToIdField
@end

@implementation SSAiCustomerTagModel

SSModelObjectClassInArrayWithDic(@{@"children":[SSAiCustomerTagchildrenModel class]})
SSModelIdToIdField

- (NSArray *)children{
    if(!_children){
        _children = [NSArray array];
    }
    return _children;
}

@end
