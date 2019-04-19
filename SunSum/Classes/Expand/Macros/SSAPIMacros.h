//
//  SSAPIMacros.h
//  SunSum
//
//  Created by hank on 2018/9/5.
//  Copyright © 2018年 hank. All rights reserved.
//

#ifndef SSAPIMacros_h
#define SSAPIMacros_h

#warning -mustNotes 上线一定要注释/海报分享没有用BASEIP

//#define TestVersion

//域名 develop
#ifdef TestVersion
//#define BASEIP @"https://test.meshidai.com/api/"
//#define BASEIP @"https://develop.meshidai.com/api/"
#define BASEIP @"https://apitest.sunsumstore.com/api/"
#else
#define BASEIP @"https://apitest.sunsumstore.com/api/"
#endif

#define kGetApiWithUrl(url) [BASEIP stringByAppendingString:url]

#define SSIPgetQiniuToken @"getQiniuToken"

#pragma makr - TEST
#define SSIPgetTokenByFour @"common/user/getTokenByFour"

/*********************************************/
//网络状态码

#define kNetSuccess @"200"
#define kNetTokenInvalid @"401"
#define kNetError @"503"
#define kNetInvateCode @"502"


/*********************************************/
#pragma makr - 新版本 顾客 图文 店员

//图文
//获客图文-海报
#define SSIPcommonposterspostersVisitList @"common/posters/postersVisitList"
//获客图文-文章
#define SSIPcommonpostersarticleVisitList @"common/article/articleVisitList"


//店员
//员工排名
#define SSIPcommonclerkclerkOrderCount @"common/clerk/clerkOrderCount"
//运营日报(返回上面两个饼图数据)
#define SSIPcommonclerkdailyOperations @"common/clerk/dailyOperations"
//运营日报-员工今日未完成
#define SSIPcommonclerktodayClerkUnfinishTask @"common/clerk/todayClerkUnfinishTask"
//诊断结果-员工排名
#define SSIPcommonclerkdiagnosisClerkOrder @"common/clerk/diagnosisClerkOrder"
//员工管理(返回所有内容)
#define SSIPcommonclerkclerkManagement @"common/clerk/clerkManagement"
//工作统计-服务日志（统计部分）
#define SSIPcommonclerkserviceLog @"common/clerk/serviceLog"
//工作统计-服务日志(店员列表部分)
#define SSIPcommonclerkclerkServiceLog @"common/clerk/clerkServiceLog"
//任务祥情
#define SSIPcommonclertaskDetail @"common/clerk/taskDetail"
//计划达成-任务列表
#define SSIPcommonclerkTaskList @"common/clerk/taskList"
//计划达成
#define SSIPcommonclerkclerkTaskFinishState @"common/clerk/clerkTaskFinishState"
//工作日报
#define SSIPcommoncustomerdailyWorkReport @"common/customer/dailyWorkReport"
//店员通过分享数排名
#define SSIPcommonclerkclerkOrderByShareCount @"common/clerk/clerkOrderByShareCount"
//员工管理->员工日志
#define SSIPcommonclerkclerkTaskService @"common/clerk/clerkTaskService"
//员工管理->员工任务
#define SSIPcommonclerkclerkTask @"common/clerk/clerkTask"
//编写店员日志
#define SSIPcommonclerkfinishTask @"common/clerk/finishTask"
//店员任务列表
#define SSIPcommonclerkclerkTaskList @"common/clerk/clerkTaskList"
//员工管理->员工任务(查看更多)
#define SSIPcommonclerkclerkTaskMore @"common/clerk/clerkTaskMore"
//创建店员任务
#define SSIPcommonclerkcreateClerkTask @"common/clerk/createClerkTask"
//店员通过沟通（跟进）客户数排名
#define SSIPcommonclerkclerkOrderByFollowUpMemberCount @"common/clerk/clerkOrderByFollowUpMemberCount"
//店员通过发表动态次数排名
#define SSIPcommonclerkclerkOrderByPublishCount @"common/clerk/clerkOrderByPublishCount"
//店员通过沟通（跟进）数排名
#define SSIPcommonclerkclerkOrderByFollowUpCount @"common/clerk/clerkOrderByFollowUpCount"
//首页（返回所有数据）
#define SSIPcommonclerkhomeAll @"common/clerk/homeAll"

