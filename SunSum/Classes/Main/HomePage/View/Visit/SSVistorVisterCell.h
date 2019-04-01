//
//  SSVistorVisterCell.h
//  SunSum
//
//  Created by hank on 2018/11/28.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSVistorUserModel;
const static CGFloat kSSVistorVisterCellHeight = 240;

@interface SSVistorVisterCell : UITableViewCell

- (void)setUIWithModel:(SSVistorUserModel *)model;
@property (nonatomic, copy) kMeBasicBlock setIntenBlock;
@end
