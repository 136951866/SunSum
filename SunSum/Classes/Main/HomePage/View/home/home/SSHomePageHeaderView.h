//
//  SSHomePageHeaderView.h
//  SunSum
//
//  Created by hank on 2018/9/6.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSHomeHeaderMenuView.h"
#import "SSHomeSearchView.h"

#define kSSHomePageHeaderViewHeight (255*kMeFrameScaleY() + 48 + kSSHomeHeaderMenuViewHeight + kSSHomeSearchViewHeight)

@interface SSHomePageHeaderView : UIView

- (void)setArrModel:(NSArray *)arrModel;
@property (nonatomic, copy) kMeBasicBlock searchBlock;
@property (nonatomic, copy) kMeBasicBlock filetBlock;

@end
