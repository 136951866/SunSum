//
//  SSClerkTaskDetailCell.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkTaskDetailCell.h"
#import "SSClerkTaskDetailModel.h"

@interface SSClerkTaskDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblTask;

@end

@implementation SSClerkTaskDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblTime.adjustsFontSizeToFitWidth = YES;
}

- (void)setUIWIthModel:(SSClerkTaskDetailModel *)model{
    NSString *str = kMeUnNilStr(model.task_content);
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:12] width:(SCREEN_WIDTH- 40) lineH:0];
    _consTitleHeight.constant = sh>15?sh:15;
    [_lblContent setAtsWithStr:kMeUnNilStr(str) lineGap:0];
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblName.text = kMeUnNilStr(model.nick_name);
    _lblTask.text = kMeUnNilStr(model.task_title);
    _lblTime.text = kMeUnNilStr(model.last_time);
}
+ (CGFloat)getCellHeightWithModel:(SSClerkTaskDetailModel *)model{
    CGFloat height = kSSClerkTaskDetailCellHeight - 15;
    NSString *str = kMeUnNilStr(model.task_content);
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:12] width:(SCREEN_WIDTH-50) lineH:0];
    height += sh>15?sh:15;
    return height;
}

@end
