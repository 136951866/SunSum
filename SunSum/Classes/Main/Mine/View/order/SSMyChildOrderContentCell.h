//
//  SSMyChildOrderContentCell.h
//  SunSum
//
//  Created by gao lei on 2018/9/21.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSOrderGoodModel;
static const CGFloat kSSMyChildOrderContentCellHeight = 120;

@interface SSMyChildOrderContentCell : UITableViewCell

- (void)setUIWithModel:(SSOrderGoodModel *)model;
- (void)setSelfUIWithModel:(SSOrderGoodModel *)model extractStatus:(NSString *)status;

@end
