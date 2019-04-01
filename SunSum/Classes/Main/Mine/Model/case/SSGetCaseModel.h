//
//  SSGetCaseModel.h
//  SunSum
//
//  Created by hank on 2018/12/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

@interface SSGetCaseContentModel : SSBaseModel

@property (nonatomic, strong) NSString * all_amount;
@property (nonatomic, strong) NSString * cellphone;
@property (nonatomic, strong) NSString * check_remark;
@property (nonatomic, strong) NSString * freight;
@property (nonatomic, strong) NSString * money;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * nick_name;
@property (nonatomic, strong) NSString * order_goods_sn;
@property (nonatomic, strong) NSString * order_goods_status;
@property (nonatomic, strong) NSString * order_goods_status_name;
@property (nonatomic, assign) NSInteger payment_type;
@property (nonatomic, strong) NSString * product_amount;
@property (nonatomic, assign) NSInteger product_id;
@property (nonatomic, strong) NSString * product_image;
@property (nonatomic, strong) NSString * product_name;
@property (nonatomic, strong) NSString *product_number;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *order_spec_name;
@end


@interface SSGetCaseModel : SSBaseModel

@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) NSArray * goods;
@property (nonatomic, strong) NSString * order_goods_status_name;
@property (nonatomic, strong) NSString * order_sn;

@end
