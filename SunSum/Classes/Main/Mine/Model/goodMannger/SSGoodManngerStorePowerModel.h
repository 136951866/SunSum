//
//  SSGoodManngerStorePowerModel.h
//  SunSum
//
//  Created by hank on 2019/3/29.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSGoodManngerStorePowerModel : SSBaseModel
//是否有添加服务权限：1是 2否
@property (nonatomic, assign) NSInteger is_services;
//是否有添加商品权限
@property (nonatomic, assign) NSInteger is_goods;
//是否有设置佣金权限
@property (nonatomic, assign) NSInteger is_brokerage;

@end

NS_ASSUME_NONNULL_END
