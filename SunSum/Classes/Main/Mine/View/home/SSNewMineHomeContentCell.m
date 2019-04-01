//
//  SSNewMineHomeContentCell.m
//  SunSum
//
//  Created by hank on 2019/1/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNewMineHomeContentCell.h"
#import "AppDelegate.h"
@interface SSNewMineHomeContentCell (){
    NSArray *_arrTitle;
    NSArray *_arrImage;
    SSMineHomeCellStyle _type;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblUnMessage;
@end

@implementation SSNewMineHomeContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _arrTitle = SSMineHomeCellStyleTitle;
    _arrImage = SSMineHomeCellStyleImage;
    // Initialization code
}

- (void)setUIWithType:(SSMineHomeCellStyle )type{
    _type = type;
    _imgPic.image =  kMeGetAssetImage(_arrImage[type]);
    _lblTitle.text = _arrTitle[type];
    if(type == MeMyCustomer){
        _lblUnMessage.hidden = YES;
        [self setUnMeaasge];
    }else{
        _lblUnMessage.hidden = YES;
    }
}

- (void)setUnMeaasge{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *str = @(appDelegate.unMessageCount).description;
    if(appDelegate.unMessageCount>99){
        str = @"99+";
    }
    _lblUnMessage.hidden = appDelegate.unMessageCount == 0;
    _lblUnMessage.text = [NSString stringWithFormat:@"%@",str];
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
