//
//  SSThridProductDetailsHeaderView.h
//  SunSum
//
//  Created by hank on 2019/1/22.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSGoodDetailModel;
@interface SSThridProductDetailsHeaderView : UIView

- (void)setUIWithModel:(SSGoodDetailModel *)model;
+ (CGFloat)getHeightWithModel:(SSGoodDetailModel *)model;
-(void)downSecondHandle:(NSString *)aTimeString;

@end

NS_ASSUME_NONNULL_END
