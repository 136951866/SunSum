//
//  SSServiceDetailsHeaderView.h
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSGoodDetailModel;
@interface SSServiceDetailsHeaderView : UIView

- (void)setUIWithModel:(SSGoodDetailModel *)model;
+(CGFloat)getViewHeight;

@end
