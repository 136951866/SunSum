//
//  SSVisterSectionView.h
//  SunSum
//
//  Created by hank on 2018/11/28.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    MyEnumkSSVisterSectionViewAllType,
    MyEnumkSSVisterSectionViewHopeType,
    MyEnumkSSVisterSectionViewVisterType,
} MyEnumkSSVisterSectionViewType;
const static CGFloat kSSVisterSectionViewHeight = 117;

@interface SSVisterSectionView : UITableViewHeaderFooterView

- (void)setTypeWithType:(MyEnumkSSVisterSectionViewType)type block:(kMeIndexBlock)block;

@end
