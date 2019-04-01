//
//  SSSearchHistoryModel.h
//  SunSum
//
//  Created by hank on 2018/10/31.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSSSearchHistoryModelPath @"kSSSearchHistoryModelPath"

@interface SSSearchHistoryModel : SSBaseModel

/**
 产品历史
 */
@property (nonatomic, strong)NSArray *arrSearchHistory;
/**
 门店历史
 */
@property (nonatomic, strong)NSArray *arrSearchStoreHistory;

+ (SSSearchHistoryModel *)getSaveModel;
+ (void)saveSearchHistory:(NSArray *)arrSearchHistory;
+ (NSArray *)arrSearchHistory;

+ (void)saveSearchStoreHistory:(NSArray *)arrSearchStoreHistory;
+ (NSArray *)arrSearchStoreHistory;
@end
