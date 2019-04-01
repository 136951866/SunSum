//
//  SSAppointmentDateMainCell.h
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSAppointmentDateMainCellHeight = 125;

@interface SSAppointmentDateMainCell : UITableViewCell

@property (copy, nonatomic) kMeIndexBlock selectBlock;
- (void)setUIWithArr:(NSArray *)arr currentIndex:(NSInteger)index;

@end
