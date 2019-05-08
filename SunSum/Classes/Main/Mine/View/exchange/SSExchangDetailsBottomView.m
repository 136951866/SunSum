//
//  SSExchangDetailsBottomView.m
//  SunSum
//
//  Created by hank on 2018/10/22.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSExchangDetailsBottomView.h"
#import "SSMidelButton.h"
#import "SSMineExchangeDetailVC.h"

@interface SSExchangDetailsBottomView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consPurchaseWdith;
@property (weak, nonatomic) IBOutlet SSMidelButton *btnShare;

@end

@implementation SSExchangDetailsBottomView

- (void)awakeFromNib{
    [super awakeFromNib];
    _consPurchaseWdith.constant = 226 * kMeFrameScaleX();
    _btnShare.hidden = ![WXApi isWXAppInstalled];
}

- (IBAction)homeAction:(UIButton *)sender {
    SSMineExchangeDetailVC *detailVC = (SSMineExchangeDetailVC *)[SSCommonTool getVCWithClassWtihClassName:[SSMineExchangeDetailVC class] targetResponderView:self];
    if(detailVC){
        detailVC.tabBarController.selectedIndex = 0;
        [detailVC.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)shareWxFriendAction:(UIButton *)sender {
    if([SSUserInfoModel isLogin]){
        [self sharAction];
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            [strongSelf sharAction];
        } failHandler:nil];
    }
}

- (void)sharAction{
    SSShareTool *shareTool = [SSShareTool me_instanceForTarget:self];
    shareTool.sharWebpageUrl = SSIPShare;
#warning ---
    shareTool.shareTitle = @"棒的APP";
    shareTool.shareDescriptionBody = @"棒的APP";
    shareTool.shareImage = kMeGetAssetImage(@"icon-wgvilogo");
    
    [shareTool shareWebPageToPlatformType:UMSocialPlatformType_WechatSession success:^(id data) {
        NSLog(@"分享成功%@",data);
        [SSPublicNetWorkTool postAddShareWithSuccessBlock:nil failure:nil];
        [SSShowViewTool showMessage:@"分享成功" view:kMeCurrentWindow];
    } failure:^(NSError *error) {
        NSLog(@"分享失败%@",error);
        [SSShowViewTool showMessage:@"分享失败" view:kMeCurrentWindow];
    }];
}

- (IBAction)appointAction:(UIButton *)sender {
    kMeCallBlock(_exchangeBlock);
}

- (IBAction)customAction:(UIButton *)sender {
    kMeCallBlock(self.customBlock);
}


@end
