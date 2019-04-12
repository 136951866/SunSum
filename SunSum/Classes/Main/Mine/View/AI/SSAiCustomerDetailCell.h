//
//  SSAiCustomerDetailCell.h
//  SS时代
//
//  Created by hank on 2019/4/10.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSAiCustomerDetailModel;
@interface SSAiCustomerDetailCell : UITableViewCell

- (void)setUIWithModel:(SSAiCustomerDetailModel *)model;
+ (CGFloat)getCellHeightWithModel:(SSAiCustomerDetailModel *)model;

@property (nonatomic , copy) kMeBasicBlock followBlock;
@property (nonatomic , copy) kMeBasicBlock addTagBlock;

@end

NS_ASSUME_NONNULL_END
