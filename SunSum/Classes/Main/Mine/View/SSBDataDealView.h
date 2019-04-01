//
//  SSBDataDealView.h
//  SS时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSBDataDealModel;
const static CGFloat kSSBDataDealViewHeight = 513;

@interface SSBDataDealView : UIView

- (void)setUIWithModel:(SSBDataDealModel *)Model;

@end