//顾客
//诊断结果（返回所有，员工排行暂未做）
#define SSIPcommoncustomercustomerDiagnose @"common/customer/customerDiagnose"
//本月客户数量、上月客户数量
#define SSIPcommoncustomerlastMonthAndThisMonthCustomerCount @"common/customer/lastMonthAndThisMonthCustomerCount"
//客户成长转化分析图
#define SSIPcommoncustomertransformationAnalysisChart @"common/customer/transformationAnalysisChart"
//本月客户成长
#define SSIPcommoncustomerthisMonthCustomerGrowth @"common/customer/thisMonthCustomerGrowth"



/*********************************************/







/*********************************************/
#pragma makr - ai
//查询 雷达(底部导航) 时间 访问人数数据信息
#define SSIPcommonairadartime @"common/airadar/time"
//互动次数查询
#define SSIPcommonairadarcommunication @"common/airadar/communication"
//雷达--行为
#define SSIPcommonaigetMemberBehavior @"common/airadar/getMemberBehavior"
//客户   -  加入时间
#define SSIPcommonaigetjoinTime @"common/airadar/joinTime"
//客户 -   活跃时间
#define SSIPcommonaigetactive @"common/airadar/active"
//客户 -   跟进
#define SSIPcommonaigetupdateFollow @"common/airadar/follow"
//客户搜索
#define SSIPcommonaigetsearch @"common/airadar/search"
//客户详情(雷达)
#define SSIPcommonaigetMemberDetail @"common/airadar/getMemberDetail"
//用户访问记录
#define SSIPcommonaigetMemberVisit @"common/airadar/getMemberVisit"
//获取客户资料
#define SSIPcommonaigetCustomerDetail @"common/airadar/customerDetail"
//修改客户资料
#define SSIPcommonaiupdateDetail @"common/airadar/updateDetail"
//实际跟进阶段   更新
#define SSIPcommonaiupdateFollow @"common/airadar/updateFollow"
//获取标签列表
#define SSIPcommonaigetLabel @"common/label/getLabel"
//设置用户标签
#define SSIPcommonaisetMemberLabel @"common/user/setMemberLabel"
//
#define SSIPcommonaifollowUpMember @""
/*********************************************/

/*********************************************/
#pragma makr - goodMannger
//获取门店权限
#define SSIPcommonggetStorePower @"common/store/getStorePower"
//申请
#define SSIPcommongGoodsGetStoreGoods @"common/goods/getStoreGoods"
//获取规格
#define SSIPcommonggetSpecName @"common/goods/getSpecName"
//获取门店商品类型
#define SSIPcommonggetStoreGoodsType @"common/goods/getStoreGoodsType"
//添加修改商品
#define SSIPcommonAddOrEditGoods @"common/goods/commonAddOrEditGoods"
//删除自定义商品
#define SSIPcommonDelStoreGoods @"common/goods/delStoreGoods"
//门店自定义商品祥情
#define SSIPcommonStoreGoodsDetail @"common/goods/storeGoodsDetail"


/*********************************************/
#pragma makr - xunweishi

//申请
#define SSIPcommongXunweishiApply @"common/xunweishi/apply"
//申请记录
#define SSIPcommongXunweishiApplyList @"common/xunweishi/applyList"
//申请祥情
#define SSIPcommongXunweishiDetail @"common/xunweishi/detail"

/*********************************************/
#pragma makr - BRAND
//总览
#define SSIPcommongStoreOverview @"common/store/storeOverview"
//排行榜
#define SSIPcommongCustomerRankingList @"common/store/customerRankingList"
//数据分析
#define SSIPcommongStoreDatAnalysis @"common/store/storeDatAnalysis"
//AI分析
#define SSIPcommongAiRank @"common/store/aiRank"
//能力排行
#define SSIPcommongAbilityRank @"common/store/abilityRank"
//来访记录
#define SSIPcommongStoreAccessCount @"common/store/storeAccessCount"
/*********************************************/
#pragma makr - IM
//获取tls用户信息
#define SSIPcommongUserInfoByTls @"common/user/getUserInfoByTls"

