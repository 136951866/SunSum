//
//  SSGoodManngerSpecBasicCell.h
//  SunSum
//
//  Created by hank on 2019/3/28.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SSGoodManngerAddSpecModel;
const static CGFloat kSSGoodManngerSpecBasicCellHeight = 358;

@interface SSGoodManngerSpecBasicCell : UITableViewCell

- (void)setUiWihtModel:(SSGoodManngerAddSpecModel*)model;
@property (weak, nonatomic) IBOutlet UIImageView *imgGood;
@property (nonatomic,copy) kMeBasicBlock touchImgBlock;
@property (strong, nonatomic) SSGoodManngerAddSpecModel *model;
- (void)reloadUI;
@end

NS_ASSUME_NONNULL_END
