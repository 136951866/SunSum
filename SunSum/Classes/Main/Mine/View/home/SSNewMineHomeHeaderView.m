//
//  SSNewMineHomeHeaderView.m
//  SunSum
//
//  Created by hank on 2019/1/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNewMineHomeHeaderView.h"
#import "SSNewMineHomeVC.h"
#import "SSMidelButton.h"
#import "SSMyOrderVC.h"
#import "SSMineSetVC.h"

@interface SSNewMineHomeHeaderView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSetTopMargin;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consBtnW;
@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTel;

@end

@implementation SSNewMineHomeHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    [_viewLine addBottedlineWidth:2 lineColor:[UIColor whiteColor]];
    CGFloat w = (SCREEN_WIDTH - 60)/4;
    _consBtnW.constant = w;
    _consSetTopMargin.constant = kMeStatusBarHeight+10;
}

- (void)reloadUIWithUserInfo{
    _lblName.text = kMeUnNilStr(kCurrentUser.name);
    kSDLoadImg(_imgPic, kMeUnNilStr(kCurrentUser.header_pic));
    _lblTel.text = [NSString stringWithFormat:@"手机:%@",kMeUnNilStr(kCurrentUser.mobile)];
}

- (void)clearUIWithUserInfo{
    _lblName.text = @"";
    _lblTel.text = @"";
    kSDLoadImg(_imgPic, @"");
}

- (IBAction)allOrderAction:(UIButton *)sender {
    SSNewMineHomeVC *home = (SSNewMineHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSNewMineHomeVC class] targetResponderView:self];
    SSMyOrderVC *orderVC = [[SSMyOrderVC alloc]initWithType:SSAllOrder];
    if(home){
        [home.navigationController pushViewController:orderVC animated:YES];
    }
}

- (IBAction)needPayAction:(SSMidelMiddelImageButton *)sender {
    SSNewMineHomeVC *home = (SSNewMineHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSNewMineHomeVC class] targetResponderView:self];
    SSMyOrderVC *orderVC = [[SSMyOrderVC alloc]initWithType:SSAllNeedPayOrder];
    if(home){
        [home.navigationController pushViewController:orderVC animated:YES];
    }
}

- (IBAction)diveryAction:(SSMidelMiddelImageButton *)sender {
    SSNewMineHomeVC *home = (SSNewMineHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSNewMineHomeVC class] targetResponderView:self];
    SSMyOrderVC *orderVC = [[SSMyOrderVC alloc]initWithType:SSAllNeedDeliveryOrder];
    if(home){
        [home.navigationController pushViewController:orderVC animated:YES];
    }
}
- (IBAction)reviceAction:(SSMidelMiddelImageButton *)sender {
    SSNewMineHomeVC *home = (SSNewMineHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSNewMineHomeVC class] targetResponderView:self];
    SSMyOrderVC *orderVC = [[SSMyOrderVC alloc]initWithType:SSAllNeedReceivedOrder];
    if(home){
        [home.navigationController pushViewController:orderVC animated:YES];
    }
}
- (IBAction)finishAction:(SSMidelMiddelImageButton *)sender {
    SSNewMineHomeVC *home = (SSNewMineHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSNewMineHomeVC class] targetResponderView:self];
    SSMyOrderVC *orderVC = [[SSMyOrderVC alloc]initWithType:SSAllFinishOrder];
    if(home){
        [home.navigationController pushViewController:orderVC animated:YES];
    }
}

- (IBAction)setAction:(UIButton *)sender {
    SSNewMineHomeVC *home = (SSNewMineHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSNewMineHomeVC class] targetResponderView:self];
    SSMineSetVC *setVC = [[SSMineSetVC alloc]init];
    setVC.exitBlock = ^{
        home.tabBarController.selectedIndex = 0;
    };
    if(home){
        [home.navigationController pushViewController:setVC animated:YES];
    }
}

@end
