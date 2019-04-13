//
//  SSNoticeCell.h
//  SunSum
//
//  Created by hank on 2018/11/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSNoticeModel;
const static CGFloat kSSNoticeCellHeight = 72;

@interface SSNoticeCell : UITableViewCell

- (void)setUIWIthModel:(SSNoticeModel *)model;

@end
