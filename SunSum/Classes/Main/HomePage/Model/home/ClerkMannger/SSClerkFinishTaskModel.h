//
//  SSClerkFinishTaskModel.h
//  SunSum
//
//  Created by hank on 2019/4/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkFinishTaskModel : SSBaseModel

@property (nonatomic, strong) NSString * token;
@property (nonatomic, assign) NSInteger  task_id;
@property (nonatomic, strong) NSString * matters_attention;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * reservation_num;

@property (nonatomic, strong) NSString * last_time;
@property (nonatomic, strong) NSString * header_pic;
@property (nonatomic, strong) NSString * task_content;
@property (nonatomic, strong) NSString * name;

@end

NS_ASSUME_NONNULL_END
