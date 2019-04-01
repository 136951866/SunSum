//
//  SSClerkCell.h
//  SunSum
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSClerkModel;
const static CGFloat kSSClerkCellHeight = 84;

@interface SSClerkCell : UITableViewCell

- (void)setUIWIthModel:(SSClerkModel *)model;
- (void)setUIWithModel:(SSClerkModel *)model withKey:(NSString *)key;
@property (nonatomic, copy) kMeBasicBlock moreBlock;

@end
