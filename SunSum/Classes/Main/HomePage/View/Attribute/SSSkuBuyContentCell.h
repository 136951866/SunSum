//
//  SSSkuBuyContentCell.h
//  SunSum
//
//  Created by Hank on 2018/9/10.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSGoodSpecModel;
#define kSSSkuBuyContentCellMargin 20
#define kSSSkuBuyContentCellHeight 28
#define kSSSkuBuyContentCellWidth ((SCREEN_WIDTH - 4 * kSSSkuBuyContentCellMargin) /3)

@interface SSSkuBuyContentCell : UICollectionViewCell

- (void)setmodelWithStr:(SSGoodSpecModel *)model isSelect:(BOOL)isSelect;

@end
