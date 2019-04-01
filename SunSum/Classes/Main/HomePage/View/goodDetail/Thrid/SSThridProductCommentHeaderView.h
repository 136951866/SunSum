//
//  SSThridProductCommentHeaderView.h
//  SunSum
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSGoodDetailModel;
typedef enum : NSUInteger {
    SSThridProductCommentHeaderViewAllType = 0,
    SSThridProductCommentHeaderViewGoodType  = 1,
    SSThridProductCommentHeaderViewPhotoType = 2,
} SSThridProductCommentHeaderViewType;

const static CGFloat kSSThridProductCommentHeaderViewHeight = 103;

@interface SSThridProductCommentHeaderView : UIView

@property (nonatomic, copy) kMeIndexBlock selectBlock;
- (void)setUIWithModel:(SSGoodDetailModel *)model type:(SSThridProductCommentHeaderViewType)type;

@end

NS_ASSUME_NONNULL_END
