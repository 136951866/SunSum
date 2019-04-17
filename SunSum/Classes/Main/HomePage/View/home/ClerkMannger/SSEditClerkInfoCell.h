//
//  SSEditClerkInfoCell.h
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSEditClerkLogCellHeight = 242;


@interface SSEditClerkInfoCell : UITableViewCell

- (void)setMarkUIWithModel:(id)model;
- (void)setNoticeUIWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
