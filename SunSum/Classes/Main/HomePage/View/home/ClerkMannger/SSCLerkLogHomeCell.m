//
//  SSCLerkLogHomeCell.m
//  SunSum
//
//  Created by hank on 2019/4/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCLerkLogHomeCell.h"
#import "SSCLerkTaskHomeModel.h"

@interface SSCLerkLogHomeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;

@end

@implementation SSCLerkLogHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblStatus.adjustsFontSizeToFitWidth = YES;
}

- (void)setUIWithModel:(SSCLerkTaskHomeModel *)model{
    NSString *str = kMeUnNilStr(model.task_content);
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH-50) lineH:0];
    _consTitleHeight.constant = sh>17?sh:17;
    [_lblContent setAtsWithStr:kMeUnNilStr(str) lineGap:0];
    // 剩 169DFF 完成999999 逾期 FE913C
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblName.text = kMeUnNilStr(model.name);
    _lblTime.text = kMeUnNilStr(model.last_time);
    _lblStatus.text = kMeUnNilStr(model.status_text);
    if(model.status == 0){
        _lblStatus.textColor = [UIColor colorWithHexString:@"FE913C"];
    }else if (model.status == 1){
        _lblStatus.textColor = [UIColor colorWithHexString:@"169DFF"];
    }else{
        _lblStatus.textColor = [UIColor colorWithHexString:@"999999"];
    }
}

+ (CGFloat)getCellHeightWithModel:(SSCLerkTaskHomeModel *)model{
    CGFloat height = kSSCLerkLogHomeCellHeight - 17;
    NSString *str = kMeUnNilStr(model.task_content);
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH-50) lineH:0];
    height += sh>17?sh:17;
    if(model.status == 2){
        height -=56;
    }
    return height;
}
@end
