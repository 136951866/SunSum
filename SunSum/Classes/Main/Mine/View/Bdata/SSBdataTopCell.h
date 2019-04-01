//
//  SSBdataTopCell.h
//  SunSum
//
//  Created by hank on 2019/3/20.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBDataDealModel;
const static CGFloat kSSBdataTopCellHeight = 242;

@interface SSBdataTopCell : UITableViewCell

- (void)setUIWithModel:(SSBDataDealModel *)Model;


@end

NS_ASSUME_NONNULL_END
