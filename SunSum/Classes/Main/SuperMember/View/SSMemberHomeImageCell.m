//
//  SSMemberHomeImageCell.m
//  SunSum
//
//  Created by hank on 2018/10/16.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMemberHomeImageCell.h"

@implementation SSMemberHomeImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

+ (CGFloat)getCellHeight{
    CGFloat height = 25;
    height+=((SCREEN_WIDTH * 376)/700);
    return height;
}

@end
