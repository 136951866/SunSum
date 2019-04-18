//
//  SSClerkPushTaskCell.h
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSClerkPushTaskCellHeight = 241;

@interface SSClerkPushTaskCell : UITableViewCell
- (void)setUIWIthModel:(id)model;
@property (nonatomic,copy)kMeBasicBlock pushTitleBlcok;
@property (nonatomic,copy)kMeBasicBlock pushContentBlcok;
@property (nonatomic,copy)kMeBasicBlock pushTimeBlcok;
@property (nonatomic,copy)kMeBasicBlock SelectClerkBlcok;

@end

NS_ASSUME_NONNULL_END
