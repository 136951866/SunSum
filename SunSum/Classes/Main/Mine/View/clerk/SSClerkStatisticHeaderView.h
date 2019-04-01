//
//  SSClerkStatisticHeaderView.h
//  SunSum
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSClerkStatisticHeaderViewHeight = 125;

@interface SSClerkStatisticHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *lblAllMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblTodayMoney;

@end
