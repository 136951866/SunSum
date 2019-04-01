//
//  SSThridNoticeProductDetailsHeaderView.h
//  SunSum
//
//  Created by hank on 2019/1/24.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSGoodDetailModel;
@interface SSThridNoticeProductDetailsHeaderView : UIView

- (void)setNormalUIWithModel:(SSGoodDetailModel *)model;
- (void)setUINoticeWithModel:(SSGoodDetailModel *)model;
+ (CGFloat)getNormalHeightWithModel:(SSGoodDetailModel *)model;
+ (CGFloat)getNoticeHeightWithModel:(SSGoodDetailModel *)model;
-(void)downSecondHandle:(NSString *)aTimeString;

@end

NS_ASSUME_NONNULL_END
