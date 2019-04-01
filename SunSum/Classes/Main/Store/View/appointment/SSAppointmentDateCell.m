//
//  SSAppointmentDateCell.m
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSAppointmentDateCell.h"

@interface SSAppointmentDateCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblWeek;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end

@implementation SSAppointmentDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.borderColor = kSSHexColor(@"dbdbdb");
    self.borderWidth = 1;
    // Initialization code
}

- (void)setUIWithModel:(SSTimeModel *)model isSelect:(BOOL)isSelect{
    self.backgroundColor = isSelect?kSSHexColor(@"cc9e69"):[UIColor whiteColor];
    _lblWeek.textColor = isSelect?[UIColor whiteColor]:kSSblack;
    _lblDate.textColor = isSelect?[UIColor whiteColor]:kSSblack;
    _lblWeek.text = kMeUnNilStr(model.week);
    _lblDate.text = kMeUnNilStr(model.month);
}

@end
