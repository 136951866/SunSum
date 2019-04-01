//
//  SSBStoreMannagerCell.h
//  SunSum
//
//  Created by hank on 2019/2/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBStoreMannagercontentInfoModel;
const static CGFloat kSSBStoreMannagerCellHeight = 44;

@interface SSBStoreMannagerCell : UITableViewCell

- (void)setUiWithModel:(SSBStoreMannagercontentInfoModel *)model;
+ (CGFloat)getCellHeightWithModel:(SSBStoreMannagercontentInfoModel*)model;

@end

NS_ASSUME_NONNULL_END
