//
//  SSClerkSortContentCell.h
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSNewClerkManngerDataContentModel;
const static CGFloat kSSClerkSortContentCellHeight = 42;

@interface SSClerkSortContentCell : UITableViewCell

- (void)setUIWIthModel:(SSNewClerkManngerDataContentModel *)model sort:(NSInteger)sort type:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
