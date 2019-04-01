//
//  SSVisterDetailCell.h
//  SunSum
//
//  Created by hank on 2018/11/29.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSSpreadUserModel;
@class SSVistorUserModel;
const static CGFloat kSSVisterDetailCellHeight = 436;

@interface SSVisterDetailCell : UITableViewCell

- (void)setUIWithModle:(SSVistorUserModel *)model dicUser:(SSSpreadUserModel *)dicUser;

@end
