//
//  SSEditClerkLogCell.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSEditClerkLogCell.h"
#import "SSClerkFinishTaskModel.h"

@interface SSEditClerkLogCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblNoticeP;
@property (weak, nonatomic) IBOutlet UILabel *lblServerNumP;
@property (weak, nonatomic) IBOutlet UILabel *lblMarkP;



@end

@implementation SSEditClerkLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblTime.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (IBAction)notciAction:(UIButton *)sender {
    kMeCallBlock(_notichBlock);
}

- (IBAction)markAction:(UIButton *)sender {
    kMeCallBlock(_markBlock);
}

- (IBAction)serverAction:(UIButton *)sender {
    kMeCallBlock(_serverBlock);
}


- (void)setUIWIthModel:(SSClerkFinishTaskModel *)model{
    
    NSString *str = kMeUnNilStr(model.task_content);
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblName.text = kMeUnNilStr(model.name);
    _lblTime.text = kMeUnNilStr(model.last_time);
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH-50) lineH:0];
    _consTitleHeight.constant = sh>17?sh:17;
    [_lblContent setAtsWithStr:kMeUnNilStr(str) lineGap:0];
    
    _lblNoticeP.text = kMeUnNilStr(model.matters_attention).length?kMeUnNilStr(model.matters_attention):@"注意什么?";
    _lblServerNumP.text = kMeUnNilStr(model.reservation_num).length?kMeUnNilStr(model.reservation_num):@"填写预约数";
    _lblMarkP.text = kMeUnNilStr(model.desc).length?kMeUnNilStr(model.desc):@"备注";
}

+ (CGFloat)getCellHeightWithModel:(SSClerkFinishTaskModel *)model{
    CGFloat height = kSSEditClerkLogCellHeight - 17;
    NSString *str = kMeUnNilStr(model.task_content);
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH-50) lineH:0];
    height += sh>17?sh:17;
    return height;
}





@end
