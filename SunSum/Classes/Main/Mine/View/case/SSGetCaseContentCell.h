//
//  SSGetCaseContentCell.h
//  SunSum
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSGetCaseContentModel;
const static CGFloat kSSGetCaseContentCellHeight = 110;

@interface SSGetCaseContentCell : UITableViewCell

- (void)setUIWIthModel:(SSGetCaseContentModel *)model;
+ (CGFloat)getCellHeightWithModel:(SSGetCaseContentModel *)model;


- (void)setUIDataDealWIthModel:(SSGetCaseContentModel *)model;

@end
