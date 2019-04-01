//
//  SSRushBuyContentCell.h
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSThridHomeRudeGoodModel;
const static CGFloat kSSRushBuyContentCellHeight = 150;

@interface SSRushBuyContentCell : UITableViewCell

- (void)setUIWithModel:(SSThridHomeRudeGoodModel *)model;

@end

NS_ASSUME_NONNULL_END
