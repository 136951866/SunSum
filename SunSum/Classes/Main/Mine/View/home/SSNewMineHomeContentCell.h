//
//  SSNewMineHomeContentCell.h
//  SunSum
//
//  Created by hank on 2019/1/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kSSNewMineHomeContentCellHeight 75
#define kSSNewMineHomeContentCellWdith ((SCREEN_WIDTH - 30)/3)

@interface SSNewMineHomeContentCell : UICollectionViewCell

- (void)setUIWithType:(SSMineHomeCellStyle )type;

@end

NS_ASSUME_NONNULL_END
