//
//  SSBrandAbilityAnalysisDataModel.m
//  SunSum
//
//  Created by hank on 2019/3/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBrandAbilityAnalysisDataModel.h"

@implementation SSBrandAbilityAnalysisDataModel

+ (SSBrandAbilityAnalysisDataModel *)modelWithTitle:(NSString *)title subtitle:(NSString *)subtitle{
    SSBrandAbilityAnalysisDataModel *model = [SSBrandAbilityAnalysisDataModel new];
    model.title = title;
    model.subtitle = subtitle;
    return model;
}

@end
