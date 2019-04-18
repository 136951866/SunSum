//
//  SSClerkWorkStatisticsServerLogModel.h
//  SunSum
//
//  Created by hank on 2019/4/18.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkWorkStatisticsServerLogModel : SSBaseModel

@property (nonatomic, assign) NSInteger finish;
@property (nonatomic, strong) NSString *cellphone;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *finish_percent;
@property (nonatomic, assign) NSInteger finish_on_time;
@property (nonatomic, strong) NSString *finish_on_time_percent;
@property (nonatomic, strong) NSString *header_pic;
@property (nonatomic, strong) NSString *member_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger user_type;
@end

NS_ASSUME_NONNULL_END
