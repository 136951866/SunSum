//
//  SSProductDetalsBuyedContentCell.h
//  SunSum
//
//  Created by hank on 2018/9/8.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>


const static CGFloat kSSProductDetalsBuyedContentCellHeight = 200.0;
const static CGFloat kSSProductDetalsBuyedContentCellWidth = 110.0;

@class SSGoodModel;
@interface SSProductDetalsBuyedContentCell : UICollectionViewCell

- (void)setUIWithModel:(SSGoodModel *)model;
- (void)setUIServiceWithModel:(id)model;

@end
