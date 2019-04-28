//
//  SSEuemMacros.h
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#ifndef SSEuemMacros_h
#define SSEuemMacros_h


#pragma mark - 界面相关枚举


//0 备注 1注意 2预约数

typedef enum : NSUInteger {
    SSClerkEditLogmarkType = 0,
    SSClerkEditLogNoticeType = 1,
    SSClerkEditLogServerNumType = 2,
} SSClerkEditLogType;

//首页
typedef enum : NSUInteger {
    SSHomeADADTYPE = 1,
    SSHomeADPRODUCTTYPE = 2,
    SSHomeADSERVICeTYPE = 3,
} SSHomeAD;


//我的Home
typedef enum : NSUInteger {
    MeMyAppointment =0,//预约
    MeMyCentraManagertment,//中心管理
    MeMyDistribution,//我的中心
    MeMyExchange,//兑换
    MeMyCollection,//收藏
    MeMyCustomer,//我的客服
    MeMyCustomerPhone,//客服电话
    MeMyAddress,//收货地址
    MeMyMobile,//绑定的手机号
    MeMyActity,
    MemyData,
    MeMyPoster,
    MeMyArticel,
    MeCouponMoney,
    MeStoreApply,
    MeDynalApply,
    MePAVistor,
    MeAILEI,
    MeHomedata,
    MeHomedianpu,
    MeHomedianyuan,
    MeHomeyuyue,
    MeHomejuanyngjing,
    MeHomemeiodu,
    MeHomeorderall,
    MeHomeshangji,
    MeHometixian,
    MeHometuandui,
    MeHometuigcode,
    MeHomeyongjing,
    MeHomeziti,
    MeHomepinpaigli,
    Mehomeyongjitongji,
    MeHomeCorderall,
    MeShopCartt,
    MeBrandStory
} SSMineHomeCellStyle;
#define SSMineHomeCellStyleTitle @[@"我的预约",@"中心管理",@"我的中心",@"兑换中心",@"我的收藏",@"聊天",@"客服电话",@"收货地址",@"绑定手机",@"我的活动",@"访客统计",@"获客海报",@"获客文章",@"优惠券佣金",@"门店申请",@"寻味师",@"获客图文",@"AI雷达",@"数据统计",@"店铺管理",@"店员管理",@"预约管理",@"优惠券佣金",@"我的美豆",@"佣金订单",@"我的上级",@"提现明细",@"我的团队",@"推广二维码",@"我的佣金",@"自提订单",@"品牌管理",@"佣金统计",@"美豆订单",@"购物车",@"品牌故事"]
#define SSMineHomeCellStyleImage @[@"icon_woddemiaosha",@"icon-khnytpgj",@"icon_fenxiaozhognxin",@"icon_zhuceyoujiang",@"icon_wodeshoucang",@"icon-qrpteb",@"icon-qrptebjnyt",@"nhwxfbfh",@"qlru",@"qritfc",@"minedata",@"mineposter",@"minearticel",@"iqpgweqq",@"uyyhjhyg",@"goodApply",@"minepa",@"homeailei",@"minedatatj",@"minedianpu",@"minedianyuan",@"mineyuyue",@"minejuanyongjin",@"minemeidou",@"mineorderall",@"mineshangji",@"minetixian",@"minetuandui",@"minetuigcode",@"mineyongjing",@"mineziti",@"minepinpai",@"mineyongjintongji",@"meidouorder",@"homeShopCart",@"minebrandstore"]

//订单
typedef enum : NSUInteger {
    SSAllOrder = 0,
    SSAllNeedPayOrder = 1,
    SSAllNeedDeliveryOrder = 2,
    SSAllNeedReceivedOrder = 3,
    SSAllFinishOrder = 4,
    SSAllCancelOrder = 5,
} SSOrderStyle;
#define SSOrderStyleTitle @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成",@"已取消"];

