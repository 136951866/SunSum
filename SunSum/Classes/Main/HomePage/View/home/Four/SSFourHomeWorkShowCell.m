//
//  SSFourHomeWorkShowCell.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSFourHomeWorkShowCell.h"

@implementation SSFourHomeWorkShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (IBAction)planAchieveAction:(UIButton *)sender {
    kMeCallBlock(_planAchieveBlock);
}

- (IBAction)workFinishAction:(UIButton *)sender {
    kMeCallBlock(_workFinishBlock);
}





@end
