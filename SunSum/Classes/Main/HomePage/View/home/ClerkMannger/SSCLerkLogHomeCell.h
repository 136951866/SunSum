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

@interface SSCLerkLogHomeCell : UITableViewCell

- (void)setUIWithModel:(id)model;
+ (CGFloat)getCellHeightWithModel:(NSObject *)model;

@end

NS_ASSUME_NONNULL_END
