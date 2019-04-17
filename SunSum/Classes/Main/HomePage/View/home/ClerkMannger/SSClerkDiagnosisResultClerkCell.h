//
//  SSClerkDiagnosisResultClerkCell.h
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSClerkDiagnosisResultClerkCellHeight = 50;


@interface SSClerkDiagnosisResultClerkCell : UITableViewCell

- (void)setUIWithModel:(id)model sort:(NSInteger)sort;

@end

NS_ASSUME_NONNULL_END
