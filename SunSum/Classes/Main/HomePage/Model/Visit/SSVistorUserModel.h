//
//  SSVistorUserModel.h
//  SunSum
//
//  Created by hank on 2018/12/4.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

@interface SSVistorUserArticleModel : SSBaseModel

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * images;
@property (nonatomic, strong) NSString * images_url;

@end

@interface SSVistorUserSourceModel : SSBaseModel

@property (nonatomic, strong) NSString * nick_name;
@property (nonatomic, strong) NSString * header_pic;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * sex;
@property (nonatomic, strong) NSString * cellphone;
@end

@interface SSVistorUserModel : SSBaseModel

@property (nonatomic, strong) SSVistorUserArticleModel * article;
@property (nonatomic, assign) NSInteger article_id;
@property (nonatomic, assign) NSInteger browse;
@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger init_member_id;
//是否意向客户 1否 2是
@property (nonatomic, assign) NSInteger is_intention;
@property (nonatomic, assign) NSInteger member_id;
@property (nonatomic, assign) NSInteger parent_id;
@property (nonatomic, assign) NSInteger share_id;
@property (nonatomic, strong) SSVistorUserSourceModel * source;
@property (nonatomic, strong) NSString * updated_at;
@property (nonatomic, strong) SSVistorUserSourceModel * user;
@property (nonatomic, assign) NSInteger wait_time;

//2.0.2新增
//1 文章 2海报
@property (nonatomic, assign) NSInteger type;
//云IM
@property (nonatomic, strong) NSString * tls_id;

@end
