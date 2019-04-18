//
//  SSClerkDiagnosisResultClerkCell.h
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSClerkDiagnosisResultClerkModel;
const static CGFloat kSSClerkDiagnosisResultClerkCellHeight = 50;


@interface SSClerkDiagnosisResultClerkCell : UITableViewCell

- (void)setUIWithModel:(SSClerkDiagnosisResultClerkModel *)model sort:(NSInteger)sort;

@end

NS_ASSUME_NONNULL_END
