//
//  SSFFourCaseHeaderView.h
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSFFourCaseHeaderViewHeight = 103;

@interface SSFFourCaseHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy)kMeIndexBlock selectBlock;

@end

NS_ASSUME_NONNULL_END
