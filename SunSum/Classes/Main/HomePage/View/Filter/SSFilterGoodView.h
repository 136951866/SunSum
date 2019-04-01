//
//  SSFilterGoodView.h
//  SunSum
//
//  Created by hank on 2018/11/1.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>


const static CGFloat kSSFilterGoodViewHeight = 40;

@class SSFilterGoodView;


@protocol FilterSelectViewDelegate <NSObject>
@optional
//选中最上方的按钮的点击事件
- (void)selectTopButton:(SSFilterGoodView *)selectView withIndex:(NSInteger)index withButtonType:(ButtonClickType )type;
//选中分类中按钮的点击事件
- (void)selectItme:(SSFilterGoodView *)selectView withIndex:(NSInteger)index;
@end

@interface SSFilterGoodView : UIView

@property (nonatomic, weak) id<FilterSelectViewDelegate>delegate;
//默认选中，默认是第一个
@property (nonatomic, assign) int defaultSelectIndex;
//默认选中项，默认是第一个
@property (nonatomic, assign) int defaultSelectItmeIndex;

//是否能点击 默认可以
//@property (nonatomic, assign) BOOL canSelect;
@end
