//
//  SSProductDetailsBottomView.m
//  SunSum
//
//  Created by hank on 2018/9/7.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSProductDetailsBottomView.h"
//#import "SSProductDetailsVC.h"
#import "SSThridProductDetailsVC.h"
#import "SSHomePageVC.h"
#import "SSStoreHomeVC.h"
#import "SSMidelButton.h"

@interface SSProductDetailsBottomView(){
    NSString *_paoductIdEndoceStr;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consPurchaseWdith;
@property (weak, nonatomic) IBOutlet SSMidelButton *btnShare;


@end

@implementation SSProductDetailsBottomView

- (void)awakeFromNib{
    [super awakeFromNib];
    _consPurchaseWdith.constant = 226 * kMeFrameScaleX();
    _btnShare.hidden = ![WXApi isWXAppInstalled];
}

- (IBAction)homeAction:(UIButton *)sender {
    SSThridProductDetailsVC *detailVC = (SSThridProductDetailsVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridProductDetailsVC class] targetResponderView:self];
    if(detailVC){
        detailVC.tabBarController.selectedIndex = 0;
        [detailVC.navigationController popToRootViewControllerAnimated:YES];
//        SSHomePageVC *homeVC = (SSHomePageVC *)[SSCommonTool getClassWtihClassName:[SSHomePageVC class] targetVC:detailVC];
//        if(homeVC){
//            [detailVC.navigationController popToViewController:homeVC animated:YES];
//        }else{
//            SSStoreHomeVC *shomeVC = (SSStoreHomeVC *)[SSCommonTool getClassWtihClassName:[SSStoreHomeVC class] targetVC:detailVC];
//            if(shomeVC){
//                [detailVC.navigationController popToViewController:shomeVC animated:YES];
//            }
//        }
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
    if(self.is_clerk_share){
        if(kCurrentUser.client_type == SSClientTypeClerkStyle){
            [self getShareEncode];
        }else{
            SSShareTool *shareTool = [SSShareTool me_instanceForTarget:self];
            shareTool.sharWebpageUrl = SSIPShare;
            NSLog(@"%@",SSIPShare);
#warning ---
            shareTool.shareTitle = @"鲜橙智店";
            shareTool.shareDescriptionBody = @"鲜橙智店";
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
    }else{
        SSShareTool *shareTool = [SSShareTool me_instanceForTarget:self];
        shareTool.sharWebpageUrl = SSIPShare;
        NSLog(@"%@",SSIPShare);
#warning --
        shareTool.shareTitle = @"鲜橙智店";
        shareTool.shareDescriptionBody = @"鲜橙智店";
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
}

- (void)getShareEncode{
    SSShareTool *shareTool = [SSShareTool me_instanceForTarget:self];
    if(kMeUnNilStr(_paoductIdEndoceStr).length){
        shareTool.shareTitle = kMeUnNilStr(_paoductIdEndoceStr);
        [shareTool showShareView:kShareTextContentType success:^(id data) {
            
        } failure:^(NSError *error) {
            
        }];
    }else{
        kMeWEAKSELF
        [SSPublicNetWorkTool postGoodsEncodeWithProductrId:self.productId successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_paoductIdEndoceStr = kMeUnNilStr(responseObject.data[@"share_text"]);
            shareTool.shareTitle = kMeUnNilStr(strongSelf->_paoductIdEndoceStr);
            [shareTool showShareView:kShareTextContentType success:^(id data) {
                
            } failure:^(NSError *error) {
                
            }];
        } failure:^(id object) {
            
        }];
    }
}


- (IBAction)shareWxCrial:(UIButton *)sender {
//    SSShareTool *shareTool = [SSShareTool me_instanceForTarget:self];
//    shareTool.sharWebpageUrl = @"http://www.baidu.com";
//    shareTool.shareTitle = @"test";
//    shareTool.shareDescriptionBody = @"test";
//    shareTool.shareImage = kMeGetAssetImage(@"icon-wgvilogo");
//
//    [shareTool shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine success:^(id data) {
//        NSLog(@"分享成功%@",data);
//        [SSShowViewTool showMessage:@"分享成功" view:kMeCurrentWindow];
//    } failure:^(NSError *error) {
//        NSLog(@"分享失败%@",error);
//        [SSShowViewTool showMessage:@"分享失败" view:kMeCurrentWindow];
//    }];
}

- (IBAction)addShopcart:(UIButton *)sender {
    kMeCallBlock(self.addShopcartBlock);
}

- (IBAction)buyAction:(UIButton *)sender {
    kMeCallBlock(self.buyBlock);
}

- (IBAction)customAction:(UIButton *)sender {
    kMeCallBlock(self.customBlock);
}

- (IBAction)giftAction:(UIButton *)sender {
    kMeCallBlock(self.buyBlock);
}


@end
