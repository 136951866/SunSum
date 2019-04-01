//
//  SSBDataDealStructView.h
//  SunSum
//
//  Created by hank on 2019/2/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface SSBDataDealStructView : UIView

- (void)setUIWithArr:(NSArray *)arrModel;
+ (CGFloat)getViewWithArr:(NSArray *)arr;
- (void)setGoodNUmUIWithArr:(NSArray *)arrModel;

@end

NS_ASSUME_NONNULL_END
