//
//  SSDistrbutionCell.h
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSSDistrbutionCellHeight 88
#define kSSDistrbutionCellMargin 1
#define kSSDistrbutionCellWdith ((SCREEN_WIDTH - (kSSDistrbutionCellMargin*2))/3)



@interface SSDistrbutionCell : UICollectionViewCell

- (void)setUIWithtype:(SSDistrbutionCellStyle)type subtitle:(NSString *)subTitle;

@end
