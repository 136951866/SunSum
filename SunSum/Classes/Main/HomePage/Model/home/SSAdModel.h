//
//  SSAdModel.h
//  SunSum
//
//  Created by hank on 2018/9/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

@interface SSAdModel : SSBaseModel

@property (nonatomic, assign) NSInteger ad_id;
@property (nonatomic, strong) NSString * ad_img;
@property (nonatomic, strong) NSString * ad_name;
@property (nonatomic, strong) NSString * ad_url;
@property (nonatomic, assign) NSInteger product_id;
@property (nonatomic, strong) NSString *keywork;

@end
