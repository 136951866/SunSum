//
//  SSBDataDealStoreAchievementView.h
//  SunSum
//
//  Created by hank on 2019/2/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBDataDealModel;
@interface SSBDataDealStoreAchievementView : UIView

+(CGFloat)getViewHeightWithModel:(SSBDataDealModel *)model;
- (void)setUIWithModel:(SSBDataDealModel *)model;

@end

NS_ASSUME_NONNULL_END
