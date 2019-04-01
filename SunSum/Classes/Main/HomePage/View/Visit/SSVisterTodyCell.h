//
//  SSVisterTodyCell.h
//  SunSum
//
//  Created by hank on 2018/11/28.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSVisterTodyCellwHeight = 214;


@interface SSVisterTodyCell : UITableViewCell
- (void)setUiWithModel:(NSNumber *)model posterCount:(NSNumber*)posterCount;
@end
