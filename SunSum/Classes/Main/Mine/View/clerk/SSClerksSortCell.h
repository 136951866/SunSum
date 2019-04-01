//
//  SSClerksSortCell.h
//  SunSum
//
//  Created by hank on 2019/1/6.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSClerksSortModel;

const static CGFloat kSSClerksSortCellHeight = 142;

@interface SSClerksSortCell : UITableViewCell

- (void)setUIWithModel:(SSClerksSortModel *)model;

@end

NS_ASSUME_NONNULL_END
