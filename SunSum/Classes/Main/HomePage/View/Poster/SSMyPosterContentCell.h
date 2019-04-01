//
//  SSMyPosterContentCell.h
//  SunSum
//
//  Created by hank on 2018/11/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSPosterChildrenModel;
@class SSActivePosterModel;
const static CGFloat kSSMyPosterContentIMageHeight  = 152;
const static CGFloat kSSMyPosterContentCellOrgialHeight  = 220;
//#define kSSMyPosterContentIMageWdith (102 *kMeFrameScaleX())
#define kSSMyPosterContentCellWdith ((SCREEN_WIDTH - (k10Margin*4))/3)

@interface SSMyPosterContentCell : UICollectionViewCell
//我的分享
- (void)setiWithModel:(SSPosterChildrenModel *)Model;
//更多
- (void)setiWitMorehModel:(SSPosterChildrenModel *)Model;
//活动
- (void)setiActiveWithModel:(SSActivePosterModel *)Model;

+ (CGFloat)getCellHeight;

@property (nonatomic, copy) kMeBasicBlock delBlock;
@property (nonatomic, copy) kMeBasicBlock btnBlock;

@end
