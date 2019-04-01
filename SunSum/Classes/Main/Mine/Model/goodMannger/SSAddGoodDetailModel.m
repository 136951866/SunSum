//
//  SSAddGoodDetailModel.m
//  SunSum
//
//  Created by hank on 2019/3/29.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAddGoodDetailModel.h"


@implementation SSAddGoodDetailGroupModel : SSBaseModel

@end

@implementation SSAddGoodDetailSpecIdsValueModel : SSBaseModel
SSModelIdToIdField
@end

@implementation SSAddGoodDetailSpecIdsModel : SSBaseModel
SSModelObjectClassInArrayWithDic(@{@"spec_ids_value":[SSAddGoodDetailSpecIdsValueModel class]})

@end

@implementation SSAddGoodDetailSpecNameModel : SSBaseModel

@end

@implementation SSAddGoodDetailModel
SSModelObjectClassInArrayWithDic((@{@"spec_ids" : [SSAddGoodDetailSpecIdsModel class],@"spec_name" : [SSAddGoodDetailSpecNameModel class]}))
@end
