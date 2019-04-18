//
//  SSClerkOperationDailyCell.h
//  SunSum
//
//  Created by hank on 2019/4/18.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSClerkOperationDailyCellHeight = 318;

@interface SSClerkOperationDailyCell : UITableViewCell

- (void)setUiWithModel:(NSArray *)model Xtitle:(NSArray*)Xtitle title:(NSString *)title allcount:(NSString *)allcount color:(NSArray*)color compan:(NSString*)compan;

@end

NS_ASSUME_NONNULL_END