/*********************************************/
#pragma makr - 动态
//动态列表
#define SSIPcommongetDynamicList @"common/dynamic/getDynamicList"
//点赞
#define SSIPcommongetDynamicpraise @"common/dynamic/praise"
//评论
#define SSIPcommongetDynamiccommentt @"common/dynamic/comment"
//删除
#define SSIPcommongetDynamiDelDynamic @"common/dynamic/delDynamic"
//发表
#define SSIPcommongetGetVotingComment @"common/dynamic/addDynamic"
//上传图片
#define SSIPcommonUploadImages @"common/common/uploadImages"
/*********************************************/


/*********************************************/
#pragma makr - JD
//京粉精选商品查询接口
#define SSIPcommonjingdonggoodsJingFen @"common/jingdong/goodsJingFen"
//京东获取佣金商品详情
#define SSIPcommongetCommissionGoodsDetail @"common/jingdong/getCommissionGoodsDetail"
/*********************************************/

/*********************************************/
#pragma makr - JD
#define SSIPcommondJDgoodsPromotionUrlGenerate @"common/jingdong/createdPromotedByUnionid"
/*********************************************/


/*********************************************/
#pragma makr - pinduoduo
//获取拼多多商品列表
#define SSIPcommonduoduokeGetgetGoodsList @"common/duoduoke/getGoodsList"
//商品详情
#define SSIPcommonduoduokeGetgetGoodsInfo @"common/duoduoke/getGoodsInfo"
//多多进宝推广链接生成
#define SSIPcommonduoduokegoodsPromotionUrlGenerate @"common/duoduoke/goodsPromotionUrlGenerate"
//佣金祥情--商品
#define SSIPcommonduoduokeGetBrokerageDetailGoods @"common/duoduoke/getBrokerageDetailGoods"
//佣金祥情
#define SSIPcommonduoduokeGetBrokerageDetailBase @"common/duoduoke/getBrokerageDetailBase"
/*********************************************/


/*********************************************/
#pragma makr - taobao
//获取淘宝客Banner
#define SSIPcommonTaobaokeGetgetTbkBanner @"common/taobaoke/getTbkBanner"
//淘宝分类
#define SSIPcommonTaobaokeGetCategory @"common/taobaoke/getCategory"
//好券列表
#define SSIPcommonTaobaokeGetCoupon @"common/taobaoke/getCoupon"
//好券商品祥情
#define SSIPcommonTaobaokeGetGoodsInfo @"common/taobaoke/getGoodsInfo"
//淘口令
#define SSIPcommonTaobaokeGetGetTpwd @"common/taobaoke/getTpwd"
//通用物料搜索API
#define SSIPcommonTaobaokeGetDgMaterialOptional @"common/taobaoke/dgMaterialOptional"
//推广券信息查询
#define SSIPcommonTaobaokeGetTbkCouponGet @"common/taobaoke/tbkCouponGet"
/*********************************************/



/*********************************************/
#pragma makr - gift

//获取礼品首页banner
#define SSIPcommonGetGiftBanner @"common/ad/getGiftBanner"

/*********************************************/


/*********************************************/
#pragma makr - B&Clerk share
//商品编码
#define SSIPcommonGoodsEncode @"common/goods/getProductShareText"
//商品解码
#define SSIPcommonGoodsDecode @"common/goods/getDecodeShareText"

/*********************************************/




/*********************************************/
#pragma makr - B deal
//预约完成B端
#define SSIPcommonfinishReserve @"common/reserve/finishReserve"
//预约取消B端
#define SSIPcommoncancelReserve @"common/reserve/cancelReserve"
//预约列表B端
#define SSIPcommonreserveListB @"common/reserve/reserveListB"
//B端数据统计
#define SSIPcommonstatistics @"common/order/statistics"
//预约祥情B端
#define SSIPcommonreserveDetailB @"common/reserve/reserveDetailB"

//我的佣金
#define SSIPcommonMyBrokerage @"common/order/myBrokerage"
//佣金明细
#define SSIPcommonBrokerageDetail @"common/order/brokerageDetail"

/*********************************************/

