//
//  SSBStoreMannagerEditModel.h
//  SunSum
//
//  Created by hank on 2019/2/22.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class SSBStoreMannagerModel;
@interface SSBStoreMannagerEditModel : SSBaseModel

@property (nonatomic, copy) NSString * token;
@property (nonatomic, copy) NSString * store_name;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * id_number;
@property (nonatomic, copy) NSString * intro;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * district;

@property (nonatomic, strong) NSString * latitude;
@property (nonatomic, strong) NSString * longitude;
+ (SSBStoreMannagerEditModel *)editModelWIthModel:(SSBStoreMannagerModel *)model;

@end

NS_ASSUME_NONNULL_END
