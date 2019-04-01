//
//  SSFilterMainCell.m
//  SunSum
//
//  Created by hank on 2018/11/1.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSFilterMainCell.h"
#import "SSFilterMainModel.h"

@interface SSFilterMainCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblUnread;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;

@end

@implementation SSFilterMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithModel:(SSFilterMainModel *)model{
    _lblUnread.hidden = YES;
    _lblTitle.text = kMeUnNilStr(model.category_name);
}

- (void)setUnreadUIWithModel:(SSFilterMainModel *)model{
    _lblUnread.hidden = YES;
    _imgArrow.hidden = YES;
    _lblTitle.text = kMeUnNilStr(model.category_name);
    NSString *str = @(model.unRead).description;
    if(model.unRead>99){
        str = @"99+";
    }
    _lblUnread.hidden = model.unRead == 0;
    _lblUnread.text = [NSString stringWithFormat:@"%@",str];
}
@end
