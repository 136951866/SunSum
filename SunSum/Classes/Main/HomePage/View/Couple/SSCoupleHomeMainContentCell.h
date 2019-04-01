//
//  SSCoupleHomeMainContentCell.h
//  SunSum
//
//  Created by hank on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSCoupleModel;
const static CGFloat kSSCoupleHomeMainContentCellHeight = 168.0;
const static CGFloat kSSCoupleHomeMainContentCellWidth = 110.0;

@interface SSCoupleHomeMainContentCell : UICollectionViewCell

- (void)setUIWIthModel:(SSCoupleModel *)model;
@end

NS_ASSUME_NONNULL_END
