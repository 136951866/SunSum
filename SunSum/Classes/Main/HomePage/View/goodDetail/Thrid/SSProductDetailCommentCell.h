//
//  SSProductDetailCommentCell.h
//  SunSum
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSGoodsCommentModel;

@interface SSProductDetailCommentCell : UITableViewCell

- (void)setUiWIthModel:(SSGoodsCommentModel *)model;
+ (CGFloat)getCellHeightWithModel:(SSGoodsCommentModel *)model;


@end

NS_ASSUME_NONNULL_END
