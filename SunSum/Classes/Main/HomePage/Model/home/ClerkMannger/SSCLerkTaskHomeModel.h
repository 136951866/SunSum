//
//  SSCLerkTaskHomeModel.h
//  SunSum
//
//  Created by hank on 2019/4/17.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSCLerkTaskHomeModel : SSBaseModel

@property (nonatomic, assign) NSInteger clerk_id;
@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) NSString * deleted_at;
@property (nonatomic, strong) NSString * finished_at;
@property (nonatomic, strong) NSString * header_pic;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * last_time;
@property (nonatomic, strong) NSString * name;
//0逾期 1过期 2完成
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * status_text;
@property (nonatomic, assign) NSInteger store_id;
@property (nonatomic, strong) NSString * task_content;
@property (nonatomic, strong) NSString * task_title;
@property (nonatomic, strong) NSString * updated_at;

@end

NS_ASSUME_NONNULL_END
