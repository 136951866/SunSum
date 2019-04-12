//
//  SSAICustomerHomeCell.h
//  SS时代
//
//  Created by hank on 2019/4/10.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSAICustomerHomeModel;
const static CGFloat kSSAICustomerHomeCellHeight = 77;

@interface SSAICustomerHomeCell : UITableViewCell

- (void)setUiWithAddModel:(SSAICustomerHomeModel *)model;
- (void)setSearchUiWithAddModel:(SSAICustomerHomeModel *)model;
@end

NS_ASSUME_NONNULL_END
