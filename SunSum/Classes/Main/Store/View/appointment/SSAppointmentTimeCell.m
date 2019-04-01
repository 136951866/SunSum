//
//  SSAppointmentTimeCell.m
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSAppointmentTimeCell.h"

@interface SSAppointmentTimeCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation SSAppointmentTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUIWithModel:(SSTimeModel *)model isSelect:(BOOL)isSelect{
    self.backgroundColor = isSelect?kSSHexColor(@"cc9e69"):[UIColor whiteColor];
    _lblTitle.textColor = isSelect?[UIColor whiteColor]:kSSblack;
    _lblTitle.text = kMeUnNilStr(model.time);
}

@end
