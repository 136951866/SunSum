//
//  SSCheckClerkLogCell.m
//  SunSum
//
//  Created by hank on 2019/4/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCheckClerkLogCell.h"
#import "SSClerkTaskDetailModel.h"

@interface SSCheckClerkLogCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbltime;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UILabel *lblNotice;
@property (weak, nonatomic) IBOutlet UILabel *lblServerNum;
@property (weak, nonatomic) IBOutlet UILabel *lblMark;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consNoticeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consMarkHeight;


@end

@implementation SSCheckClerkLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;

}


- (void)setUiWIhtModle:(SSClerkTaskDetailModel *)model{
    
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblTitle.text = kMeUnNilStr(model.name);
    _lbltime.text = kMeUnNilStr(model.last_time);

    
    
    CGFloat topViewHeight = 125;
    NSString *str = kMeUnNilStr(model.task_content);
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH- 50) lineH:0];
    CGFloat contentHeight = sh>16?(sh+topViewHeight):topViewHeight;
    _consTopViewHeight.constant = contentHeight;
    [_lblContent setAtsWithStr:str lineGap:0];
    
    
    
    NSString *strattentStr = kMeUnNilStr(model.matters_attention);
    CGFloat strattent =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(strattentStr) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH- 22) lineH:0];
    CGFloat strattentHeight = strattent>17?strattent:17;
    _consNoticeHeight.constant = strattentHeight;
    [_lblNotice setAtsWithStr:strattentStr lineGap:0];
    
    
    
    NSString *strMarkStr = kMeUnNilStr(model.desc);
    CGFloat mark =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(strMarkStr) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH- 22) lineH:0];
    CGFloat markHeight = mark>17?mark:17;
    _consMarkHeight.constant = markHeight;
    [_lblMark setAtsWithStr:strMarkStr lineGap:0];
    
    _lblServerNum.text = kMeUnNilStr(model.reservation_num);
    
}
+ (CGFloat)getCellHeightWithModel:(SSClerkTaskDetailModel *)model{
    CGFloat height = 57;
    CGFloat topViewHeight = 125;
    NSString *str = kMeUnNilStr(model.task_content);
    CGFloat sh =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(str) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH- 50) lineH:0];
    CGFloat contentHeight = sh>16?(sh+topViewHeight):topViewHeight;
    height +=contentHeight;
    
    //注意事项
    height +=(15+18+15+1+15);
    NSString *strattentStr = kMeUnNilStr(model.matters_attention);
    CGFloat strattent =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(strattentStr) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH- 22) lineH:0];
    CGFloat strattentHeight = strattent>17?strattent:17;
    height +=strattentHeight;
    
    //预约
    height +=(15+18+15+1+17+15);
    
    //备注
    height +=(15+18+15+1+15);
    NSString *strMarkStr = kMeUnNilStr(model.desc);
    CGFloat mark =
    [NSAttributedString heightForAtsWithStr:kMeUnNilStr(strMarkStr) font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH- 22) lineH:0];
    CGFloat markHeight = mark>17?mark:17;
    height +=markHeight;

    return height;
}


@end
