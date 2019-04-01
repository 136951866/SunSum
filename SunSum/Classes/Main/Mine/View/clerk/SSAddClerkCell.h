//
//  SSAddClerkCell.h
//  SunSum
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSClerkModel;
const static CGFloat kSSAddClerkCellHeight = 84;

@interface SSAddClerkCell : UITableViewCell

- (void)setUIWIthModel:(SSClerkModel *)model;
- (void)setUIWithModel:(SSClerkModel *)model withKey:(NSString *)key;
@property (nonatomic, copy) kMeBasicBlock updateBlock;

@end
