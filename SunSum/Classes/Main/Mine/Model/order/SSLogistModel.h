//
//  SSLogistModel.h
//  SunSum
//
//  Created by hank on 2018/10/19.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

@interface SSLogistDataModel : SSBaseModel

@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) NSString * ftime;
@property (nonatomic, strong) NSString * context;
@property (nonatomic, strong) NSString * location;

@end

@interface SSLogistModel : SSBaseModel

@property (nonatomic, strong) NSString * com;
@property (nonatomic, strong) NSString * condition;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSString * ischeck;
@property (nonatomic, strong) NSString * message;
@property (nonatomic, strong) NSString * nu;
@property (nonatomic, strong) NSString * state;
@property (nonatomic, strong) NSString * status;

@end
