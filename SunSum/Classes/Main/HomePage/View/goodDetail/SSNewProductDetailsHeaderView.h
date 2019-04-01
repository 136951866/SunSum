//
//  SSNewProductDetailsHeaderView.h
//  SunSum
//
//  Created by hank on 2019/1/9.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SSGoodDetailModel;
@interface SSNewProductDetailsHeaderView : UIView


- (void)reloadStockAndSaled:(SSGoodDetailModel *)model;
- (void)setUIWithModel:(SSGoodDetailModel *)model;
+ (CGFloat)getHeightWithModel:(SSGoodDetailModel *)model;

@property (nonatomic, strong) kMeBasicBlock selectSkuBlock;

@end

NS_ASSUME_NONNULL_END
