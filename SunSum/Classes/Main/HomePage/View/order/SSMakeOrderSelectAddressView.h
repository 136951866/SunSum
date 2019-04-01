//
//  SSMakeOrderSelectAddressView.h
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSAddressModel;
const static CGFloat kSSMakeOrderSelectAddressViewHeight = 60;

@interface SSMakeOrderSelectAddressView : UITableViewHeaderFooterView

@property (nonatomic, strong) kMeBasicBlock selectAddressBlock;
- (void)setUIWithModel:(SSAddressModel *)model;
+ (CGFloat)getViewHeightWithModel:(SSAddressModel *)model;

@end
