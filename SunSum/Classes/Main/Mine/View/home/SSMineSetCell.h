//
//  SSMineSetCell.h
//  SunSum
//
//  Created by hank on 2018/9/25.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSMineSetCellHeight = 50;

@interface SSMineSetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//- (void)setType:(SSSetStyle)type status:(BOOL)status switchBlock:(kMeBOOLBlock)switchBlock;

@end
