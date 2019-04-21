//
//  SSMonthNotFollowUpMemberModel.h
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSMonthNotFollowUpMemberModel : SSBaseModel

@property (nonatomic, strong) NSString * uid;
@property (nonatomic, strong) NSString * header_pic;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * nick_name;
@property (nonatomic, strong) NSString * cellphone;
@property (nonatomic, assign) NSInteger  count_type;

@end

NS_ASSUME_NONNULL_END
