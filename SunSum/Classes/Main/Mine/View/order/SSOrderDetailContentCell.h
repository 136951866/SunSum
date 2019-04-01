//
//  SSOrderDetailContentCell.h
//  SunSum
//
//  Created by gao lei on 2018/9/18.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSAppointDetailModel;
@class SSOrderGoodModel;
@class SSOrderDetailModel;

const static CGFloat kSSOrderDetailContentCellHeight = 131;

@interface SSOrderDetailContentCell : UITableViewCell

//
//- (void)setUiWithModel:(SSOrderDetailModel *)model;
//订单
- (void)setUIWithChildModel:(SSOrderGoodModel *)model;
//预约
- (void)setAppointUIWithChildModel:(SSAppointDetailModel *)model;

@end
