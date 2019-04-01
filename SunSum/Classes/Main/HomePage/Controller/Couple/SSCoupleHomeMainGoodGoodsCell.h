//
//  SSCoupleHomeMainGoodGoodsCell.h
//  SunSum
//
//  Created by hank on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSCoupleHomeMainGoodGoodsCell : UITableViewCell

- (void)setUIWithArr:(NSArray*)arr;
- (void)setPinduoduoUIWithArr:(NSArray*)arr;
+ (CGFloat)getCellHeightWithArr:(NSArray*)arr;
@property (nonatomic, copy) kMeIndexBlock selectBlock;

@end

NS_ASSUME_NONNULL_END
