//
//  SSOrderCell.h
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSOrderModel;
const static CGFloat kSSOrderCellNeedPayBtnHeight = 95.5;
const static CGFloat kSSOrderCellNoPayedBtnHeight = 52;

@interface SSOrderCell : UITableViewCell

- (void)setUIWithModel:(SSOrderModel *)model Type:(SSOrderStyle)type;
+ (CGFloat)getCellHeightWithModel:(SSOrderModel *)model Type:(SSOrderStyle)type;

//自提
- (void)setSelfUIWithModel:(SSOrderModel *)model;
+ (CGFloat)getCellSelfHeightWithModel:(SSOrderModel *)model;
@property (nonatomic, copy) kMeBasicBlock touchBlock;
@property (nonatomic, copy) kMeBasicBlock cancelOrderBlock;

@end
