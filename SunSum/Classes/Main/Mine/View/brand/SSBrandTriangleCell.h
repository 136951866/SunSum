//
//  SSBrandTriangleCell.h
//  SunSum
//
//  Created by hank on 2019/3/8.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBrandManngerAllModel;
const static CGFloat kSSBrandTriangleCellHeight = 285;

@interface SSBrandTriangleCell : UITableViewCell

- (void)setUIWithModel:(SSBrandManngerAllModel *)model;

@end

NS_ASSUME_NONNULL_END
