//
//  SSClerkWorkStatisticsServerLogHeaderView.h
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSClerkWorkStatisticsServerLogHeaderModel;
const static CGFloat kSSClerkWorkStatisticsServerLogHeaderViewHeight = 105;

@interface SSClerkWorkStatisticsServerLogHeaderView : UIView

- (void)setUiWIthModel:(SSClerkWorkStatisticsServerLogHeaderModel *)model;

@end

NS_ASSUME_NONNULL_END
