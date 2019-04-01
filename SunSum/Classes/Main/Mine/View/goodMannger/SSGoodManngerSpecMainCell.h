//
//  SSGoodManngerSpecMainCell.h
//  SunSum
//
//  Created by hank on 2019/3/28.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSGoodManngerAddSpecModel;
@class SSGoodManngerSpecBasicCell;
typedef void (^kMeSpecBasicCellBlock)(SSGoodManngerSpecBasicCell *cell);

@interface SSGoodManngerSpecMainCell : UITableViewCell

+ (CGFloat)getCellHeightWithModel:(SSGoodManngerAddSpecModel*)model;
- (void)setUiWihtModel:(SSGoodManngerAddSpecModel*)model;
@property (nonatomic, copy) kMeBasicBlock delBlock;
@property (nonatomic, copy) kMeSpecBasicCellBlock tapImgBlock;

@end

NS_ASSUME_NONNULL_END
