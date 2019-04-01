//
//  SSThridHomeNavView.h
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSStoreModel;

//const static CGFloat kImgStoreMargin = 5;
//const static CGFloat kImgStore = 44;
//#define kSSThridHomeNavViewHeight (((IS_iPhoneX==YES||IS_IPHONE_Xr==YES||IS_IPHONE_Xs==YES||IS_IPHONE_Xs_Max==YES) ? 76 : 65)+kImgStore+(k5Margin*4))
#define kSSThridHomeNavViewHeight (((IS_iPhoneX==YES||IS_IPHONE_Xr==YES||IS_IPHONE_Xs==YES||IS_IPHONE_Xs_Max==YES) ? 76 : 65))

@interface SSThridHomeNavView : UIView

//- (void)setStroeBackAlpha:(CGFloat)alpha;
- (void)setBackAlpha:(CGFloat)alpha;
- (void)setRead:(BOOL)read;
//- (void)setStoreInfoWithModel:(SSStoreModel *)model;

//@property (nonatomic ,copy) kMeBasicBlock toStoreBlock;

@end

NS_ASSUME_NONNULL_END
