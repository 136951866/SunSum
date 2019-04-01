//
//  SSMineHomeHeaderView.h
//  SunSum
//
//  Created by Hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSMineHomeHeaderViewHeight = 280;
@interface SSMineHomeHeaderView : UIView

- (void)reloadUIWithUserInfo;
- (void)clearUIWithUserInfo;

@property (nonatomic, copy) kMeBasicBlock addPhoneBlock;

@end
