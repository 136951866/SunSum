//
//  SSClerkTaskCell.h
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSClerkTaskCellOrgialHeight = 251;

@interface SSClerkTaskCell : UITableViewCell

- (void)setUIWithArr:(NSArray *)arr;
+ (CGFloat)getCellHeightWithArr:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
