//
//  SSBrandAiCell.h
//  SunSum
//
//  Created by hank on 2019/3/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class  SSBrandAISortModel;
const static CGFloat kSSBrandAiCellHeight = 65;

@interface SSBrandAiCell : UITableViewCell

- (void)setUIWithModel:(SSBrandAISortModel *)model sortNum:(NSInteger)sortNum;
- (void)setSortUIWithModel:(SSBrandAISortModel *)model sortNum:(NSInteger)sortNum;

@end

NS_ASSUME_NONNULL_END
