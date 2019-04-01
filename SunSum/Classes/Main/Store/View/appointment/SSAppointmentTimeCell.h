//
//  SSAppointmentTimeCell.h
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

# define kSSAppointmentTimeCellWdith ((SCREEN_WIDTH - 30)/5)
# define kSSAppointmentTimeCellHeight (45)

@interface SSAppointmentTimeCell : UICollectionViewCell

- (void)setUIWithModel:(SSTimeModel *)model isSelect:(BOOL)isSelect;

@end
