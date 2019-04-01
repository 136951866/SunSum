//
//  SSBStoreMannagerInfoModel.h
//  SunSum
//
//  Created by hank on 2019/2/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SSBStoreMannagerInfoNameType,
    SSBStoreMannagerInfoTelType,
    SSBStoreMannagerInfolevelType,
    SSBStoreMannagerInfoLoginNameType,
    SSBStoreMannagerInfoTopNameType,
    SSBStoreMannagerInfoSupoirNameType,
    SSBStoreMannagerInfoStoreNameType,
    SSBStoreMannagerInfoStoreTelType,
    SSBStoreMannagerInfocodeIdType,
    SSBStoreMannagerStoreIntoduceType,
    SSBStoreMannagerInfoAddressType,
    SSBStoreMannagerInfodetailAddressType,
    SSBStoreMannagerInfoTimeType
} SSBStoreMannagerInfoType;

@interface SSBStoreMannagercontentInfoModel : SSBaseModel

@property (nonatomic ,assign) SSBStoreMannagerInfoType type;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *subTitle;

+ (SSBStoreMannagercontentInfoModel *)initWithType:(SSBStoreMannagerInfoType )type title:(NSString *)title subTitle:(NSString *)subTitle;

@end

@interface SSBStoreMannagerInfoModel : SSBaseModel

@property (nonatomic ,strong) NSMutableArray *arrModel;
@property (nonatomic ,strong) NSString *title;


@end

NS_ASSUME_NONNULL_END
