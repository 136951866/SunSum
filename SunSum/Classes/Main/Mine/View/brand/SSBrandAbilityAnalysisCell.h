//
//  SSBrandAbilityAnalysisCell.h
//  SunSum
//
//  Created by hank on 2019/3/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBrandAbilityAnalysisDataModel;
const static CGFloat kSSBrandAbilityAnalysisCellHeight =40;

@interface SSBrandAbilityAnalysisCell : UITableViewCell

- (void)setUIWithModel:(SSBrandAbilityAnalysisDataModel*)model;

@end

NS_ASSUME_NONNULL_END
