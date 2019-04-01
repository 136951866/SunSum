//
//  SSSuperMemberHomeModel.m
//  SunSum
//
//  Created by hank on 2018/10/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSSuperMemberHomeModel.h"
#import "SSGoodModel.h"

@implementation SSSuperMemberHomeModel

SSModelObjectClassInArrayWithDic((@{@"meidou_exchang" : [NSDictionary class],@"member_buy" : [SSGoodModel class]}))


- (NSArray *)member_buy{
    if(!_member_buy){
        return [NSArray array];
    }
    return _member_buy;
}

- (NSArray *)meidou_exchang{
    if(!_meidou_exchang){
        return [NSArray array];
    }
    return _meidou_exchang;
}
@end
