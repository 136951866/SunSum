//
//  SSMoneyDetailedCell.h
//  SunSum
//
//  Created by hank on 2018/9/26.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSMoneyDetailedModel;
const static CGFloat kSSMoneyDetailedCellHeight = 67;

@interface SSMoneyDetailedCell : UITableViewCell

- (void)setUIWithModel:(SSMoneyDetailedModel *)model;

@end
