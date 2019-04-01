//
//  SSStoreHomeCell.h
//  SunSum
//
//  Created by hank on 2018/9/7.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSStoreModel;
#define kSSStoreHomeCellHeight  (89 + (220 *kMeFrameScaleY()))

@interface SSStoreHomeCell : UITableViewCell

- (void)setUIWithModel:(SSStoreModel *)model;
- (void)setUIWithModel:(SSStoreModel *)model WithKey:(NSString *)key;
+ (CGFloat)getCellHeightWithModel:(SSStoreModel *)model;
@end
