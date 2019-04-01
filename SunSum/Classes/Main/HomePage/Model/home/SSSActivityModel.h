//
//  SSSActivityModel.h
//  SunSum
//
//  Created by hank on 2018/12/3.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"
#import "SSSActivityContentModel.h"

@interface SSSActivityModel : SSBaseModel

@property (nonatomic, strong) SSSActivityContentModel *background;
@property (nonatomic, strong) NSArray *banner;

@end
