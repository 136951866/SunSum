//
//  SSSNewHomeStyle.h
//  SunSum
//
//  Created by hank on 2018/12/4.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

@interface SSSNewContentHomeStyle : SSBaseModel

@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) NSString * deleted_at;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * img;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger style_type;
@property (nonatomic, assign) NSInteger tool;
@property (nonatomic, strong) NSString * updated_at;

@end

@interface SSSNewHomeStyle : SSBaseModel

@property (nonatomic, strong) SSSNewContentHomeStyle * top_style;
@property (nonatomic, strong) SSSNewContentHomeStyle * shop_style;
@property (nonatomic, strong) SSSNewContentHomeStyle * posters_style;
@property (nonatomic, strong) SSSNewContentHomeStyle * article_style;
@property (nonatomic, strong) SSSNewContentHomeStyle * store_style;

@property (nonatomic, strong) SSSNewContentHomeStyle * gift_style;
@property (nonatomic, strong) SSSNewContentHomeStyle * taobao_coupon_style;
@end
