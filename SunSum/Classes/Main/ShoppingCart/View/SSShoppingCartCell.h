//
//  SSShoppingCartCell.h
//  SunSum
//
//  Created by hank on 2018/9/8.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSShoppingCartModel;
const static CGFloat kSSShoppingCartCellHeight = 117;

@interface SSShoppingCartCell : UITableViewCell

- (void)setUIWIthModel:(SSShoppingCartModel *)model;

/**
 选中
 */
@property (nonatomic, copy) kMeBOOLBlock ClickRowBlock;

/**
 加
 */
@property (nonatomic, copy) kMeLblBlock AddBlock;

/**
 减
 */
@property (nonatomic, copy) kMeLblBlock CutBlock;




@end
