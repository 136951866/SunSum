//
//  SSWithdrawalVC.h
//  SunSum
//
//  Created by hank on 2018/12/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@interface SSWithdrawalVC : SSBaseVC

@property (nonatomic, copy) kMeBasicBlock applySucessBlock;
//优惠卷佣金提现入口
- (instancetype)initWithCouponMoney;
@end
