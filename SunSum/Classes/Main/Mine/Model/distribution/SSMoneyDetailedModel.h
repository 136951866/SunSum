//
//  SSMoneyDetailedModel.h
//  SunSum
//
//  Created by hank on 2018/9/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

@interface SSMoneyDetailedMemberModel : SSBaseModel

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * header_pic;
@end

@interface SSMoneyDetailedModel : SSBaseModel

@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) NSString * formula;
@property (nonatomic, assign) NSInteger is_ratio;
@property (nonatomic, strong) SSMoneyDetailedMemberModel * member;
@property (nonatomic, assign) NSInteger member_id;
@property (nonatomic, strong) NSString * money;
@property (nonatomic, strong) NSString * order_goods_sn;
@property (nonatomic, strong) NSString * order_sn;
@property (nonatomic, assign) NSInteger product_ratio_id;
@property (nonatomic, assign) NSInteger product_id;
@property (nonatomic, assign) NSInteger ratio;
@property (nonatomic, assign) NSInteger store_id;
@property (nonatomic, strong) NSString * updated_at;
@end
