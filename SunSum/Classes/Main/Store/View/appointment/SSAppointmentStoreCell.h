//
//  SSAppointmentStoreCell.h
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSStoreModel;
const static CGFloat kSSAppointmentStoreCellHeight = 61;

@interface SSAppointmentStoreCell : UITableViewCell

- (void)setUIWIthModel:(SSStoreModel *)model isSelect:(BOOL)isSelect;



@end
