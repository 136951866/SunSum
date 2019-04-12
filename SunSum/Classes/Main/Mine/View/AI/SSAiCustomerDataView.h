//
//  SSAiCustomerDataView.h
//  SS时代
//
//  Created by hank on 2019/4/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSAiCustomerDataModel;
const static CGFloat kSSAiCustomerDataViewHeight = 773;

@interface SSAiCustomerDataView : UIView

@property (nonatomic, copy) kMeBasicBlock saveBlock;
@property (nonatomic, strong) SSAiCustomerDataModel *model;
- (void)reloadUI;
@end

NS_ASSUME_NONNULL_END
