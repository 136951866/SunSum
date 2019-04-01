//
//  SSDistributionOrderCell.h
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSDistrbutionOrderModel;
const static CGFloat kSSDistributionOrderCellHeight = 132;

@interface SSDistributionOrderCell : UITableViewCell

- (void)setUIWithModel:(id)model Type:(SSDistrbutionOrderStyle)type;
- (void)setUIWithModel:(SSDistrbutionOrderModel *)model;

@end
