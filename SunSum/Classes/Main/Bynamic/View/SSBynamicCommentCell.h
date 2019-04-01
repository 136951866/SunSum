//
//  SSBynamicCommentCell.h
//  SunSum
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBynamicHomecommentModel;
@interface SSBynamicCommentCell : UITableViewCell

- (void)setUIWithModel:(SSBynamicHomecommentModel *)model;
+ (CGFloat)getCellHeightWithhModel:(SSBynamicHomecommentModel *)model;

@end

NS_ASSUME_NONNULL_END
