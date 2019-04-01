//
//  SSNewMineHomeHeaderView.h
//  SunSum
//
//  Created by hank on 2019/1/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSNewMineHomeHeaderViewHeight = 286;
@interface SSNewMineHomeHeaderView : UIView

- (void)reloadUIWithUserInfo;
- (void)clearUIWithUserInfo;

@end

NS_ASSUME_NONNULL_END
