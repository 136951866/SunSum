//
//  SSNoticeCell.m
//  SunSum
//
//  Created by hank on 2018/11/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSNoticeCell.h"
#import "SSNoticeModel.h"

@interface SSNoticeCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIView *viewForUnread;


@end

@implementation SSNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblTitle.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWIthModel:(SSNoticeModel *)model{
    _lblTitle.text = kMeUnNilStr(model.title);
    _lblTime.text = kMeUnNilStr(model.updated_at);
    _viewForUnread.hidden = model.is_read==2;
}

@end
