//
//  SSThridHomeHeaderView.h
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSStoreModel;
@class SSThridHomeModel;
const static CGFloat kSdHeight = 178;
const static CGFloat kSecondImageHeight = 154;
const static CGFloat kThridImageWidth = 177;
const static CGFloat kThridImageHeight = 200;
@interface SSThridHomeHeaderView : UIView

+ (CGFloat)getViewHeightWithModel:(SSThridHomeModel *)model;
//- (void)setUIWithModel:(SSThridHomeModel *)model;
- (void)setUIWithModel:(SSThridHomeModel *)model stroeModel:(SSStoreModel *)storemodel;

@end

NS_ASSUME_NONNULL_END
