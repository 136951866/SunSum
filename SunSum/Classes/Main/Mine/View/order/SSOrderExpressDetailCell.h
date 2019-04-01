//
//  SSOrderExpressDetailCell.h
//  SunSum
//
//  Created by hank on 2019/3/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSexpressDetailModel;

@interface SSOrderExpressDetailCell : UITableViewCell

- (void)setUIWIthModel:(SSexpressDetailModel *)model;
+ (CGFloat)getCellHeightWithModel:(SSexpressDetailModel *)model;
@end

NS_ASSUME_NONNULL_END
