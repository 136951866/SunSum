//
//  SSBaoQiangCell.h
//  SunSum
//
//  Created by hank on 2018/9/6.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSBaoQiangCellHeoght  = 286;
const static CGFloat kSSBaoQiangCellTitleHeight  = 34;

@interface SSBaoQiangCell : UITableViewCell

- (void)setUIWithArr:(NSArray *)arrModel;
@property (nonatomic, copy) kMeIndexBlock indexBlock;

+ (CGFloat)getCellHeightWithArr:(NSArray *)arr;

@end
