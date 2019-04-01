//
//  SSServiceDetailsVC.h
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@class SSStoreDetailModel;
@interface SSServiceDetailsVC : SSBaseVC

- (instancetype)initWithId:(NSInteger)detailsId storeDetailModel:(SSStoreDetailModel *)storeDetailModel;
- (instancetype)initWithId:(NSInteger)detailsId;

@end
