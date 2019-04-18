//
//  SSClerkCreateClerkTaskModel.h
//  SunSum
//
//  Created by hank on 2019/4/18.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkCreateClerkTaskModel : SSBaseModel

@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * task_title;
@property (nonatomic, strong) NSString * task_content;
@property (nonatomic, strong) NSString * last_time;
@property (nonatomic, strong) NSString * clerk_id;
@property (nonatomic, strong) NSArray * arrclerk_id;

@end

NS_ASSUME_NONNULL_END
