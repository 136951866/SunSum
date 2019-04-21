//
//  SSWxLoginVC.m
//  SunSum
//
//  Created by hank on 2018/10/15.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSWxLoginVC.h"
#import "SSAddTelView.h"
#import "SSWxAuthModel.h"
#import "JPUSHService.h"
#import "AppDelegate.h"
#import "SSTabBarVC.h"

@interface SSWxLoginVC (){
    BOOL _isNewUser;
}

@property (assign, nonatomic) BOOL isModelPush;

@property (weak, nonatomic) IBOutlet UIButton *btnWxLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnReturn;
@property (strong, nonatomic) SSAddTelView *addTelVIew;

@end

@implementation SSWxLoginVC

#pragma mark - LifeCycle

+ (void)toLoginVC{
    if([WXApi isWXAppInstalled]){
        SSWxLoginVC *loginvc = [[SSWxLoginVC alloc]init];
        loginvc.isShowCancel = NO;
        [kMeCurrentWindow setRootViewController:loginvc];
    }else{
        SSLoginVC *loginvc = [[SSLoginVC alloc]init];
        loginvc.isShowCancel = NO;
        [kMeCurrentWindow setRootViewController:loginvc];
    }
}

+ (void)presentLoginVCWithIsShowCancel:(BOOL)isShowCancel SuccessHandler:(kMeObjBlock)blockSuccess failHandler:(kMeObjBlock)blockFail{
    if([WXApi isWXAppInstalled]){
        SSWxLoginVC *loginvc = [[SSWxLoginVC alloc]init];
        loginvc.blockSuccess = blockSuccess;
        loginvc.blockFail = blockFail;
        loginvc.isModelPush = YES;
        loginvc.isShowCancel = isShowCancel;
        [SSCommonTool presentViewController:loginvc animated:YES completion:nil];
    }else{
        [SSLoginVC presentLoginVCWithIsShowCancel:isShowCancel SuccessHandler:blockSuccess failHandler:blockFail];
    }
}

+ (void)presentLoginVCWithSuccessHandler:(kMeObjBlock)blockSuccess failHandler:(kMeObjBlock)blockFail{
    if([WXApi isWXAppInstalled]){
        SSWxLoginVC *loginvc = [[SSWxLoginVC alloc]init];
        loginvc.blockSuccess = blockSuccess;
        loginvc.blockFail = blockFail;
        loginvc.isModelPush = YES;
        loginvc.isShowCancel = YES;
        [SSCommonTool presentViewController:loginvc animated:YES completion:nil];
    }else{
        [SSLoginVC presentLoginVCWithSuccessHandler:blockSuccess failHandler:blockFail];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    _isNewUser = YES;
    _btnWxLogin.hidden = _btnWxLogin.hidden = ![WXApi isWXAppInstalled];
    self.btnReturn.hidden = !self.isShowCancel;
}

#pragma mark - Private

-(void)loginSuccess{
    switch (kCurrentUser.user_type) {
        case 3:{
            //B
            [self loginIm];
            [SSPublicNetWorkTool getUserCheckFirstBuyWithSuccessBlock:nil failure:nil];
            //设置alias
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [JPUSHService setAlias:kMeUnNilStr(kCurrentUser.uid) completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    NSLog(@"iAlias=%@",iAlias);
                } seq:0];
            });
            kNoticeUserLogin
            [kMeCurrentWindow setRootViewController:[SSTabBarVC new]];
        }
            break;
        case 5:{
            //clerk
            [self loginIm];
            [SSPublicNetWorkTool getUserCheckFirstBuyWithSuccessBlock:nil failure:nil];
            //设置alias
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [JPUSHService setAlias:kMeUnNilStr(kCurrentUser.uid) completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    NSLog(@"iAlias=%@",iAlias);
                } seq:0];
            });
            kNoticeUserLogin
            [kMeCurrentWindow setRootViewController:[SSTabBarVC new]];
        }
            break;
        default:{
            [kCurrentUser removeFromLocalData];
            kMeAlter(@"提示", @"您还没有权限");
        }
            break;
    }
    if(self.isModelPush){
        kMeWEAKSELF
        [SSCommonTool dismissViewControllerAnimated:YES completion:^{
            kMeSTRONGSELF
            kMeCallBlock(strongSelf.blockSuccess,nil);
        }];
    }else{
        kMeCallBlock(self.blockSuccess,nil);
    }
}

