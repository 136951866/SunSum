//
//  SSNewHomePageHeaderView.h
//  SunSum
//
//  Created by hank on 2018/11/5.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSNewHomePageHeaderViewHeight = 80;

@interface SSNewHomePageHeaderView : UIView

@property (nonatomic, copy) kMeIndexBlock selectMemuBlock;
- (void)returnCommon;
@property (weak, nonatomic) IBOutlet UIView *viewForUnread;


@end
