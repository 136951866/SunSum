//
//  SSBrandAllDataCell.h
//  SunSum
//
//  Created by hank on 2019/3/8.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBrandManngerAllModel;
const static CGFloat kSSBrandAllDataCellHeight = 174;

@interface SSBrandAllDataCell : UITableViewCell

- (void)setUIWithModel:(SSBrandManngerAllModel *)model;

@end

NS_ASSUME_NONNULL_END
