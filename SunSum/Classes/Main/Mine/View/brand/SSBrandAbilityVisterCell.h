//
//  SSBrandAbilityVisterCell.h
//  SunSum
//
//  Created by hank on 2019/3/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBrandAbilityVisterModel;
const static CGFloat kSSBrandAbilityVisterCellHeight = 78;

@interface SSBrandAbilityVisterCell : UITableViewCell

- (void)setUiWithModel:(SSBrandAbilityVisterModel *)model;

@end

NS_ASSUME_NONNULL_END
