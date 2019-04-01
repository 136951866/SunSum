//
//  SSThridProductDetailsTipCell.h
//  SunSum
//
//  Created by hank on 2019/1/22.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSThridProductDetailsTipCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTip;
- (void)setUiWithStr:(NSString *)str;
- (void)setNoticeUiWithStr:(NSString *)str;
+ (CGFloat)getCellHeightWithStr:(NSString *)str;
+ (CGFloat)getCellNoticeHeightWithStr:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