/*********************************************/
#pragma makr - Withdrawal
//提现申请
#define SSIPcommondestoonFinanceCash @"common/money/destoonFinanceCash"
//提现列表
#define SSIPcommondestoonFinanceCashListh @"common/money/destoonFinanceCashList"
//提现明细
#define SSIPcommondestoonFinanceCashDetail @"common/money/destoonFinanceCashDetail"
/*********************************************/


/*********************************************/
#pragma makr - clerk

//店员列表
#define SSIPcommonMyClerk @"common/user/myClerk"
//会员列表
#define SSIPcommonMemberList @"common/user/memberList"
//删除店员
#define SSIPcommonClerkToMember @"common/user/clerkToMember"
//会员升级为店员
#define SSIPcommonMemberToClerk @"common/user/memberToClerk"
//店员排名列表
#define SSIPcommonMyClerkOrder @"common/user/myClerkOrder"
/*********************************************/



/*********************************************/
#pragma makr - AD

//广告banner
#define SSIPcommonAdGetAd @"common/ad/getAd"
//获取Banner
#define SSIPcommonGetBanner @"common/ad/getBanner"
/*********************************************/

/*********************************************/
#pragma makr - home
//获取秒杀商品
#define SSIPcommonGetgetSeckillGoods @"common/home/getSeckillGoods"
//获取秒杀时间
#define SSIPcommonGetgetSeckillTime @"common/home/getSeckillTime"

//获取首面的背景和banner
#define SSIPcommonGetActivity @"common/activity/getActivity"
//获取首页样式
#define SSIPcommonGetMystyle @"common/mystyle/getMystyle"
//获取通知消息
#define SSIPcommonGetMessage @"common/message/getMessage"
//获取2.0首页数据
#define SSIPcommonGetThridHomeBase @"common/home/getHomeBase"
//app获取店铺信息
#define SSIPcommonappHomePageData @"common/store/appHomePageData"
/*********************************************/



/*********************************************/
#pragma makr - articel
//文章分类列表
#define SSIPcommonGetArticleClass @"common/article/getArticleClass"
//获取文章列表
#define SSIPcommonGetArticle @"common/article/getArticle"
//文章详情
#define SSIPcommonFindArticle @"common/article/findArticle"
//分享文章
#define SSIPcommonShareAricel @"common/article/shareArticle"
//文章统计
#define SSIPcommonCountArticlel @"common/article/countArticle"
//访问统计
#define SSIPcommonGetAccess @"common/article/getAccess"
//获取客户
#define SSIPcommonGetAccessUser @"common/article/getAccessUser"
//文章传播路径
#define SSIPcommonGetSpreadPath @"common/article/spreadPath"
//海报传播路径
#define SSIPcommonGetPosterSpreadPath @"common/posters/posterSpreadPath"
//设为意向客户
#define SSIPcommonSetIntentioUser @"common/article/setIntentioUser"
//访问用户详情
#define SSIPcommonVistorUserInfo @"common/article/getSpreadUser"
/*********************************************/



/*********************************************/
#pragma makr - poster

//获取海报分类
#define SSIPcommonGetPostersClass @"common/posters/getPostersClass"
//根据分类获取海报列表
#define SSIPcommonFindPostersClass @"common/posters/findPostersClass"
//分享海报
#define SSIPcommonSharePoster @"common/posters/sharePoster"
//获取分享海报
#define SSIPcommonGetSharePoster @"common/posters/getSharePoster"
//获取活动海报列表
#define SSIPadminGetActivePoster @"common/groupfission/getActivity"
//查询会员当前活动任务情况
#define SSIPadminGetAppGetShare @"common/posters/getActivityLog"
//删除海报
#define SSIPcommonDelSharePosters @"common/posters/delSharePosters"
//获取活动海报二维码
#define SSIPadminappGetQrcode @"common/groupfission/appGetQrcode"
/*********************************************/


/*********************************************/
#pragma makr - member

//获取超级会员数据
#define SSIPcommonSupportMember @"common/goods/supportMember"
//获取兑换商品
#define SSIPcommonFindManyGoods @"common/goods/findManyGoods"

/*********************************************/




