//
//  SSOrderDetailView.h
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSAppointDetailModel;
@class SSOrderDetailModel;
const static CGFloat kSSOrderDetailViewHeight = 187;
const static CGFloat kSSOrderDetailViewLogistHeight = 87;
@interface SSOrderDetailView : UIView

- (void)setUIWithModel:(SSOrderDetailModel *)model orderType:(SSOrderStyle)type;
- (void)setAppointUIWithModel:(SSAppointDetailModel *)model orderType:(SSAppointmenyStyle)type;
+ (CGFloat)getViewHeightWithType:(SSOrderStyle)type Model:(SSOrderDetailModel *)model;

@end
