//
//  SSBrandAbilityAnalysisDataModel.h
//  SunSum
//
//  Created by hank on 2019/3/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSBrandAbilityAnalysisDataModel : SSBaseModel

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * subtitle;

+ (SSBrandAbilityAnalysisDataModel *)modelWithTitle:(NSString *)title subtitle:(NSString *)subtitle;

@end

NS_ASSUME_NONNULL_END
