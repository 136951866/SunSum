//
//  SSCLerkLogHomeCell.h
//  SunSum
//
//  Created by hank on 2019/4/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSCLerkLogHomeCellHeight = 204;
@class SSCLerkTaskHomeModel;
@interface SSCLerkLogHomeCell : UITableViewCell

- (void)setUIWithModel:(SSCLerkTaskHomeModel *)model;
+ (CGFloat)getCellHeightWithModel:(SSCLerkTaskHomeModel *)model;

@end

NS_ASSUME_NONNULL_END