-(void)loginFail{
    if(self.isModelPush){
        kMeWEAKSELF
        [SSCommonTool dismissViewControllerAnimated:YES completion:^{
            kMeSTRONGSELF
            kMeCallBlock(strongSelf.blockFail,nil);
        }];
    }else{
        kMeCallBlock(self.blockFail,nil);
    }
}

- (IBAction)wxlogin:(UIButton *)sender {
    [self.view endEditing:YES];
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            [SSShowViewTool showMessage:@"授权失败" view:kMeCurrentWindow];
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            
            SSWxAuthModel *model = [[SSWxAuthModel alloc]init];
            model.union_id = kMeUnNilStr(resp.unionId);
            model.app_openid = kMeUnNilStr(resp.openid);
            
            model.nick_name = kMeUnNilStr(resp.name);
            model.header_pic = kMeUnNilStr(resp.iconurl);
            NSString *str = @"3";
            if(kMeUnNilStr(resp.unionGender).length){
                str = [resp.unionGender isEqualToString:@"男"]?@"1":@"2";
            }
            model.gender = str;
            
            //            NSLog(@"%@", [model mj_keyValues]);
            [SSPublicNetWorkTool postWxAuthLoginWithAttrModel:model successBlock:^(ZLRequestResponse *responseObject) {
                
                [kCurrentUser setterWithDict:responseObject.data];
                [kCurrentUser save];
                NSString *strPhone = responseObject.data[@"mobile"];
                [self inJuicAddPhone:kMeUnNilStr(strPhone).length];
            } failure:^(id object) {
                [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
            }];
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}

//判断是否已经绑定手机号
- (void)inJuicAddPhone:(BOOL)isAadd{
    if(isAadd){
        [self loginSuccess];
    }else{
        [self.addTelVIew show];
    }
}

//登录融云
- (void)loginIm{
    if([SSUserInfoModel isLogin] && kMeUnNilStr(kCurrentUser.tls_data.tls_id).length && kMeUnNilStr(kCurrentUser.tls_data.user_tls_key).length){
        [[TUIKit sharedInstance] loginKit:kMeUnNilStr(kCurrentUser.tls_data.tls_id) userSig:kMeUnNilStr(kCurrentUser.tls_data.user_tls_key) succ:^{
            NSLog(@"sucess");
        } fail:^(int code, NSString *msg) {
            NSLog(@"fial");
        }];
    }
    [kMeApplication registerForRemoteNotifications];
}

- (SSAddTelView *)addTelVIew{
    if(!_addTelVIew){
        _addTelVIew = [[[NSBundle mainBundle]loadNibNamed:@"SSAddTelView" owner:nil options:nil] lastObject];
        _addTelVIew.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        kMeWEAKSELF
        _addTelVIew.finishBlock = ^(BOOL sucess) {
            kMeSTRONGSELF
            if(sucess){
                [strongSelf loginSuccess];
            }else{
                [kCurrentUser removeFromLocalData];
                [strongSelf loginFail];
            }
        };
    }
    return _addTelVIew;
}


- (IBAction)otherLoginAction:(UIButton *)sender {
    [self.view endEditing:YES];
    kMeWEAKSELF
    [SSLoginVC presentLoginVCWithIsShowCancel:self.isShowCancel SuccessHandler:^(id object) {
        [SSCommonTool dismissViewControllerAnimated:YES completion:^{
            kMeSTRONGSELF
            kMeCallBlock(strongSelf.blockSuccess,nil);
        }];
    } failHandler:^(id object) {
        
    }];
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self loginFail];
}

#pragma mark - Setter

@end
