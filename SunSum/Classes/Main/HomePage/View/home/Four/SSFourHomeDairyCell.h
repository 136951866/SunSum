//
//  SSFourHomeDairyCell.h
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kSSFourHomeDairyCellheight     (((SCREEN_WIDTH - 18) * 132)/1071)+15


@interface SSFourHomeDairyCell : UITableViewCell

//1运营日报 2 工作日报
- (void)setUIWithType:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
