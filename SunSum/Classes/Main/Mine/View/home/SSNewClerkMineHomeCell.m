//
//  SSNewClerkMineHomeCell.m
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNewClerkMineHomeCell.h"
#import "AppDelegate.h"

@interface SSNewClerkMineHomeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTel;
@property (weak, nonatomic) IBOutlet UILabel *lblUnMessage;

@end

@implementation SSNewClerkMineHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)reloadUI{
    kSDLoadImg(_imgPic, kMeUnNilStr(kCurrentUser.header_pic));
    _lblName.text = kMeUnNilStr(kCurrentUser.name);
    _lblTel.text = [@"手机:" stringByAppendingString:kMeUnNilStr(kCurrentUser.mobile)];
    [self setUnMeaasge];
}
- (IBAction)setAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toSetVC)]){
        [self.delegate toSetVC];
    }
}


- (IBAction) toTaskVCAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toTaskVC)]){
        [self.delegate toTaskVC];
    }
}
- (IBAction) toposterVCAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toposterVC)]){
        [self.delegate toposterVC];
    }
}
- (IBAction) toArticelkVCAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toArticelkVC)]){
        [self.delegate toArticelkVC];
    }
}
- (IBAction) toDataVCAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toDataVC)]){
        [self.delegate toDataVC];
    }
}
- (IBAction)toChatVCAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toChatVC)]){
        [self.delegate toChatVC];
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
}

@end
