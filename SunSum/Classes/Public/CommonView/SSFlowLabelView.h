//
//  SSFlowLabelView.h
//  SunSum
//
//  Created by hank on 2019/1/25.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSFlowLabelView : UIView

+ (CGFloat)getSSFlowLabelViewHeightWithArr:(NSArray *)arr;
- (void)reloaWithArr:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
