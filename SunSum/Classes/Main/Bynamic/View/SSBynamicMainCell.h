//
//  SSBynamicMainCell.h
//  SunSum
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBynamicHomeModel;
@interface SSBynamicMainCell : UITableViewCell
- (void)setUIWithModel:(SSBynamicHomeModel *)model;
+ (CGFloat)getCellHeightithModel:(SSBynamicHomeModel *)model;
@property (nonatomic, copy) kMeBasicBlock shareBlock;
@property (nonatomic, copy) kMeBasicBlock LikeBlock;
@property (nonatomic, copy) kMeBasicBlock CommentBlock;
@property (nonatomic, copy) kMeBasicBlock delBlock;
@end

NS_ASSUME_NONNULL_END
