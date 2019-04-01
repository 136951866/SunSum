//
//  SSFilterMainCell.h
//  SunSum
//
//  Created by hank on 2018/11/1.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSFilterMainModel;
const static CGFloat kSSFilterMainCellHeight = 46;

@interface SSFilterMainCell : UITableViewCell

- (void)setUIWithModel:(SSFilterMainModel *)model;
- (void)setUnreadUIWithModel:(SSFilterMainModel *)model;

@end
