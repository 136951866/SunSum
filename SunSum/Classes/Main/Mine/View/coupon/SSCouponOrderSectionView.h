//
//  SSCouponOrderSectionView.h
//  SunSum
//
//  Created by hank on 2019/2/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    SSCouponOrderSectionViewPinduoduoType,
    SSCouponOrderSectionViewJDType,
} SSCouponOrderSectionViewType;


const static CGFloat kSSCouponOrderSectionViewHeight = 49;

@interface SSCouponOrderSectionView : UITableViewHeaderFooterView

@property (nonatomic, copy) kMeIndexBlock selectBlock;
@property (nonatomic, assign) SSCouponOrderSectionViewType type;
@end

NS_ASSUME_NONNULL_END
