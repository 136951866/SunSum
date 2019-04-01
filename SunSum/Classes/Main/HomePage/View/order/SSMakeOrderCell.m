//
//  SSMakeOrderCell.m
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMakeOrderCell.h"
#import "SSMessageTextField.h"

const static CGFloat kSSMakeOrderCellMagin = 15;
const static CGFloat kSubTitleWdith = 87;
const static CGFloat kTitleWdith = 92;

@interface SSMakeOrderCell (){
    NSArray *_arrType;
}

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
@property (weak, nonatomic) IBOutlet SSMessageTextField *txMessage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleWdith;

@end

@implementation SSMakeOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _arrType = SSMakrOrderCellStyleTitle;
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithType:(SSMakrOrderCellStyle)type model:(NSString *)model{
    _txMessage.hidden = type!=SSMakrOrderCellMessage;
    _lblSubTitle.hidden = type==SSMakrOrderCellMessage;
    _consTitleWdith.constant = type == SSMakrOrderCellMessage?kTitleWdith:(SCREEN_WIDTH - (kSubTitleWdith+(kSSMakeOrderCellMagin * 3)));
    _lblTitle.text = _arrType[type];
    if(type == SSMakrOrderCellMessage){
        kMeWEAKSELF
        _txMessage.text = model;
        _txMessage.contentBlock = ^(NSString *str) {
            kMeSTRONGSELF
            kMeCallBlock(strongSelf.messageBlock,str);
        };
        _txMessage.returnBlock = ^{
            kMeSTRONGSELF
            kMeCallBlock(strongSelf.returnBlock);
        };
    }else{
        _lblSubTitle.text = model;
    }
}

@end