/*********************************************/
#pragma makr - Stroe
//app更新店铺商家信息
#define SSIPcommonUpdateStoreInfo @"common/store/updateStoreInfo"
//app获取店铺商家信息
#define SSIPcommonFindStoreInfo @"common/store/findStoreInfo"
//门店列表
#define SSIPcommonStoreStoreList @"common/store/getStoreList"
//门店祥情
#define SSIPcommonStoreGetStore @"common/store/getStore"
//服务详情
#define SSIPcommonserviceDetail @"common/goods/serviceDetail"
//提及服务
#define SSIPcommonCreateReserve @"common/reserve/createReserve"

#define SSIPcommonStoreSelectStore @"common/store/selectStore"
/*********************************************/



/*********************************************/
#pragma makr - Custom

//获取客服id
#define SSIPAppUserGetCustomer @"app/user/getCustomer"
//获取客服信息
#define SSIPCustomerGetUserInfo @"customer/auth/getCustomerInfo"
//获取用户信息
#define SSIPUserGetUserInfo @"common/user/getUser"
/*********************************************/




/*********************************************/
#pragma makr - Goods

//商品列表
#define SSIPcommonGoodsGetGoodsList @"common/goods/getGoodsList"
//商品详情
#define SSIPcommonGoodsGoodsDetail @"common/goods/goodsDetail"
//获取库存和价格
#define SSIPcommonGoodsGetPriceAndStock @"common/goods/getPriceAndStock"
//首页商品列表
#define SSIPcommonGoodsGoodsType @"common/goods/goodsType"
//详情推荐
#define SSIPcommonGoodsRecommend @"common/goods/getRecommend"
//获取980活动祥情
#define SSIPcommonGoodsComboDetail @"common/goods/goodsComboDetail"
//app分享
#define SSIPWechatAuthShare @"wechat/auth/index"
//app文章分享
#define SSIPWechatAuthArticelShare @"wechat/auth/article"
//分类
#define SSIPGoodsGetCategory @"common/goods/getCategory"
//抢购
#define SSIPGoodsRush @"common/ad/getPopUp"
//获取推荐到首次购买活动商品
#define SSIPRecommendProduct @"common/goods/getRecommendProduct"
//获取商品评论
#define SSIPRecommenGetGoodsComment @"common/goods/getGoodsComment"
/*********************************************/





/*********************************************/
#pragma makr - UserCentre
//获取当前用户的门店祥情
#define SSIPcommonGetMemberStoreInfo @"common/store/getMemberStoreInfo"
//门店申请、或修改申请
#define SSIPcommonStoreApply @"common/store/storeApply"
//一键已读
#define SSIPcommonAllreadedNotice @"common/message/listRead"
//已读消息
#define SSIPcommonreadedNotice @"common/message/findRead"
//获取未读的推送信息
#define SSIPcommonUnreadNotice @"common/message/getJpush"
//获取通知列表
#define SSIPcommonNotice @"common/message/getJpushList"
//获取未读总数
#define SSIPcommonCountList @"common/message/countList"
//3.0.1获取通知列表
#define SSIPcommonNotices @"common/message/getList"
//获取个人中心的数据
#define SSIPcommonUserUserCentre @"common/user/userCentre"
//获取商家分销中心
#define SSIPcommonAdminDistribution @"common/user/adminDistribution"
//获取用户全部订单
#define SSIPcommonUserGetOrderList @"common/user/getOrderList"
//自提订单
#define SSIPcommongetStoreGetOrderList @"common/user/getStoreGetOrder"
//获取订单详情
#define SSIPcommonUserGetOrderDetail @"common/user/getOrderSnDetail"
//设置到店领取订单(已提取)
#define SSIPcommoncheckStoreGetOrderStatus @"common/user/checkStoreGetOrderStatus"
//分销中心数据
#define SSIPcommonUserDistribution @"common/user/distribution"
//获取分销订单信息
#define SSIPcommonUserGetDistributionOrder @"common/user/getDistributionOrder"
//获取团队 C
#define SSIPcommonUserGetTeam @"common/user/getTeam"
//获取C端以上用户列表 B
#define SSIPcommonUserGetAdminTeam @"common/user/getAdminTeam"
//获取C端以上用户的订单明细 B
#define SSIPcommonUserGetAdminOrder @"common/user/getAdminOrder"
//获取C端二维码
#define SSIPcommonUserGetCode @"common/user/getCode"
//第二版 获取首页数据
//#define SSIPGetHomePageData @"homePageData"
//判断是否完成首单
#define SSIPcommonCheckFirstBuy @"common/user/checkFirstBuy"
//获取用户信息
#define SSIPcommonGetUser @"common/user/getUser"
/*********************************************/





