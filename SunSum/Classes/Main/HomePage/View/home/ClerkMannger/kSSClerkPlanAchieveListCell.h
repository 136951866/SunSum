//
//  kSSClerkPlanAchieveListCell.h
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSClerkPlanAchieveClerkModel;
const static CGFloat kkSSClerkPlanAchieveListCellHeight = 59;

@interface kSSClerkPlanAchieveListCell : UITableViewCell
- (void)setUIWIthModel:(SSClerkPlanAchieveClerkModel *)model sort:(NSInteger)sort;

@end

NS_ASSUME_NONNULL_END
