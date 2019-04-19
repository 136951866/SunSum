//
//  SSNewClerkManngerModel.h
//  SunSum
//
//  Created by hank on 2019/4/17.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSNewClerkManngerDataContentModel : SSBaseModel

////沟通
//@property (nonatomic, strong) NSString * follow_up_count;
////分享
//@property (nonatomic, strong) NSString * share_count;
////s客户
//@property (nonatomic, strong) NSString * member_count;
@property (nonatomic, strong) NSString * count;
@property (nonatomic, strong) NSString * member_id;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * header_pic;
@property (nonatomic, strong) NSString * cellphone;

@end

@interface SSNewClerkManngerDataModel : SSBaseModel

@property (nonatomic,strong)NSArray *data;

@end


@interface SSNewClerkManngerClerkOrderModel : SSBaseModel
//分享
@property (nonatomic, strong) SSNewClerkManngerDataModel * clerkOrderByShareCount;
//沟通
@property (nonatomic, strong) SSNewClerkManngerDataModel * clerkOrderByFollowUpCount;
//客户
@property (nonatomic, strong) SSNewClerkManngerDataModel * clerkOrderByFollowUpMemberCount;

@end





@interface SSNewClerkManngerClerkTaskpercentModel : SSBaseModel

@property (nonatomic, strong) NSString * cellphone;
@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) NSString * finish_percent;
@property (nonatomic, strong) NSString * header_pic;
@property (nonatomic, assign) NSInteger member_id;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * nick_name;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSInteger user_type;

@end

//任务
@interface SSNewClerkManngerClerkTaskModel : SSBaseModel

@property (nonatomic,strong)NSString *finish_task;
@property (nonatomic,strong)NSString *unfinish_task;
@property (nonatomic,strong)NSArray *clerk_finish_percent;

@end








@interface SSNewClerkManngerClerkTaskclientModel : SSBaseModel

@property (nonatomic, strong) NSString * header_pic;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * nick_name;
@property (nonatomic, strong) NSString * service_at;
@property (nonatomic, strong) NSString * idField;

@end


@interface SSNewClerkManngerClerkTaskServiceModel : SSBaseModel

@property (nonatomic,strong)NSString *clerk_today_log_count;
@property (nonatomic,strong)NSString *wait_servcie_count;
@property (nonatomic,strong)NSString *overdue_count;
@property (nonatomic,strong)NSArray *client;

@end









@interface SSNewClerkManngerModel : SSBaseModel

//排名
@property (nonatomic, strong) SSNewClerkManngerClerkOrderModel * clerk_order;
//任务
@property (nonatomic, strong) SSNewClerkManngerClerkTaskModel * clerk_task;
//日志
@property (nonatomic, strong) SSNewClerkManngerClerkTaskServiceModel * clerk_task_service;

@end

NS_ASSUME_NONNULL_END
