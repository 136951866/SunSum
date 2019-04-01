//
//  SSThridHomeModel.m
//  SunSum
//
//  Created by hank on 2019/1/24.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSThridHomeModel.h"

@implementation SSThridHomeBuyingGoodsModel


@end

@implementation SSThridHomeAdModel


@end

@implementation SSThridHomeserviceModel


@end

@implementation SSThridHomeBackgroundModel

SSModelIdToIdField

@end

@implementation SSThridHomeModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{return @{@"member_exclusive" : @"new_member_exclusive"};}

SSModelObjectClassInArrayWithDic((@{@"service" : [SSThridHomeserviceModel class],@"top_banner" : [SSThridHomeAdModel class],@"scare_buying_goods" : [SSThridHomeBuyingGoodsModel class]}))

- (NSArray*)scare_buying_goods{
    if(!_scare_buying_goods){
        _scare_buying_goods = [NSArray array];
    }
    return _scare_buying_goods;
}

- (NSArray*)service{
    if(!_service){
        _service = [NSArray array];
    }
    return _service;
}

- (NSArray*)top_banner{
    if(!_top_banner){
        _top_banner = [NSArray array];
    }
    return _top_banner;
}

@end
