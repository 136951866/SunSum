//
//  SSNetListModel.h
//  SunSum
//
//  Created by gao lei on 2018/9/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

@interface SSNetListModel : SSBaseModel

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) id result;
@property (nonatomic, strong) NSString *putaway;
@property (nonatomic, strong) NSString *soldout;
@end
