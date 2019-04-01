//
//  SSPosterContentListCell.h
//  SunSum
//
//  Created by hank on 2018/11/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSPosterModel;
const static CGFloat kSSPosterContentListCellHeight  = 285;
@interface SSPosterContentListCell : UITableViewCell

- (void)setUIWithModel:(SSPosterModel *)model;
@property (nonatomic, copy) kMeBasicBlock moreBlock;
+ (CGFloat)getCellWithModel:(SSPosterModel *)model;

@end
