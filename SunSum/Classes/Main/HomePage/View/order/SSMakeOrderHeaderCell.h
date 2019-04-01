//
//  SSMakeOrderHeaderCell.h
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSGoodDetailModel;
@class SSShoppingCartModel;

const static CGFloat kSSMakeOrderHeaderCellHeight = 111;

@interface SSMakeOrderHeaderCell : UITableViewCell

//isComb 是否是980活动 isInteral是否兑换
- (void)setUIWithModle:(SSGoodDetailModel *)model isComb:(BOOL)isComb isInteral:(BOOL)isInteral;
- (void)setShopCartUIWithModle:(SSShoppingCartModel *)model;

@end
