//
//  SSGetCaseCell.h
//  SunSum
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSGetCaseModel;
@interface SSGetCaseCell : UITableViewCell

+ (CGFloat)getCellHeightWithModel:(SSGetCaseModel *)model;
+ (CGFloat)getCellDataDealHeightWithModel:(SSGetCaseModel *)model;
- (void)setUIDataDealWIthModel:(SSGetCaseModel *)model;
- (void)setUIWithModel:(SSGetCaseModel *)model;

@end
