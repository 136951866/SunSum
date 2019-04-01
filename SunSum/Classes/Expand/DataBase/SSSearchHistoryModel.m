//
//  SSSearchHistoryModel.m
//  SunSum
//
//  Created by hank on 2018/10/31.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSSearchHistoryModel.h"

@implementation SSSearchHistoryModel

+ (SSSearchHistoryModel *)getSaveModel{
    SSSearchHistoryModel *saveModel = [SSSearchHistoryModel getObjctForKey:kSSSearchHistoryModelPath path:TCodingPathDocument];
    if(!saveModel){
        saveModel = [SSSearchHistoryModel new];
    }
    return saveModel;
}

+ (void)saveSearchHistory:(NSArray *)arrSearchHistory{
    SSSearchHistoryModel *saveModel = [self getSaveModel];
    saveModel.arrSearchHistory = arrSearchHistory;
    [saveModel writeObjectForKey:kSSSearchHistoryModelPath path:TCodingPathDocument];
    
}

+ (NSArray *)arrSearchHistory{
    SSSearchHistoryModel *saveModel = [self getSaveModel];
    return kMeUnArr(saveModel.arrSearchHistory);
}

+ (void)saveSearchStoreHistory:(NSArray *)arrSearchStoreHistory{
    SSSearchHistoryModel *saveModel = [self getSaveModel];
    saveModel.arrSearchStoreHistory = arrSearchStoreHistory;
    [saveModel writeObjectForKey:kSSSearchHistoryModelPath path:TCodingPathDocument];
}

+ (NSArray *)arrSearchStoreHistory{
    SSSearchHistoryModel *saveModel = [self getSaveModel];
    return kMeUnArr(saveModel.arrSearchStoreHistory);
}

- (NSArray *)arrSearchHistory{
    if(!_arrSearchHistory){
        _arrSearchHistory = [NSArray array];
    }
    return _arrSearchHistory;
}

- (NSArray *)arrSearchStoreHistory{
    if(!_arrSearchStoreHistory){
        _arrSearchStoreHistory = [NSArray array];
    }
    return _arrSearchStoreHistory;
}

@end
