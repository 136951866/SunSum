//
//  SSRushBuyCell.h
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSRushBuyCell : UITableViewCell

@property (nonatomic, strong) NSString *time;
+ (CGFloat)getCellHeightWithArr:(NSArray *)arr;
- (void)setUIWithArr:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
