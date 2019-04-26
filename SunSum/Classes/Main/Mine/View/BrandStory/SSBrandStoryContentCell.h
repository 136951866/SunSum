//
//  SSBrandStoryContentCell.h
//  SunSum
//
//  Created by hank on 2019/4/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSBrandStoryContentCellHeight = 189;

@class MEBrandStoryContentModel;
@interface SSBrandStoryContentCell : UITableViewCell

- (void)setUIWIthModel:(MEBrandStoryContentModel *)model;

//@property (nonatomic, copy)kMeBasicBlock addtxtBlcok;
//@property (nonatomic, copy)kMeBasicBlock addvideoBlcok;
@property (nonatomic, copy)kMeIndexBlock addBlcok;
@property (nonatomic, copy)kMeBasicBlock delBlcok;

@end

NS_ASSUME_NONNULL_END
