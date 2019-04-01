//
//  SSCouponOrderHeaderView.h
//  SunSum
//
//  Created by hank on 2018/12/27.
//  Copyright © 2018 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSCouponOrderHeaderViewHeight = 160;
@class SSCouponDetailModel;
NS_ASSUME_NONNULL_BEGIN

@interface SSCouponOrderHeaderView : UIView

@property (nonatomic,strong) kMeBasicBlock block;
- (void)setUIWithModel:(SSCouponDetailModel *)model;

@end

NS_ASSUME_NONNULL_END