//B 端自提订单
typedef enum : NSUInteger {
    SSOSelfNotExtractionrderStyle = 1,
    SSOSelfExtractionedrderStyle = 2,
} SSOSelfExtractionrderStyle;

typedef enum : NSUInteger {
    SSGetCaseAllStyle = 0,
    SSGetCaseingStyle = 1,
    SSGetCaseedStyle = 2,
    SSGetCasenotStyle = 3,
    SSGetCasePayEdStyle = 4,
} SSGetCaseStyle;
#define MSSGetCaseStyleTitle @[@"全部",@"审核中",@"审核通过",@"审核失败",@"已打款"];

//订单结算
typedef enum : NSUInteger {
    SSSettlmemtGoodsPrice = 0,
    SSSettlmemtFreight = 1,
    SSSettlmemtRealPay = 2,
    SSSettlmemtExpressCompany = 3,
    SSSettlmemtExpressNum = 4,
    SSSettlmemtRemark = 5
} SSOrderSettlmentStyle;
#define SSOrderSettlmentStyleTitle @[@"订单金额",@"运费",@"实付金额",@"配送方式",@"快递编号",@"备注"];

//预约
typedef enum : NSUInteger {
    SSAppointmenyUseing = 0,
    SSAppointmenyUsed = 1,
    SSAppointmenyNotUsed = 2,
} SSAppointmenyStyle;
#define SSAppointmenyStyleTitle @[@"已预约",@"已使用",@"未使用"]

//预约信息
typedef enum : NSUInteger {
    SSAppointmentSettlmentTime = 0,
    SSAppointmentSettlmentTel = 1,
    SSAppointmentSettlmentFristBuy = 2,
    SSAppointmentSettlmentUserNameStyle = 3,
    SSAppointmentSettlmentUserTelStyle = 4
} SSAppointmentSettlmentStyle;

#define SSAppointmentSettlmentStyleTitle @[@"预约时间",@"店家手机",@"首次下单,新用户免费体验",@"客户名字",@"客户手机号"];

//分销订单
typedef enum : NSUInteger {
    SSDistrbutionOrder = 0,
    SSDistrbutionNeedPayOrder = 1,
    SSDistrbutionPayedOrder = 2,
    SSSSDistrbutionFinishOrder = 3,
} SSDistrbutionOrderStyle;

#define SSDistrbutionOrderStyleTitle @[@"全部",@"待付款",@"已完成",@"已完成"]

//分销订单
typedef enum : NSUInteger {
    SSMakrOrderCellMessage = 0,//留言
    SSMakrOrderCellDistribution = 1,//配送方式
    SSMakrOrderCellSuperMember = 2,//开通超级会员节省
    SSMakrOrderCellExhange = 3,//积分兑换
}  SSMakrOrderCellStyle;
#define SSMakrOrderCellStyleTitle @[@"买家留言",@"运费",@"开通超级会员本单节省",@"使用积分兑换"]


typedef enum : NSUInteger {
    SSDistributionMoney = 0,
    SSDistributionOrder,
    //SSDistributionTip,
    SSMyTeam,
    SSMyCode,
    
    SSMyMoney,
    SSMyLeave,
    SSMySuperior,
    SSMyClerk,
    SSMyAppintMannger,
    SSMyDataDeal,
    SSMyCash,
    SSMyBelongStore,
    SSMyMoneyDeal,
    SSMyCouponMoney,
    SSMyStoreMannager,
    SSMySelfExtractionOrder,
    SSBrandMannager,
    SSGoodMannager
} SSDistrbutionCellStyle;
#define SSDistrbutionCellStyleTitle @[@"我的美豆",@"我的订单",@"我的团队",@"推广二维码",@"订单金额",@"我的等级",@"我的上级",@"店员管理",@"预约管理",@"数据统计",@"提现明细",@"归属店",@"佣金统计",@"优惠劵佣金",@"店铺管理",@"自提订单",@"品牌管理",@"商品管理"];
#define SSDistrbutionCellStyleImage @[@"icon_fenxiaoyognjin",@"icon_fenxiaodigndan",@"icon_tuandui",@"icon_tuijian",@"icon_fenxiaoyognjin",@"icon_fenxiaodigndan",@"icon-qrhhxe",@"yhkmtpgj",@"cbxqtpgj",@"ovrntpgj",@"rjgmjexl",@"rnntuyyh",@"weqqxyyf",@"iqpgweqq",@"stroeManger",@"SelfExtractionOrder",@"kkthtpgj",@"customGood"];

