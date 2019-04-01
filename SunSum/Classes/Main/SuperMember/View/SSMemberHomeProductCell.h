//
//  SSMemberHomeProductCell.h
//  SunSum
//
//  Created by hank on 2018/10/16.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSSuperMemberHomeModel;
@interface SSMemberHomeProductCell : UITableViewCell

+ (CGFloat)getCellHeightWithModel:(SSSuperMemberHomeModel *)model;
- (void)setUiWithModel:(SSSuperMemberHomeModel *)model;

@end
