//
//  SSClerkFollowCell.h
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class SSClerkNotFollowUpMember;
const static CGFloat kSSClerkFollowCellHeight = 213;


@interface SSClerkFollowCell : UITableViewCell

- (void)setUiWithModel:(SSClerkNotFollowUpMember *)model;

@end

NS_ASSUME_NONNULL_END
