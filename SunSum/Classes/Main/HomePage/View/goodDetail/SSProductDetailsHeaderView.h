//
//  SSProductDetailsHeaderView.h
//  SunSum
//
//  Created by hank on 2018/9/8.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSGoodDetailModel;
#define kSSProductDetailsHeaderViewHeight (375*kMeFrameScaleX())

@interface SSProductDetailsHeaderView : UIView

//商品详情
- (void)setUIWithModel:(SSGoodDetailModel *)model;
//积分详情
- (void)setIntergalUIWithModel:(SSGoodDetailModel *)model;
+ (CGFloat)getViewHeight;
@end
