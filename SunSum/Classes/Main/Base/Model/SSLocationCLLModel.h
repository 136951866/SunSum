//
//  SSLocationCLLModel.h
//  SunSum
//
//  Created by gao lei on 2018/9/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

@interface SSLocationCLLModel : SSBaseModel

@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) CGFloat lat;
@property (nonatomic, assign) CGFloat lng;

@end
