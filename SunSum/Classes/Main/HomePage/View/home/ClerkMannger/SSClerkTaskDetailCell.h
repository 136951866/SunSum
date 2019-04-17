//
//  SSClerkTaskDetailCell.h
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSClerkTaskDetailCellHeight = 172;

@interface SSClerkTaskDetailCell : UITableViewCell
- (void)setUIWIthModel:(id)model;
+ (CGFloat)getCellHeightWithModel:(NSObject *)model;
@end

NS_ASSUME_NONNULL_END
