//
//  SSOtherMacros.h
//  SunSum
//
//  Created by hank on 2018/9/5.
//  Copyright © 2018年 hank. All rights reserved.
//

#ifndef SSOtherMacros_h
#define SSOtherMacros_h

#pragma mark - 第三方macros

#define  AppstorePhone @"18823365313"

//腾讯云IM 修改
#define sdkAppid          1400196446
#define sdkAccountType    @"36862"

//友盟统计 修改
#define  MobAppkey @"5ca2cb2961f564172f001150"

//注册友盟分享微信//微信支付 修改
#define  UMWXAppId @"wx1d0d6c9d70256ba2"
#define  UMWXAppSecret @"9fa5bc19e35e34f6aef57d422ce97943"

//百度
#define BAIDUAK @""

////融云
//#ifdef TestVersion
//    #define RONGYUNAppKey @"m7ua80gbmjsam"
//    #define RONGYUNAppSecret @"BvxNWAGdqX"
//////客服id
////#define RONGYUNCUSTOMID @"KEFU153828643047594"
//#else
//    #define RONGYUNAppKey @"k51hidwqkc3hb"
//    #define RONGYUNAppSecret @"u2ofE9LnYNd"
////#define RONGYUNCUSTOMID @""
//#endif


// 0（默认值）表示采用的是开发证书，1 表示采用生产证书发布应用
#ifdef TestVersion
#define JpushType 0
#else
#define JpushType 1
#endif

//极光
#define JpushAppKey @"ea6dae8f5bf6015308432a99"
#define JpushMasterSecret @"5028fa44645cd9dd1f691b2c"


#endif /* SSOtherMacros_h */
