//
//  SSStoreApplyParModel.h
//  SunSum
//
//  Created by hank on 2019/3/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"
#import "SSBynamicPublishGridModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSStoreApplyParModel : SSBaseModel

@property (nonatomic ,strong) NSString *true_name;
@property (nonatomic ,strong) NSString *store_name;
@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString *id_number;
@property (nonatomic ,strong) NSString *cellphone;
@property (nonatomic ,strong) NSString *mobile;
@property (nonatomic ,strong) NSString *intro;
@property (nonatomic ,strong) NSString *province;
@property (nonatomic ,strong) NSString *city;
@property (nonatomic ,strong) NSString *district;
@property (nonatomic ,strong) NSString *address;
@property (nonatomic ,strong) NSString *latitude;
@property (nonatomic ,strong) NSString *longitude;
@property (nonatomic ,strong) NSString *mask_img;
@property (nonatomic ,strong) SSBynamicPublishGridModel *mask_imgModel;
@property (nonatomic ,strong) NSString *mask_info_img;
@property (nonatomic ,strong) SSBynamicPublishGridModel *mask_info_imgModel;
@property (nonatomic ,strong) NSString *business_images;
@property (nonatomic ,strong) SSBynamicPublishGridModel *business_imagesModel;
@property (nonatomic ,strong) NSString *token;

+ (instancetype)getModel;

@end

NS_ASSUME_NONNULL_END
