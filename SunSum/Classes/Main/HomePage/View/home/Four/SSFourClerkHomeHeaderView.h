//
//  SSFourClerkHomeHeaderView.h
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSFourClerkHomeHeaderViewHeight = 214;

@protocol  SSFourHomeHeaderViewDelegate <NSObject>
- (void) toAiVC;
- (void) toPAVC;

@end

@interface SSFourClerkHomeHeaderView : UITableViewHeaderFooterView
@property(nonatomic, weak) id<SSFourHomeHeaderViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
