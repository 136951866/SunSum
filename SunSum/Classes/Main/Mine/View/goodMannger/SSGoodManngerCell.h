//
//  SSGoodManngerCell.h
//  SunSum
//
//  Created by hank on 2019/3/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSGoodManngerCellHeight = 202;

@class SSGoodManngerModel;
@interface SSGoodManngerCell : UITableViewCell

@property (nonatomic, copy) kMeBasicBlock delBlock;
- (void)setUiWithModel:(SSGoodManngerModel *)model;

@end

NS_ASSUME_NONNULL_END
