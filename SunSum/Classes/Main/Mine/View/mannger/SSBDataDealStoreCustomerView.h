//
//  SSBDataDealStoreCustomerView.h
//  SunSum
//
//  Created by hank on 2019/2/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBDataDealModel;
@interface SSBDataDealStoreCustomerView : UIView

- (void)setUIWithModel:(SSBDataDealModel *)model;
+(CGFloat)getViewHeightWithModel:(SSBDataDealModel *)model;

@end

NS_ASSUME_NONNULL_END
