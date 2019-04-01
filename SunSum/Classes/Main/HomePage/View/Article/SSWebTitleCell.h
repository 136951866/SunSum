//
//  SSWebTitleCell.h
//  SunSum
//
//  Created by hank on 2018/12/4.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSArticelDetailModel;
//const static CGFloat kSSWebTitleCellHeight = 66;

@interface SSWebTitleCell : UITableViewCell

- (void)setUiWithModel:(SSArticelDetailModel *)model;
+ (CGFloat)getCellHeightWithModel:(SSArticelDetailModel *)model;
@end
