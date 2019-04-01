//
//  SSSkuBuyCell.h
//  SunSum
//
//  Created by Hank on 2018/9/10.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSGoodDetailModel;
@interface SSSkuBuyCell : UITableViewCell

+ (CGFloat)getCellHeigthWithModel:(id)goodModel;
+ (CGFloat)getCellHeigthWithdetailModel:(SSGoodDetailModel *)goodModel;
- (void)setUIWithModel:(SSGoodDetailModel *)goodModel isInteral:(BOOL)isInteral slectBlock:(kMeBasicBlock)slectBlock;

/**
 加
 */
@property (nonatomic, copy) kMeLblBlock AddBlock;

/**
 减
 */
@property (nonatomic, copy) kMeLblBlock CutBlock;

@property (nonatomic, copy) kMeBasicBlock confirmBlock;

@end
