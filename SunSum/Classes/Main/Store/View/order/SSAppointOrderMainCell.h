//
//  SSAppointOrderMainCell.h
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSServiceDetailsModel;
@class SSAppointAttrModel;

//const static CGFloat kSSAppointOrderMainCellHeight = 360;
const static CGFloat kSSAppointOrderMainCellHeight = 287;//265;
@interface SSAppointOrderMainCell : UITableViewCell

- (void)setUIWithModel:(SSServiceDetailsModel *)model attrModel:(SSAppointAttrModel *)attrModel;

@end
