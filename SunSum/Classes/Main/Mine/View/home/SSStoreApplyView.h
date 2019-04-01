//
//  SSStoreApplyView.h
//  SunSum
//
//  Created by hank on 2019/3/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    SSStoreApplyViewImgBusinnessType = 0,
    SSStoreApplyViewImgMaskType = 1,
    SSStoreApplyViewImgMaskInfoType = 2,
} SSStoreApplyViewImgType;

@class SSStoreApplyParModel;
const static CGFloat kSSStoreApplyViewHeight = 1198;

@interface SSStoreApplyView : UIView

//- (instancetype)initWithFrame:(CGRect)frame Model:(SSStoreApplyParModel *)model;
@property (nonatomic, copy) kMeIndexBlock selectImgBlock;
@property (weak, nonatomic) IBOutlet UIImageView *imgbusiness;
@property (weak, nonatomic) IBOutlet UIImageView *imgMask;
@property (weak, nonatomic) IBOutlet UIImageView *imgMaskInfo;
@property (strong, nonatomic) SSStoreApplyParModel *model;

- (void)reloadUI;
@property (nonatomic, copy) kMeBasicBlock locationBlock;
@property (nonatomic, copy) kMeBasicBlock applyBlock;

@end

NS_ASSUME_NONNULL_END
