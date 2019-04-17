//
//  SSPickerYearView.h
//  SunSum
//
//  Created by hank on 2019/4/17.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSPickerYearView : UIView

/// 是否自动滑动 默认YES
@property (assign, nonatomic) BOOL isSlide;

/// 选中的时间， 默认是当前时间 2017-02-12 13:35
@property (copy, nonatomic) NSString *date;

/// 分钟间隔 默认5分钟
@property (assign, nonatomic) NSInteger minuteInterval;

//@property (weak, nonatomic) id <THDatePickerViewDelegate> delegate;

- (instancetype)initWithSelectDaye:(kMeTextBlock)block;

@end

NS_ASSUME_NONNULL_END
