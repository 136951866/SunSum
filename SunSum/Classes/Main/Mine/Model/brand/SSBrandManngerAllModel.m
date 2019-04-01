//
//  SSBrandManngerAllModel.m
//  SunSum
//
//  Created by hank on 2019/3/14.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBrandManngerAllModel.h"
@implementation SSBrandMemberInfo : SSBaseModel

@end
@implementation SSBrandTotalModel : SSBaseModel

@end

@implementation SSBrandPercentModel : SSBaseModel

@end

@implementation SSBrandCorporateModel : SSBaseModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{return @{@"one" : @"1-50",@"two" : @"51-80",@"three" : @"81-99",@"five" : @"100"};}
@end

@implementation SSBrandManngerAllModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{return @{@"anew_member" : @"new_member"};}

SSModelObjectClassInArrayWithDic((@{@"customer_interest" : [SSBrandPercentModel class],@"alive_member" : [SSBrandTotalModel class],@"anew_member" : [SSBrandTotalModel class]}))

@end
