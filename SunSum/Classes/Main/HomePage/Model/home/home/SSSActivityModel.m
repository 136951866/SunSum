//
//  SSSActivityModel.m
//  SunSum
//
//  Created by hank on 2018/12/3.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSSActivityModel.h"


@implementation SSSActivityModel

SSModelObjectClassInArrayWithDic(@{@"banner" : [SSSActivityContentModel class]})

- (SSSActivityContentModel *)background{
    if(!_background){
        _background = [SSSActivityContentModel new];
    }
    return _background;
}

- (NSArray *)banner{
    if(!_banner){
        _banner = [NSArray array];
    }
    return _banner;
}

@end
