//
//  SSProductCell.h
//  SunSum
//
//  Created by hank on 2018/9/7.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSGoodModel;

const static CGFloat kSSProductCellHeight  = 230;
#define kSSProductCellWdith ((SCREEN_WIDTH - (15*3))/2)
#define kSSMargin (7.5)


@interface SSProductCell : UICollectionViewCell

- (void)setUIWithModel:(SSGoodModel *)model;
- (void)setUIWithModel:(SSGoodModel *)model WithKey:(NSString *)key;
- (void)setServiceUIWithModel:(SSGoodModel *)model;

@end
