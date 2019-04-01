//
//  SSMineExchangeCell.h
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSGoodModel;
#define kSSMineExchangeCellHeight  (130 * kMeFrameScaleX())

@interface SSMineExchangeCell : UITableViewCell

- (void)setUIWithModel:(SSGoodModel *)model ExchangeBlock:(kMeBasicBlock)exchangeBlock;

@end
