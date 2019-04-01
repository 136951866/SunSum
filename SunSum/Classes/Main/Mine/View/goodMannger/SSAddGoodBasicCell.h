//
//  SSAddGoodBasicCell.h
//  SunSum
//
//  Created by hank on 2019/3/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSAddGoodModel;
const static CGFloat kSSAddGoodBasicCellHeight = 526;

@interface SSAddGoodBasicCell : UITableViewCell

- (void)setUIWithModel:(SSAddGoodModel *)model;
//s
@property (nonatomic,copy)kMeBasicBlock selectType;
//商品x类型
@property (nonatomic,copy)kMeBasicBlock selectGoodType;



@end

NS_ASSUME_NONNULL_END
