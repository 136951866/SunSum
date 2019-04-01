//
//  SSGiftHeaderView.h
//  SunSum
//
//  Created by hank on 2018/12/19.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSSGiftHeaderViewHeight (307 )

@interface SSGiftHeaderView : UITableViewHeaderFooterView

+ (CGFloat)getViewHeight;
- (void)setUiWithModel:(NSArray*)model;

@end
