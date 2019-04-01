//
//  SSMineSetCell.m
//  SunSum
//
//  Created by hank on 2018/9/25.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMineSetCell.h"

@interface SSMineSetCell (){
    kMeBOOLBlock _switchBlock;
    BOOL _status;
    SSSetStyle _type;
}

@property (weak, nonatomic) IBOutlet UISwitch *swotice;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;

@end

@implementation SSMineSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

//- (void)setType:(SSSetStyle)type status:(BOOL)status switchBlock:(kMeBOOLBlock)switchBlock{
//    _swotice.on = status;
//    _status = status;
//    _type = type;
//    _switchBlock = switchBlock;
//    _swotice.hidden = type !=SSSetNoticeStyle;
//    _imgArrow.hidden = type==SSSetNoticeStyle;
//}

- (IBAction)switchstatusAction:(UISwitch *)sender {
    kMeCallBlock(_switchBlock,sender.on);
}


@end
