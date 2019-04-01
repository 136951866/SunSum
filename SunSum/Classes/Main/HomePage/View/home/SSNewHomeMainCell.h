//
//  SSNewHomeMainCell.h
//  SunSum
//
//  Created by hank on 2018/11/5.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSGoodModel;
const static CGFloat kSSNewHomeMainCellHeight = 244;

@interface SSNewHomeMainCell : UITableViewCell

+ (CGFloat)getCellHeight;
- (void)setUIWithModel:(SSGoodModel *)model;
- (void)setServiceUIWithModel:(SSGoodModel *)model;
@end
