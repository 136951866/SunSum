//
//  SSBNewDataDealView.h
//  SunSum
//
//  Created by hank on 2019/2/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBDataDealModel;
const static CGFloat kSSBNewDataDealViewHeight = 1197;

@interface SSBNewDataDealView : UIView

- (void)setUIWithModel:(SSBDataDealModel *)Model;

@property (nonatomic, copy) kMeBasicBlock StructBlock;
@property (nonatomic, copy) kMeBasicBlock storeCustomer;

@end

NS_ASSUME_NONNULL_END
