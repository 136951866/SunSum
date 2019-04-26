//
//  MEBrandStoryModel.h
//  ME时代
//
//  Created by hank on 2019/4/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    MEBrandStoryContentModelPicType = 1,
    MEBrandStoryContentModelVideoType = 2,
    MEBrandStoryContentModelTXTType = 3,
} MEBrandStoryContentModelType;

@interface MEBrandStoryContentModel : SSBaseModel

@property (nonatomic, assign) MEBrandStoryContentModelType type;
@property (nonatomic, strong) NSString *value;

@end

@interface MEBrandStoryModel : SSBaseModel

@property (nonatomic, strong) NSMutableArray *arrdata;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) MEBrandStoryContentModel *header_mediamodel;
@property (nonatomic, strong) NSString *header_media;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *business_time;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *latitude;

@property (nonatomic, strong) NSString *longitude;


@end

NS_ASSUME_NONNULL_END
