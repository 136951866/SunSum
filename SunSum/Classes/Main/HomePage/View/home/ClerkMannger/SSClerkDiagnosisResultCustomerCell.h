//
//  SSClerkDiagnosisResultCustomerCell.h
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSClerkDiagnosisResultCustomerCellHeight = 351;
@class SSClerkDiagnosisResultmodel;
@interface SSClerkDiagnosisResultCustomerCell : UITableViewCell

- (void)setUiWithModel:(NSArray *)nowMonth lastMonth:(NSArray*)lastMonth Xtitle:(NSArray*)Xtitle model:(SSClerkDiagnosisResultmodel *)model;

@end

NS_ASSUME_NONNULL_END
