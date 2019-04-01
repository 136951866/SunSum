//
//  SSHomePageSaveModel.m
//  SunSum
//
//  Created by hank on 2018/9/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSHomePageSaveModel.h"

@implementation SSHomePageSaveModel

+ (SSHomePageSaveModel *)getSaveModel{
    SSHomePageSaveModel *saveModel = [SSHomePageSaveModel getObjctForKey:kSSHomePageSaveModelSaveModelPath path:TCodingPathDocument];
    if(!saveModel){
        saveModel = [SSHomePageSaveModel new];
    }
    return saveModel;
}
+ (void)saveAdsModel:(NSArray *)arrAdsModel{
    SSHomePageSaveModel *saveModel = [self getSaveModel];
    saveModel.arrAdsModel = arrAdsModel;
    [saveModel writeObjectForKey:kSSHomePageSaveModelSaveModelPath path:TCodingPathDocument];
}
+ (void)saveHotModel:(NSArray *)arrHotModel{
    SSHomePageSaveModel *saveModel = [self getSaveModel];
    saveModel.arrHotModel = arrHotModel;
    [saveModel writeObjectForKey:kSSHomePageSaveModelSaveModelPath path:TCodingPathDocument];
}
+ (void)saveProductModel:(NSArray *)arrProductModel{
    SSHomePageSaveModel *saveModel = [self getSaveModel];
    saveModel.arrProductModel = arrProductModel;
    [saveModel writeObjectForKey:kSSHomePageSaveModelSaveModelPath path:TCodingPathDocument];
}
+ (void)saveServiceModel:(NSArray *)arrServiceModel{
    SSHomePageSaveModel *saveModel = [self getSaveModel];
    saveModel.arrServiceModel = arrServiceModel;
    [saveModel writeObjectForKey:kSSHomePageSaveModelSaveModelPath path:TCodingPathDocument];
}

+ (NSArray *)getAdsModel{
    SSHomePageSaveModel *saveModel = [self getSaveModel];
    return kMeUnArr(saveModel.arrAdsModel);
}
+ (NSArray *)getHotModel{
    SSHomePageSaveModel *saveModel = [self getSaveModel];
    return kMeUnArr(saveModel.arrHotModel);
}
+ (NSArray *)getProductModel{
    SSHomePageSaveModel *saveModel = [self getSaveModel];
    return kMeUnArr(saveModel.arrProductModel);
}
+ (NSArray *)getServiceModel{
    SSHomePageSaveModel *saveModel = [self getSaveModel];
    return kMeUnArr(saveModel.arrServiceModel);
}

@end
