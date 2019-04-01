//
//  SSBStoreMannagerCell.m
//  SunSum
//
//  Created by hank on 2019/2/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBStoreMannagerCell.h"
#import "SSBStoreMannagerInfoModel.h"

@interface SSBStoreMannagerCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageTail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;


@end

@implementation SSBStoreMannagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUiWithModel:(SSBStoreMannagercontentInfoModel *)model{
    if(model.type == SSBStoreMannagerInfoStoreNameType || model.type == SSBStoreMannagerInfoStoreTelType ||model.type == SSBStoreMannagerInfocodeIdType ||model.type == SSBStoreMannagerStoreIntoduceType ||model.type == SSBStoreMannagerInfoAddressType){
        _imageTail.hidden = NO;
        _imageTail.image = model.type == SSBStoreMannagerInfoAddressType?[UIImage imageNamed:@"stroelocation"]:[UIImage imageNamed:@"icon_more"];
    }else{
        _imageTail.hidden = YES;
    }
    _lblTitle.lineBreakMode = UILineBreakModeCharacterWrap;
    NSString *str = [NSString stringWithFormat:@"%@%@",kMeUnNilStr(model.title),kMeUnNilStr(model.subTitle)];
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH - 75) lineH:0 maxLine:0];
    _consTitleHeight.constant = titleHeight>16?titleHeight:16;
    _lblTitle.text = str;
}

+ (CGFloat)getCellHeightWithModel:(SSBStoreMannagercontentInfoModel*)model{
    CGFloat height = 0;
    NSString *str = [NSString stringWithFormat:@"%@%@",kMeUnNilStr(model.title),kMeUnNilStr(model.subTitle)];
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:13] width:(SCREEN_WIDTH - 75) lineH:0 maxLine:0];
    height += titleHeight>16?titleHeight:16;
    height +=28;
    return height;
}


@end
