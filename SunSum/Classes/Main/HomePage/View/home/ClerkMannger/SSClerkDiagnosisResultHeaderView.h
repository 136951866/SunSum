//
//  SSClerkDiagnosisResultHeaderView.h
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSClerkDiagnosisResultmodel;
const static CGFloat kSSClerkDiagnosisResultHeaderViewHeight = 249;

@interface SSClerkDiagnosisResultHeaderView : UIView

- (void)setUiWithModel:(SSClerkDiagnosisResultmodel *)model;

@end

NS_ASSUME_NONNULL_END
