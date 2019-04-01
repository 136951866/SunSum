//
//  SSHomePageSaveModel.h
//  SunSum
//
//  Created by hank on 2018/9/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

#define kSSHomePageSaveModelSaveModelPath @"kSSHomePageSaveModelSaveModelPath"

@interface SSHomePageSaveModel : SSBaseModel

/**
 轮播
 */
@property (nonatomic, strong)NSArray *arrAdsModel;

/**
 爆抢Top
 */
@property (nonatomic, strong)NSArray *arrHotModel;

/**
 产品
 */
@property (nonatomic, strong)NSArray *arrProductModel;

/**
 服务
 */
@property (nonatomic, strong)NSArray *arrServiceModel;




+ (SSHomePageSaveModel *)getSaveModel;
+ (void)saveAdsModel:(NSArray *)arrAdsModel;
+ (void)saveHotModel:(NSArray *)arrHotModel;
+ (void)saveProductModel:(NSArray *)arrProductModel;
+ (void)saveServiceModel:(NSArray *)arrServiceModel;

+ (NSArray *)getAdsModel;
+ (NSArray *)getHotModel;
+ (NSArray *)getProductModel;
+ (NSArray *)getServiceModel;

@end
