//
//  SSBrandManngerAllModel.h
//  SunSum
//
//  Created by hank on 2019/3/14.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSBrandMemberInfo : SSBaseModel
@property (nonatomic, strong) NSString *store_count;
@property (nonatomic, strong) NSString * header_pic;
@property (nonatomic, strong) NSString * store_name;
@end

@interface SSBrandTotalModel : SSBaseModel
@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) NSInteger total;
@end

@interface SSBrandPercentModel : SSBaseModel
@property (nonatomic, assign) CGFloat percent;
@property (nonatomic, strong) NSString *name;
@end

@interface SSBrandCorporateModel : SSBaseModel
@property (nonatomic, strong) NSString *one;
@property (nonatomic, strong) NSString *two;
@property (nonatomic, strong) NSString *three;
@property (nonatomic, strong) NSString *five;
@end

@interface SSBrandManngerAllModel : SSBaseModel

@property (nonatomic, strong) NSString *customer_count;
@property (nonatomic, strong) NSString *order_count;
@property (nonatomic, strong) NSString *deal_count;
@property (nonatomic, strong) NSString *product_access;
@property (nonatomic, strong) NSString *activity_access;
@property (nonatomic, strong) NSString *dynamic_access;
@property (nonatomic, strong) NSArray *customer_interest;
@property (nonatomic, strong) NSArray *alive_member;
@property (nonatomic, strong) NSArray *anew_member;
@property (nonatomic, strong) SSBrandCorporateModel *Corporate;
@property (nonatomic, strong) SSBrandMemberInfo *member_info;

@end

NS_ASSUME_NONNULL_END
