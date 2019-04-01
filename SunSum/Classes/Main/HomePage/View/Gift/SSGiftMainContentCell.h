//
//  SSGiftMainContentCell.h
//  SunSum
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSShoppingCartModel;
const static CGFloat kSSGiftMainContentCellHeight = 85;

@interface SSGiftMainContentCell : UITableViewCell

/**
 加
 */
@property (nonatomic, copy) kMeLblBlock AddBlock;

/**
 减
 */
@property (nonatomic, copy) kMeLblBlock CutBlock;

- (void)setUIWIthModel:(SSShoppingCartModel *)model;
@end
