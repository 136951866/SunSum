//
//  SSClerkTaskCell.h
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SSNewClerkManngerModel;
const static CGFloat kSSClerkTaskCellOrgialHeight = 251;

@interface SSClerkTaskCell : UITableViewCell

- (void)setUIWithArr:(SSNewClerkManngerModel *)model;
+ (CGFloat)getCellHeightWithArr:(SSNewClerkManngerModel *)model;

@property (nonatomic, copy) kMeBasicBlock moreBlock;

@end

NS_ASSUME_NONNULL_END