//支付状态
typedef enum : NSUInteger {
    SSOrderStatusFailStyle = 0,
    SSOrderStatusSucessStyle = 1,
}  SSOrderStatusStyle;

typedef enum : NSUInteger {
    SSMainHomeStyle = 0,
    SSMainStoreStyle = 1,
    SSMainMemberStyle = 2,
    SSMainShopCartStyle = 3,
    SSMainMineStyle = 4,
}  SSMainStyle;

typedef enum : NSUInteger {
    SSSetAddressStyle = 0,
    SSSetPhoneStyle = 1,
    SSSetCLearChacheStyle = 2,
    SSSetAboutWeStyle = 3,
    SSSetCompandNoticeStyle = 4,
    SSSetNoticeStyle = 5
}  SSSetStyle;

typedef enum : NSUInteger {
    SSClientBTypeStyle,
    SSClientCTypeStyle,
    SSClientTypeClerkStyle,
    SSClientOneTypeStyle,
    SSClientTwoTypeStyle,
    SSClientTypeErrorStyle
}  SSClientTypeStyle;


#pragma mark- 网络请求相关枚举

//商品列表类型 1为爆款，2为推荐，3为积分兑换，4为服务列表
typedef enum : NSUInteger {
    SSGoodsTypeNetHotStyle = 1,
    SSGoodsTypeNetCommendStyle = 2,
    SSGoodsTypeNetExchangeStyle= 3,
    SSGoodsTypeNetServiceStyle = 4,
}  SSGoodsTypeNetStyle;


//1待支付 2待发货 3待收货 4已完成 查全部传空值
typedef enum : NSUInteger {
    SSOrderTypeNetWaitPayStyle = 1,
    SSOrderTypeNetDeliveryStyle = 2,
    SSOrderTypeNetReceivedStyle = 3,
    SSOrderTypeNetFinishStyle = 4,
}  SSOrderTypeNetStyle;


//type:1:9.9、2：时尚潮流、3人气爆款、4大额券、5特惠、6好货、7好券直播、8品牌
typedef enum : NSUInteger {
    SSCouponSearch99BuyType = 1,
    SSCouponSearchShiShangType = 2,
    SSCouponSearchGoodGoodsType = 3,
    SSCouponSearchBigJuanType = 4,
    SSCouponSearchTeHuiType = 5,
    SSCouponSearchTopBuyType = 6,
    SSCouponSearchGoodJuanType = 7,
    SSCouponSearchPinPaiType = 8,
}  SSCouponSearchType;

//用户类型
//typedef enum : NSUInteger {
//    SSLoginUserCType = 1,//C端用户
//    SSLoginUserBType = 2,//B端用户
//    SSLoginUserCLerkType = 3,//店员
//} SSLoginUserType;


typedef NS_ENUM(NSInteger,ButtonClickType){
    ButtonClickTypeNormal = 0,
    ButtonClickTypeUp = 1,
    ButtonClickTypeDown = 2,
};

#pragma mark- 系统相关枚举


typedef enum : NSUInteger {
    SSJpushNoticeType = 1,
    SSJpushOrderType = 2,
    SSJpushVersionUpdateType = 3,
    SSJpushIntoStoreType = 4,
    SSJpushUnreadMessageType = 5,
    SSJpushServiceAppointType = 7
} SSJpushType;

#endif /* SSEuemMacros_h */
