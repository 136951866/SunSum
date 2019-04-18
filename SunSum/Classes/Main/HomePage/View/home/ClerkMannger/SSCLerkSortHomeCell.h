//
//  SSCLerkSortHomeCell.h
//  SunSum
//
//  Created by hank on 2019/4/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSNewClerkManngerDataContentModel;
const static CGFloat kSSCLerkSortHomeCellHeight = 43;

@interface SSCLerkSortHomeCell : UITableViewCell
- (void)setUIWithModel:(SSNewClerkManngerDataContentModel *)model sort:(NSInteger)sort;
@end

NS_ASSUME_NONNULL_END
