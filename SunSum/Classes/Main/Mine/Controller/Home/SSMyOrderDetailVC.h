//
//  SSMyOrderDetailVC.h
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@interface SSMyOrderDetailVC : SSBaseVC

- (instancetype)initWithType:(SSOrderStyle)type orderGoodsSn:(NSString *)orderGoodsSn;
- (instancetype)initWithOrderGoodsSn:(NSString *)orderGoodsSn;
//自提
- (instancetype)initSelfWithType:(SSOrderStyle)type orderGoodsSn:(NSString *)orderGoodsSn;
@end
