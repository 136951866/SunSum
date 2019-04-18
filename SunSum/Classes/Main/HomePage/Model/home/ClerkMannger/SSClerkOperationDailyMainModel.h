//
//  SSClerkOperationDailyMainModel.h
//  SunSum
//
//  Created by hank on 2019/4/18.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkOperationDailyMainModel : SSBaseModel

@property (nonatomic, strong) NSString * member_id;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * nick_name;
@property (nonatomic, strong) NSString * header_pic;
@property (nonatomic, assign) NSInteger task_count;

@end

NS_ASSUME_NONNULL_END
