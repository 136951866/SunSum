//
//  SSGetCaseMainCell.h
//  SunSum
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSGetCaseMainModel;
const static CGFloat kSSGetCaseMainCellHeight = 205;

@interface SSGetCaseMainCell : UITableViewCell

- (void)setUIWithModel:(SSGetCaseMainModel *)model;
+(CGFloat)getCellHeightWithModel:(SSGetCaseMainModel *)model;
@end
