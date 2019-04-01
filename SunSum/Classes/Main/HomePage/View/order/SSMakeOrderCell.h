//
//  SSMakeOrderCell.h
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSMakeOrderCellHeight = 64;

@interface SSMakeOrderCell : UITableViewCell

@property (nonatomic, copy) kMeTextBlock messageBlock;
@property (nonatomic , copy)kMeBasicBlock returnBlock;

- (void)setUIWithType:(SSMakrOrderCellStyle)type model:(NSString *)model;


@end
