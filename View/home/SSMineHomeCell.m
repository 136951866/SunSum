//
//  SSMineHomeCell.m
//  SunSum
//
//  Created by Hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMineHomeCell.h"
#import "AppDelegate.h"

@interface SSMineHomeCell (){
    NSArray *_arrTitle;
    NSArray *_arrImage;
    SSMineHomeCellStyle _type;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblUnMessage;

@end

@implementation SSMineHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _arrTitle = SSMineHomeCellStyleTitle;
    _arrImage = SSMineHomeCellStyleImage;
    // Initialization code
}

- (void)setUiWithType:(SSMineHomeCellStyle)type{
    _type = type;
    _imgPic.image =  kMeGetAssetImage(_arrImage[type]);
    _lblTitle.text = _arrTitle[type];
    if(type == MeMyCustomer){
        _lblUnMessage.hidden = NO;
        [self setUnMeaasge];
    }else{
        _lblUnMessage.hidden = YES;
    }
}

- (void)setUnMeaasge{
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSInteger unmessgae =  [[RCIMClient sharedRCIMClient] getUnreadCount:@[
//                                                                           @(ConversationType_PRIVATE),
//                                                                           ]];
//    appDelegate.unMessageCount = unmessgae;
//    NSString *str = @(unmessgae).description;
//    if(appDelegate.unMessageCount>99){
//        str = @"99+";
//    }
//    _lblUnMessage.hidden = appDelegate.unMessageCount == 0;
//    _lblUnMessage.text = [NSString stringWithFormat:@"%@",str];
}

@end
