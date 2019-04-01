//
//  SSAddGoodStoreGoodsTypeVC.h
//  SunSum
//
//  Created by hank on 2019/3/28.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseVC.h"

NS_ASSUME_NONNULL_BEGIN
@class SSAddGoodStoreGoodsType;
typedef void (^kMeAddGoodStoreGoodsTypeBlock)(SSAddGoodStoreGoodsType *model);

@interface SSAddGoodStoreGoodsTypeVC : SSBaseVC

@property (nonatomic, copy) kMeAddGoodStoreGoodsTypeBlock blcok;

@end

NS_ASSUME_NONNULL_END
