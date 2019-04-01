//
//  SSAppointmentTimeMainCell.h
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSAppointmentTimeMainCell : UITableViewCell

@property (copy, nonatomic) kMeIndexBlock selectBlock;;

- (void)setUIWithArr:(NSArray *)arr currentIndex:(NSInteger)index;
+ (CGFloat)getCellHeightWithArr:(NSArray *)arr;


@end
