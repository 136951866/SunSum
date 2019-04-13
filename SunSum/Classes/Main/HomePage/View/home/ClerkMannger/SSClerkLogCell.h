//
//  SSClerkLogCell.h
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSClerkLogCellOrgialHeight = 213;

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkLogCell : UITableViewCell

- (void)setUIWithArr:(NSArray *)arr;
+ (CGFloat)getCellHeightWithArr:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
