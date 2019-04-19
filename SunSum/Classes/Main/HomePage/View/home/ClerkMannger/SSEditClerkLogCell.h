//
//  SSEditClerkLogCell.h
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSClerkFinishTaskModel;
const static CGFloat kSSEditClerkLogCellHeight = 333;

@interface SSEditClerkLogCell : UITableViewCell
- (void)setUIWIthModel:(SSClerkFinishTaskModel *)model;
+ (CGFloat)getCellHeightWithModel:(SSClerkFinishTaskModel *)model;

@property (nonatomic,copy)kMeBasicBlock notichBlock;
@property (nonatomic,copy)kMeBasicBlock markBlock;
@property (nonatomic,copy)kMeBasicBlock serverBlock;

@end

NS_ASSUME_NONNULL_END
