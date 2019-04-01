//
//  SSBDataDealModel.m
//  SunSum
//
//  Created by hank on 2018/12/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBDataDealModel.h"


@implementation SSBDataDealageAccessStr:SSBaseModel
@end
@implementation SSBDataDealageAccess:SSBaseModel
@end

@implementation SSBDataDealAge:SSBaseModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{return @{@"one" : @"1-18",@"two" : @"19-25",@"three" : @"26-40",@"five" : @"41-50"};}
@end

@implementation SSBDataDealGoodsNum:SSBaseModel

@end

@implementation SSBDataDealstoreCustomer:SSBaseModel

SSModelObjectClassInArrayWithDic(@{@"GoodsNum" : [SSBDataDealGoodsNum class]})

@end

@implementation SSBDataDealAchievementMember: SSBaseModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{return @{@"people" : @"new"};}
@end

@implementation SSBDataDealAchievementCatagery: SSBaseModel

@end

@implementation SSBDataDealStoreAchievement: SSBaseModel
SSModelObjectClassInArrayWithDic(@{@"AchievementCatagery" : [SSBDataDealAchievementCatagery class]})
@end

@implementation SSBDataDealBusinessModel : SSBaseModel

@end

@implementation SSBDataDealmarketingModel : SSBaseModel

@end

@implementation SSBDataDealstoreProject : SSBaseModel

@end


@implementation SSBDataDealmemberModel : SSBaseModel

@end

@implementation SSBDataDealgoodsModel : SSBaseModel

@end

@implementation SSBDataDealbrokerageModel : SSBaseModel

@end

@implementation SSBDataDealorderModel : SSBaseModel

@end

@implementation SSBDataDealModel

@end
