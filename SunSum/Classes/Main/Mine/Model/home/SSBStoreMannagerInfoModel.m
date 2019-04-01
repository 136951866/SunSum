//
//  SSBStoreMannagerInfoModel.m
//  SunSum
//
//  Created by hank on 2019/2/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBStoreMannagerInfoModel.h"

@implementation SSBStoreMannagercontentInfoModel

+ (SSBStoreMannagercontentInfoModel *)initWithType:(SSBStoreMannagerInfoType )type title:(NSString *)title subTitle:(NSString *)subTitle{
    SSBStoreMannagercontentInfoModel *model = [SSBStoreMannagercontentInfoModel new];
    model.type = type;
    model.title = title;
    model.subTitle = subTitle;
    return model;
}

@end

@implementation SSBStoreMannagerInfoModel

- (NSMutableArray *)arrModel{
    if(!_arrModel){
        _arrModel = [NSMutableArray array];
    }
    return _arrModel;
}

@end
