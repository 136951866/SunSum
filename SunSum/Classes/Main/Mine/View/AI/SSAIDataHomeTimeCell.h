//
//  SSAIDataHomeTimeCell.h
//  SS时代
//
//  Created by hank on 2019/4/9.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSAIDataHomeTimeModel;
@class SSMonthNotFollowUpMemberModel;
const static CGFloat kSSAIDataHomeTimeCellHeight = 95;

@interface SSAIDataHomeTimeCell : UITableViewCell

- (void)setUIWithModel:(SSAIDataHomeTimeModel *)model;
- (void)setFollowUIWithModel:(SSMonthNotFollowUpMemberModel *)model;

- (void)setPeopleUIWithModel:(SSAIDataHomeTimeModel *)model;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;

@end

NS_ASSUME_NONNULL_END
