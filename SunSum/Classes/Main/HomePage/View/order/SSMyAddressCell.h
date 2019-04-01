//
//  SSMyAddressCell.h
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSAddressModel;
const static CGFloat kSSMyAddressCellHeight = 100;

@interface SSMyAddressCell : UITableViewCell

@property (nonatomic, copy)kMeBasicBlock editBlock;
- (void)setUIWithModel:(SSAddressModel *)model isSelect:(BOOL)isSelect;

@end
