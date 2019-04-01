//
//  SSDynamicGoodApplyCell.h
//  SunSum
//
//  Created by hank on 2019/3/25.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSDynamicGoodApplyModel;
const static CGFloat kSSDynamicGoodApplyCellHeight = 538;

@interface SSDynamicGoodApplyCell : UITableViewCell

- (void)setUIWithModel:(SSDynamicGoodApplyModel *)model;
@property (nonatomic,assign) BOOL canEdit;
//        selectImgBlock:(kMeBasicBlock)selectImgBlock;

@end

NS_ASSUME_NONNULL_END
