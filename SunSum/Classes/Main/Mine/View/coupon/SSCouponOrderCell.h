//
//  SSCouponOrderCell.h
//  SunSum
//
//  Created by hank on 2018/12/27.
//  Copyright © 2018 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSCouponOrderCellHeight = 144;
@class SSCouponMoneyModel;
@class SSJDCouponMoneyModel;
NS_ASSUME_NONNULL_BEGIN

@interface SSCouponOrderCell : UITableViewCell

- (void)setUIWithModel:(SSCouponMoneyModel *)model;
- (void)setJDUIWithModel:(SSJDCouponMoneyModel *)model;

@end

NS_ASSUME_NONNULL_END
