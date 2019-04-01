//
//  SSDistrbutionMyTeamCell.h
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSDistributionTeamModel;

const static CGFloat kSSDistrbutionMyTeamCellHeight = 80;

@interface SSDistrbutionMyTeamCell : UITableViewCell

- (void)setUIWithModel:(SSDistributionTeamModel *)model;
@end
