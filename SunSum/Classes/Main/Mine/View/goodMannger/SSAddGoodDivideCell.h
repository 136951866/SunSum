//
//  SSAddGoodDivideCell.h
//  SunSum
//
//  Created by hank on 2019/3/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSAddGoodDivideCellHeight = 238;
@class SSAddGoodModel;

@interface SSAddGoodDivideCell : UITableViewCell
- (void)setUIWithModel:(SSAddGoodModel *)model;

@end

NS_ASSUME_NONNULL_END
