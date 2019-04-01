//
//  SSPolarChartMixedCell.h
//  SunSum
//
//  Created by hank on 2019/3/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBrandAbilityAnalysisModel;
const static CGFloat kSSPolarChartMixedCellHeight = 311;

@interface SSPolarChartMixedCell : UITableViewCell

- (void)setUiWithModel:(SSBrandAbilityAnalysisModel *)model;

@end

NS_ASSUME_NONNULL_END
