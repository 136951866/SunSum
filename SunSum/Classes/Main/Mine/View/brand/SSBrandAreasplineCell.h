//
//  SSBrandAreasplineCell.h
//  SunSum
//
//  Created by hank on 2019/3/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSBrandAreasplineCellHeight = 273;

@interface SSBrandAreasplineCell : UITableViewCell
- (void)setUiWithModel:(NSArray *)model title:(NSString *)title subTitle:(NSString *)subTitle;
@end

NS_ASSUME_NONNULL_END
