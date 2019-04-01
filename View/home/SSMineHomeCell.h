//
//  SSMineHomeCell.h
//  SunSum
//
//  Created by Hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSMineHomeCellHeight = 49;



@interface SSMineHomeCell : UITableViewCell

- (void)setUiWithType:(SSMineHomeCellStyle)type;
- (void)setUnMeaasge;
@end
