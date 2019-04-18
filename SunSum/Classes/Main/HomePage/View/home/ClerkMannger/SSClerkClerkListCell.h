//
//  SSClerkClerkListCell.h
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSClerkModel;
const static CGFloat kSSClerkClerkListCellHeight = 65;


@interface SSClerkClerkListCell : UITableViewCell
- (void)setUIWIthModel:(SSClerkModel *)model;

@end

NS_ASSUME_NONNULL_END
