//
//  SSEditClerkInfoCell.h
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTextView.h"
NS_ASSUME_NONNULL_BEGIN

@class SSClerkFinishTaskModel;
const static CGFloat kSSEditClerkLogCellHeight = 242;


@interface SSEditClerkInfoCell : UITableViewCell

- (void)setMarkUIWithModel:(SSClerkFinishTaskModel *)model;
- (void)setNoticeUIWithModel:(SSClerkFinishTaskModel *)model;
- (void)setServerUIWithModel:(SSClerkFinishTaskModel *)model;
@property (nonatomic , strong) SSTextView *textView;

@end

NS_ASSUME_NONNULL_END
