//
//  SSProductDetalsBuyedCell.h
//  SunSum
//
//  Created by hank on 2018/9/8.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSStoreDetailModel;
const static CGFloat kSSProductDetalsBuyedNewCellHeight = 212;
const static CGFloat kSSProductDetalsBuyedCellHeight = 200;

@interface SSProductDetalsBuyedCell : UITableViewCell


- (void)setUIWithArr:(NSArray *)arrModel;
- (void)setServiceUIWithArr:(NSArray *)arrModel;
- (void)setServiceUIWithArr:(NSArray *)arrModel storeDetailModel:(SSStoreDetailModel *)storeDetailModel;

@end
