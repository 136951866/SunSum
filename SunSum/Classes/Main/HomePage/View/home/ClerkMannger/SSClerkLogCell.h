//
//  SSClerkLogCell.h
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSClerkLogCellOrgialHeight = 213;

NS_ASSUME_NONNULL_BEGIN

@class SSNewClerkManngerModel;
@interface SSClerkLogCell : UITableViewCell

- (void)setUIWithArr:(SSNewClerkManngerModel *)model;
+ (CGFloat)getCellHeightWithArr:(SSNewClerkManngerModel *)model;

@property (nonatomic,copy)kMeIndexBlock selectIndexBlock;

@end

NS_ASSUME_NONNULL_END
