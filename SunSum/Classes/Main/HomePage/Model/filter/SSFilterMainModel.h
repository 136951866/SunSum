//
//  SSFilterMainModel.h
//  SunSum
//
//  Created by hank on 2018/11/2.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

@interface SSFilterMainModel : SSBaseModel

@property (nonatomic, strong) NSString * category_name;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, assign) NSInteger idField;

@property (nonatomic, assign) NSInteger unRead;
@end
