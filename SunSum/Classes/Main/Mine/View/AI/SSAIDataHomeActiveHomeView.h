//
//  SSAIDataHomeActiveHomeView.h
//  SS时代
//
//  Created by hank on 2019/4/9.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    SSAIDataHomeActiveHomeViewAllType = 0,
    SSAIDataHomeActiveHomeViewtodayType = 1,
    SSAIDataHomeActiveHomeViewsevenAllType = 2,
    SSAIDataHomeActiveHomeViewmonthType = 3,
} SSAIDataHomeActiveHomeViewType;

const static CGFloat kSSAIDataHomeActiveHomeViewHeight = 55;

@interface SSAIDataHomeActiveHomeView : UITableViewHeaderFooterView

@property (nonatomic, copy) kMeIndexBlock selectBlock;
- (void)setUiWithType:(SSAIDataHomeActiveHomeViewType)type;

@end

NS_ASSUME_NONNULL_END
