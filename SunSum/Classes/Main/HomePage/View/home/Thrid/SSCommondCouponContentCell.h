//
//  SSCommondCouponContentCell.h
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSPinduoduoCoupleModel;
const static CGFloat kSSCommondCouponContentCellWdith = 105;
const static CGFloat kSSCommondCouponContentCellHeight = 135;


@interface SSCommondCouponContentCell : UICollectionViewCell

- (void)setUIWithModel:(SSPinduoduoCoupleModel *)model;

@end

NS_ASSUME_NONNULL_END
