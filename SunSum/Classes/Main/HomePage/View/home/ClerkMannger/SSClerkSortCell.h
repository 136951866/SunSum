//
//  SSClerkSortCell.h
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSClerkSortCellOrgialHeight = 145;


NS_ASSUME_NONNULL_BEGIN

@interface SSClerkSortCell : UITableViewCell

- (void)setUIWithArr:(NSArray *)arr selectBlock:(kMeIndexBlock)selectBlock selectIndex:(NSInteger)selectIndex;
+ (CGFloat)getCellHeightWithArr:(NSArray *)arr;



@end

NS_ASSUME_NONNULL_END