/*********************************************/
#pragma makr - Order

//用户支付
#define SSIPcommonOrderPayOrder @"common/order/payOrder"
//订单轮询
#define SSIPcommonOrderGetOrderStatus @"common/order/getOrderStatus"
//普通下单
#define SSIPcommonOrderCreateOrder @"common/order/createOrder"
//生成兑换订单
#define SSIPcommonOrderConvertOrde @"common/order/convertOrder"
//购物车下单
#define SSIPcommonOrderCartOrder @"common/order/cartOrder"
//取消订单
#define SSIPcommonOrderCancelOrder @"common/order/cancelOrder"
//支付订单
#define SSIPCommonOrderPayOrder @"common/order/payOrder"
//获取物流
#define SSIPCommongetLogist @""

/*********************************************/





/*********************************************/
#pragma makr - ShopCart

//购物车列表
#define SSIPcommonCartCartGoodsList @"common/cart/cartGoodsList"
//加入购物车
#define SSIPcommonCartAddCart @"common/cart/addCart"
//删除购物车
#define SSIPcommonCartDeleteCart @"common/cart/deleteCart"
//购物车数量修改
#define SSIPcommonCartEditCartNum @"common/cart/editCartNum"
/*********************************************/


/*********************************************/
#pragma makr - AppointMent

//查看自己的预约订单
#define SSIPcommonGetReserveList @"common/reserve/getReserveList"
//取消预约
#define SSIPcommonDeleteReserve @"common/reserve/deleteReserve"
//获取预约详情
#define SSIPcommonUserGetAppointDetail @"common/reserve/reserveDetail"


/*********************************************/





/*********************************************/
#pragma makr - Address

//收货地址列表
#define SSIPcommonAddressAddressList @"common/address/addressList"
//新增收货地址 warn
#define SSIPcommonAddressAddAddress @"common/address/addAddress"
//获取某个地址详情
#define SSIPcommonAddressGetOneAddress @"common/address/getOneAddress"
//获取默认地址
#define SSIPcommonAddressGetdefaultAddress @"common/address/defaultAddress"

//编辑收货地址
#define SSIPcommonAddressEditAddress @"common/address/editAddress"
//删除地址
#define SSIPcommonAddressDelAddres @"common/address/delAddress"
//搜索产品
#define SSIPcommonFindGoods @"common/goods/findGoods"
/*********************************************/

/*********************************************/
#pragma makr - aboutUser

//收货地址列表
#define SSIPAppAuthLogin @"app/auth/login"
//app获取验证码
#define SSIPAppGetCodel @"app/auth/getMesCode"
//手机号登录
#define SSIPLoginByPhone @"app/auth/loginByPhone"
//wep绑定手机号码
#define SSIPaddPhone @"weapp/user/addPhone"
//修改手机号
#define SSIPeditPhone @"app/user/editPhone"

#define SSIPAddShare @"app/user/addShare"
//获取权益
#define SSIPcommonWebGetEquities @"common/web/getEquities"

#define SSIPShare [NSString stringWithFormat:@"%@?code=%@",kGetApiWithUrl(SSIPWechatAuthShare),kMeUnNilStr(kCurrentUser.uid)]
#define SSIPArticelShare [NSString stringWithFormat:@"%@?code=%@&pid=0&article_id=",kGetApiWithUrl(SSIPWechatAuthArticelShare),kMeUnNilStr(kCurrentUser.uid)]
#define SSIPposterShare @""
//获取赠送小程序的到期时间
#define SSIPExpMiniprogramAt @"common/user/getExpMiniprogramAt"
//获取app版本
#define SSIPGetAPPVersion @"getAppVersion"
//新的获取app更新版本
#define SSNewIPGetAPPVersion @"checkAppVersion"

/*********************************************/

#endif /* SSAPIMacros_h */
