//
//  SSClerkSortContentCell.h
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSClerkSortContentCellHeight = 42;

@interface SSClerkSortContentCell : UITableViewCell

- (void)setUIWIthModel:(id)model sort:(NSInteger)sort;

@end

NS_ASSUME_NONNULL_END
