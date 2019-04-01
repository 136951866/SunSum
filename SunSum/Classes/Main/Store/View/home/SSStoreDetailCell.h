//
//  SSStoreDetailCell.h
//  SunSum
//
//  Created by hank on 2018/10/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSGoodModel;
const static CGFloat kSSStoreDetailCellHeight = 105.0f;

@interface SSStoreDetailCell : UITableViewCell

- (void)setUIWithModel:(SSGoodModel *)model;

@end
