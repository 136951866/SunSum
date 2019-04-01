//
//  SSVistorPathCell.h
//  SunSum
//
//  Created by hank on 2018/11/29.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSVistorUserPathModel;
const static CGFloat kSSVistorPathCellHeight = 59;

@interface SSVistorPathCell : UITableViewCell

- (void)setUiWIthModel:(SSVistorUserPathModel *)model count:(NSInteger)count;

@end
