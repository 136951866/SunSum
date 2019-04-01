//
//  SSStoreDetailHeaderView.h
//  SunSum
//
//  Created by hank on 2018/10/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSStoreDetailModel;
#define kSSStoreDetailHeaderViewHeight  (147 + (220 * kMeFrameScaleX()))

@interface SSStoreDetailHeaderView : UIView

- (void)setUIWithModel:(SSStoreDetailModel *)model;
+ (CGFloat)getViewHeight:(SSStoreDetailModel *)model;
@end
