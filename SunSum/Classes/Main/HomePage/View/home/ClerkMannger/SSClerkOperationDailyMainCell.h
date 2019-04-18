//
//  SSClerkOperationDailyMainCell.h
//  SunSum
//
//  Created by hank on 2019/4/18.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSClerkOperationDailyMainModel;
const static CGFloat kSSClerkOperationDailyMainCellHeight = 34;

@interface SSClerkOperationDailyMainCell : UITableViewCell

- (void)setUiWithModel:(SSClerkOperationDailyMainModel *)model;

@end

NS_ASSUME_NONNULL_END
