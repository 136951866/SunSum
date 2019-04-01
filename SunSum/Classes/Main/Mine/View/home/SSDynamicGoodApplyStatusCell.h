//
//  SSDynamicGoodApplyStatusCell.h
//  SunSum
//
//  Created by hank on 2019/3/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSDynamicGoodApplyModel;
const static CGFloat kSSDynamicGoodApplyStatusCellHeight = 162;

@interface SSDynamicGoodApplyStatusCell : UITableViewCell

- (void)setUIWithModel:(SSDynamicGoodApplyModel *)model;

@end

NS_ASSUME_NONNULL_END
