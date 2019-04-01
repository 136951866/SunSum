//
//  SSGoodManngerSpecAddCell.h
//  SunSum
//
//  Created by hank on 2019/3/28.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class  SSGoodManngerGoodSpec;
const static CGFloat kSSGoodManngerSpecAddCellHeight = 55;


@interface SSGoodManngerSpecAddCell : UITableViewCell

- (void)setUIWithModel:(SSGoodManngerGoodSpec *)model;

@end

NS_ASSUME_NONNULL_END
