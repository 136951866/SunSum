//
//  SSPosterContentListContentCell.h
//  SunSum
//
//  Created by hank on 2018/11/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSPosterChildrenModel;
const static CGFloat kSSPosterContentListContentCellHeight  = 152;
#define kSSPosterContentListContentCellWdith (102)

@interface SSPosterContentListContentCell : UICollectionViewCell

- (void)setUIWithModel:(SSPosterChildrenModel *)model;
@end
