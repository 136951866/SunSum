//
//  SSAddGoodAssembleCell.h
//  SunSum
//
//  Created by hank on 2019/3/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSAddGoodModel;

const static CGFloat kSSAddGoodAssembleCellHeight = 361;

@interface SSAddGoodAssembleCell : UITableViewCell
- (void)setUIWithModel:(SSAddGoodModel *)model;

@end

NS_ASSUME_NONNULL_END
