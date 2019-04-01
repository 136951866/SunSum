//
//  SSShoppingMallCell.h
//  SunSum
//
//  Created by hank on 2018/12/18.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSGoodModel;
#define kSSShoppingMallCellHeight  (149 * kMeFrameScaleX())

@interface SSShoppingMallCell : UITableViewCell

- (void)setUIWithModel:(SSGoodModel *)model;

@end
