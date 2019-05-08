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
#define sdkAppid          1400208523
#define sdkAccountType    @"36862"

//友盟统计 修改
#define  MobAppkey @"5cd275210cafb2af11000e27"

//注册友盟分享微信//微信支付 修改
#define  UMWXAppId @"wx1eb21b6f8a855965"
#define  UMWXAppSecret @"f1afe966b2f81766780296a964bb3b2c"

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

//极光 修改
#define JpushAppKey @"5e62dc46b662bcf9738d745e"
#define JpushMasterSecret @"df6c56e47cea03bddeeb6e07"


#endif /* SSOtherMacros_h */
