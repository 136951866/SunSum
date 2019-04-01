//
//  SSLocationTool.h
//  SunSum
//
//  Created by Hank on 2018/9/10.
//  Copyright © 2018年 hank. All rights reserved.
//  百度地位 已弃

#import <Foundation/Foundation.h>

@class SSLocationCLLModel;
//@class BMKAddressComponent;
#define kLocationUserInfo @"LocationUserInfo"

@interface SSLocationTool : NSObject

+ (instancetype)sharedHander;
//开始定位
- (void)startLocation;
//停止定位
- (void)stopLocation;
//
//- (BMKAddressComponent *)getLocation;
- (SSLocationCLLModel *)getLocationModel;
- (void)getGeocoderSuccess:(kMeObjBlock)success failure:(kMeObjBlock)failure;

//获取当前城市
//+ (NSString *)setInfoWithLocation:(BMKAddressComponent *)location;
@end
