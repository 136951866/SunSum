//
//  SSThridHomeTimeSecionContentCell.h
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSThridHomeRudeTimeModel;
const static CGFloat kSSThridHomeTimeSecionContentCellHeight = 55;
const static CGFloat kSSThridHomeTimeSecionContentCellWdith = 60;

@interface SSThridHomeTimeSecionContentCell : UICollectionViewCell

- (void)setUIWIthModel:(SSThridHomeRudeTimeModel *)model isSelect:(BOOL)isSelect;

@end

NS_ASSUME_NONNULL_END
