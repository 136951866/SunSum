//
//  SSOrderDetailModel.m
//  SunSum
//
//  Created by hank on 2018/9/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSOrderDetailModel.h"
#import "SSOrderModel.h"

@implementation SSexpressDetailModel

@end

@implementation SSStoreGetModel
SSModelIdToIdField
@end

@implementation SSOrderDetailExpressModel

@end

@implementation SSOrderDetailAddressModel
SSModelIdToIdField
@end


@implementation SSOrderDetailModel
SSModelIdToIdField

SSModelObjectClassInArrayWithDic((@{@"children" : [SSOrderGoodModel class],@"express_detail" : [SSexpressDetailModel class]}))
@end
