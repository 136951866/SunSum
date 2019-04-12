//
//  SSAIDataHomeActiveModel.h
//  SS时代
//
//  Created by hank on 2019/4/10.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSAIDataHomeActiveModel : SSBaseModel

@property (nonatomic, assign) NSInteger look_group_buy_activity;
@property (nonatomic, assign) NSInteger look_services;
@property (nonatomic, assign) NSInteger look_store;
@property (nonatomic, assign) NSInteger share_store;

@end

NS_ASSUME_NONNULL_END
