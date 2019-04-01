//
//  SSAppointmentDateCell.h
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSAppointmentDateCellHeight = 50;
const static CGFloat kSSAppointmentDateCellWidth = 67;

@interface SSAppointmentDateCell : UICollectionViewCell

- (void)setUIWithModel:(SSTimeModel *)model isSelect:(BOOL)isSelect;

@end
