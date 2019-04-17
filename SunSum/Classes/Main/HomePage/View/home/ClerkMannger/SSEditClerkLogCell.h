//
//  SSEditClerkLogCell.h
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSEditClerkLogCellHeight = 283;

@interface SSEditClerkLogCell : UITableViewCell
- (void)setUIWIthModel:(id)model;
+ (CGFloat)getCellHeightWithModel:(NSObject *)model;

@property (nonatomic,copy)kMeBasicBlock notichBlock;
@property (nonatomic,copy)kMeBasicBlock markBlock;

@end

NS_ASSUME_NONNULL_END
