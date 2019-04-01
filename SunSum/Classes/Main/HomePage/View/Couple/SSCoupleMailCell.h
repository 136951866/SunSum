//
//  SSCoupleMailCell.h
//  SunSum
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSCoupleModel;
@class SSPinduoduoCoupleModel;
@class SSJDCoupleModel;

#define kSSCoupleMailCellHeight (kSSCoupleMailCellWdith +93)
#define kSSCoupleMailCellWdith ((SCREEN_WIDTH - 30)/2)
#define kSSMargin (5)

@interface SSCoupleMailCell : UICollectionViewCell

- (void)setJDUIWithModel:(SSJDCoupleModel *)model;
- (void)setUIWithModel:(SSCoupleModel *)model;
- (void)setpinduoduoUIWithModel:(SSPinduoduoCoupleModel *)model;

@end
