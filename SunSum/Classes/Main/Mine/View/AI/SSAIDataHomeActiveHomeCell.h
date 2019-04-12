//
//  SSAIDataHomeActiveHomeCell.h
//  SS时代
//
//  Created by hank on 2019/4/10.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SSAIDataHomeActiveHomeCellcheckStoreType = 0,
    SSAIDataHomeActiveHomeCellshareStoreType = 1,
    SSAIDataHomeActiveHomeCellcheckpintuanType = 2,
    SSAIDataHomeActiveHomeCellcheckServerType = 3,
} SSAIDataHomeActiveHomeCellType;

const static CGFloat kSSAIDataHomeActiveHomeCellHeight = 46;

@interface SSAIDataHomeActiveHomeCell : UITableViewCell

- (void)setUIWithType:(SSAIDataHomeActiveHomeCellType)type count:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
