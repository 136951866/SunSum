//
//  SSAddGoodGoodAttributeCell.h
//  SunSum
//
//  Created by hank on 2019/3/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSAddGoodModel;
const static CGFloat kSSAddGoodGoodAttributeCellHeight = 1019;

@interface SSAddGoodGoodAttributeCell : UITableViewCell

@property (nonatomic,copy)kMeBasicBlock selectSpecBlock;
@property (nonatomic,copy)kMeBasicBlock selectRichEditBlock;
- (void)setUIWithModel:(SSAddGoodModel *)model;

@property (weak, nonatomic) IBOutlet UIImageView *imgGood;
@property (weak, nonatomic) IBOutlet UIImageView *imgGoodHot;
@property (weak, nonatomic) IBOutlet UIImageView *imgRecommend;

//0 商品 1热门 2推荐
@property (nonatomic, copy) kMeIndexBlock selectImgBlock;
@end

NS_ASSUME_NONNULL_END
