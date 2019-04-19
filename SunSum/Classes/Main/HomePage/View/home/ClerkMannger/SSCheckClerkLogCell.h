//
//  SSCheckClerkLogCell.h
//  SunSum
//
//  Created by hank on 2019/4/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSClerkTaskDetailModel;
@interface SSCheckClerkLogCell : UITableViewCell

- (void)setUiWIhtModle:(SSClerkTaskDetailModel *)model;
+ (CGFloat)getCellHeightWithModel:(SSClerkTaskDetailModel *)model;

@end

NS_ASSUME_NONNULL_END
