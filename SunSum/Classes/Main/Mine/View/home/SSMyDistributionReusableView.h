//
//  SSMyDistributionReusableView.h
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSDistributionCentreModel;
@class SSadminDistributionModel;
const static CGFloat kSSMyDistributionHeaderViewHeight = 290.0;

@interface SSMyDistributionReusableView : UICollectionReusableView

//C端
- (void)setUIWithModel:(SSDistributionCentreModel *)model;
//B端
- (void)setUIBWithModel:(SSadminDistributionModel *)model;
//提现
@property (nonatomic, copy) kMeBasicBlock costBlock;
@end
