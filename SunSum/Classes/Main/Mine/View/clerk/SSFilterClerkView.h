//
//  SSFilterClerkView.h
//  SunSum
//
//  Created by hank on 2019/1/6.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, kSSFilterClerkViewType) {
    kSSFilterClerkViewZfType=0,
    kSSFilterClerkViewReadType,
    kSSFilterClerkViewMoneyType,
};

const static CGFloat kSSFilterClerkViewHeight = 40;

@class SSFilterClerkView;


@protocol FilterClerkViewDelegate <NSObject>
@optional
//选中最上方的按钮的点击事件
- (void)selectTopButton:(SSFilterClerkView *)selectView withIndex:(NSInteger)index withButtonType:(ButtonClickType )type;
//选中分类中按钮的点击事件
- (void)selectItme:(SSFilterClerkView *)selectView withIndex:(NSInteger)index;
@end

@interface SSFilterClerkView : UIView

@property (nonatomic, weak) id<FilterClerkViewDelegate>delegate;
//默认选中，默认是第一个
@property (nonatomic, assign) int defaultSelectIndex;
//默认选中项，默认是第一个
@property (nonatomic, assign) int defaultSelectItmeIndex;

@end

NS_ASSUME_NONNULL_END
