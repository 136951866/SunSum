//
//  SSLogisticsCell.h
//  SunSum
//
//  Created by hank on 2018/10/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSLogistDataModel;
const static CGFloat kSSLogisticsCellHeight = 62.0f;

@interface SSLogisticsCell : UITableViewCell

+ (CGFloat)getCellHeightWithModel:(SSLogistDataModel *)model;
- (void)setUIWIthModel:(SSLogistDataModel *)model isSelect:(BOOL)isSelect;

@end
