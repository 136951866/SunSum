//
//  SSMyOrderDetailCell.h
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSMyOrderDetailCellHeight = 49;

@interface SSMyOrderDetailCell : UITableViewCell

- (void)setUIWithModel:(id)model Type:(SSOrderSettlmentStyle)type orderType:(SSOrderStyle)orderType;
- (void)setAppointUIWithModel:(id)model appointType:(SSAppointmentSettlmentStyle)type orderType:(SSAppointmenyStyle)orderType;

@end
