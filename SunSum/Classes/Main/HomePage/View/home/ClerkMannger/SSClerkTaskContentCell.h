//
//  SSClerkTaskContentCell.h
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSClerkTaskContentCellHeight = 38;
@class SSNewClerkManngerClerkTaskpercentModel;
@interface SSClerkTaskContentCell : UITableViewCell

- (void)setUIWIthModel:(SSNewClerkManngerClerkTaskpercentModel *)model;

@end

NS_ASSUME_NONNULL_END
