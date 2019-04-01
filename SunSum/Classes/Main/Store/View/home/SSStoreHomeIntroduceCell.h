//
//  SSStoreHomeIntroduceCell.h
//  SunSum
//
//  Created by hank on 2018/10/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSStoreDetailModel;
const static CGFloat kSSStoreHomeIntroduceCellHeight = 120;

@interface SSStoreHomeIntroduceCell : UITableViewCell

- (void)setUIWithModel:(SSStoreDetailModel *)model isExpand:(BOOL)isExpand ExpandBlock:(kMeBOOLBlock)expandBlock;
+ (CGFloat)getCellHeightWithModel:(SSStoreDetailModel *)model isExpand:(BOOL)isExpand;
@end
