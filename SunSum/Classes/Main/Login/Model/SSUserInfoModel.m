//
//  SSUserInfoModel.m
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSUserInfoModel.h"
#import "AppDelegate.h"
#import "JPUSHService.h"

static NSString *kUserInfoKey = @"kUserInfo";
static SSUserInfoModel *shareUser;

@implementation SSUserInfoModelTLSData

@end

@implementation SSUserInfoModel

//- (void)setUnionid:(NSString *)unionid{
//    _unionid = unionid;
//    [[NSUserDefaults standardUserDefaults]setObject:kMeUnNilStr(unionid) forKey:kTokenKey];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//}

- (void)setToken:(NSString *)token{
    _token = token;
    [[NSUserDefaults standardUserDefaults]setObject:kMeUnNilStr(token) forKey:kTokenKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (SSUserInfoModel *)shareUser{
    if (!shareUser) {
        shareUser = [SSUserInfoModel getObjctForKey:kUserInfoKey];
        if (!shareUser) {
            shareUser = [[SSUserInfoModel alloc]init];
        }
    }
    return shareUser;
}

+ (void)logout{
    //IM退出登录
    dispatch_async(dispatch_get_main_queue(), ^{
        [[TIMManager sharedInstance] logout:^{
            NSLog(@"su");
        } fail:^(int code, NSString *msg) {
            NSLog(@"fa");
        }];
    });
    [SSUserInfoModel removeCodingForKey:kUserInfoKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kcheckFirstBuy];
    [[NSUserDefaults standardUserDefaults] synchronize];
    shareUser = nil;
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kTokenKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
        } seq:0];
    });
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.unMessageCount=0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    kNoticeUserLogout
}

- (void)setterWithDict:(NSDictionary *)dict{
    if ([dict isKindOfClass:[NSDictionary class]]) {
        [self mj_setKeyValues:dict];
    }
}

#pragma mark - About Save

- (void)save{
    [self writeObjectForKey:kUserInfoKey];
}

- (void)removeFromLocalData{
    [SSUserInfoModel removeCodingForKey:kUserInfoKey];
    shareUser = nil;
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kTokenKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (BOOL)isLogin{
    if(kCurrentUser == nil){
        return FALSE;
    }else{
        if(kCurrentUser.token.length <=0 || kCurrentUser.token == nil){
            return FALSE;
        }else{
            return TRUE;
        }
    }
}

- (SSClientTypeStyle)client_type{
    //用户身份 4普通会员 3体验店 2营销中心 1售后中心 5店员
    if(self.user_type == 4){
        return SSClientCTypeStyle;
    }else if (self.user_type == 3){
        return SSClientBTypeStyle;
    }else if (self.user_type == 5){
        return SSClientTypeClerkStyle;
    }else if (self.user_type == 1){
        return SSClientOneTypeStyle;
    }else if (self.user_type == 2){
        return SSClientTwoTypeStyle;
    }else{
        return SSClientTypeErrorStyle;
    }
}

@end
