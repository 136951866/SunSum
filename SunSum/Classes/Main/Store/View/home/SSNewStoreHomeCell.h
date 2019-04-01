//
//  SSNewStoreHomeCell.h
//  SunSum
//
//  Created by hank on 2019/1/22.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSStoreModel;
const static CGFloat kSSNewStoreHomeCellHeight = 99;

@interface SSNewStoreHomeCell : UITableViewCell

- (void)setUIWithModel:(SSStoreModel *)model;
- (void)setUIWithModel:(SSStoreModel *)model WithKey:(NSString *)key;
+ (CGFloat)getCellHeightWithmodel:(SSStoreModel *)model;

@end

NS_ASSUME_NONNULL_END
