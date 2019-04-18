//
//  SSPushContentCell.h
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTextView.h"

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSPushContentCellHeight = 200;

@interface SSPushContentCell : UITableViewCell
- (void)setUIWithModel:(NSString *)model;
@property (nonatomic , strong) SSTextView *textView;
@end

NS_ASSUME_NONNULL_END
