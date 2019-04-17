//
//  SSPushContentCell.h
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSPushContentCellHeight = 200;

@interface SSPushContentCell : UITableViewCell
- (void)setUIWithModel:(id)model;
@end

NS_ASSUME_NONNULL_END
