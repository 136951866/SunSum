//
//  MEBrandStoryDetailModel.h
//  SunSum
//
//  Created by hank on 2019/4/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class MEBrandStoryContentModel;

@interface MEBrandStoryDetailModel : SSBaseModel
@property (nonatomic, strong) MEBrandStoryContentModel *header_media;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *business_time;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;

@property (nonatomic, strong) NSArray *content;
@end

NS_ASSUME_NONNULL_END
