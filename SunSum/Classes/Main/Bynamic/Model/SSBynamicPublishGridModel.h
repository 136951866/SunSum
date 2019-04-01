//
//  SSBynamicPublishGridModel.h
//  SunSum
//
//  Created by hank on 2019/3/7.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"
#import "SSBynamicPublishGridModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    SSBynamicPublishGridModelIdelStatus,
    SSBynamicPublishGridModelUploadingStatus,
    SSBynamicPublishGridModelSucStatus,
    SSBynamicPublishGridModelFailStatus,
} SSBynamicPublishGridModelStatus;

@interface SSBynamicPublishGridModel : SSBaseModel


@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, assign) SSBynamicPublishGridModelStatus status;

//选中的时候用的


+ (SSBynamicPublishGridModel*)modelWithImage:(UIImage *)image isAdd:(BOOL)isAdd;

@end

NS_ASSUME_NONNULL_END
