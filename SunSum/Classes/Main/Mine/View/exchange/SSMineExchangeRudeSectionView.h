//
//  SSMineExchangeRudeSectionView.h
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSMineExchangeRudeSectionViewHeight = 50;

@interface SSMineExchangeRudeSectionView : UITableViewHeaderFooterView

- (void)setUIWihtStr:(NSString *)title isExpand:(BOOL)isExpand ExpandBlock:(kMeBOOLBlock)expandBlock;


@end
