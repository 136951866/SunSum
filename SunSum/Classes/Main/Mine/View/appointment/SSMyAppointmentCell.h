//
//  SSMyAppointmentCell.h
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSAppointmentModel;
const static CGFloat kSSMyAppointmentCellHeight = 165.0;

@interface SSMyAppointmentCell : UITableViewCell

- (void)setBUIWithModel:(SSAppointmentModel *)model Type:(SSAppointmenyStyle)type;
- (void)setUIWithModel:(SSAppointmentModel *)model Type:(SSAppointmenyStyle)type;
@property (nonatomic, copy) kMeBasicBlock cancelAppointBlock;

@end
