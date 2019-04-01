//
//  SSThridProductDetailsCommentContontCell.h
//  SunSum
//
//  Created by hank on 2019/1/22.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSGoodDetailCommentModel;

const static CGFloat kSSThridProductDetailsCommentContontCellHeight = 110;
const static CGFloat kSSThridProductDetailsCommentContontCellWdith = 260;

@interface SSThridProductDetailsCommentContontCell : UICollectionViewCell

- (void)setUIWithModel:(SSGoodDetailCommentModel *)model;

@end

NS_ASSUME_NONNULL_END
