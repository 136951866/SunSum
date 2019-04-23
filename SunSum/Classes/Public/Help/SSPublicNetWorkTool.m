//
//  SSPublicNetWorkTool.m
//  SunSum
//
//  Created by hank on 2018/9/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSPublicNetWorkTool.h"
#import <Qiniu/QiniuSDK.h>
//相关参数model
#import "SSShoppingCartAttrModel.h"
#import "SSAddAddressAttrModel.h"
#import "SSMakeOrderAttrModel.h"
#import "SSShoppingCartMakeOrderAttrModel.h"
#import "SSWxAuthModel.h"
#import "SSAppointAttrModel.h"
#import "SSWithdrawalParamModel.h"
#import "SSBStoreMannagerEditModel.h"
#import "SSStoreApplyParModel.h"
#import "SSDynamicGoodApplyModel.h"
#import "SSAddGoodModel.h"
#import "SSAiCustomerDataModel.h"
#import "SSClerkCreateClerkTaskModel.h"
#import "SSClerkFinishTaskModel.h"

@implementation SSPublicNetWorkTool

/*********************************************/
#pragma makr - 新版本 顾客 图文 店员

// 店员
//员工管理(返回所有内容)
+ (void)postgetclerkclerkManagementWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonclerkclerkManagement);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

// 顾客
//诊断结果（返回所有，员工排行暂未做）
+ (void)postgetSSIPcommoncustomercustomerDiagnoseWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommoncustomercustomerDiagnose);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//工作日报
+ (void)postgetSSIPcommoncustomerdailyWorkReportWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommoncustomerdailyWorkReport);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//计划达成
+ (void)postgetSSIPcommonclerkTaskFinishStateWithdate:(NSString*)date SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonclerkclerkTaskFinishState);
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"date":kMeUnNilStr(date)} strUrl:url success:^(ZLRequestResponse *responseObject) {
//        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
//        if([error isKindOfClass:[ZLRequestResponse class]]){
//            ZLRequestResponse *res = (ZLRequestResponse*)error;
//            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
//        }else{
//            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
//        }
        kMeCallBlock(failure,error);
    }];
}

//运营日报(返回上面两个饼图数据)
+ (void)postgetclerkdailyOperationsWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonclerkdailyOperations);
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        //        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        //        if([error isKindOfClass:[ZLRequestResponse class]]){
        //            ZLRequestResponse *res = (ZLRequestResponse*)error;
        //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        //        }else{
        //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        //        }
        kMeCallBlock(failure,error);
    }];
}

//工作统计-服务日志（统计部分
+ (void)postgetSSIPcommonclerkserviceLogWithdate:(NSString*)date SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonclerkserviceLog);
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"date":kMeUnNilStr(date)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        //        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        //        if([error isKindOfClass:[ZLRequestResponse class]]){
        //            ZLRequestResponse *res = (ZLRequestResponse*)error;
        //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        //        }else{
        //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        //        }
        kMeCallBlock(failure,error);
    }];
}

//客户跟进（7天15天30天）统计
+ (void)postgetSSIPcommonclerknotFollowUpMemberWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonclerknotFollowUpMember);
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        //        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        //        if([error isKindOfClass:[ZLRequestResponse class]]){
        //            ZLRequestResponse *res = (ZLRequestResponse*)error;
        //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        //        }else{
        //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        //        }
        kMeCallBlock(failure,error);
    }];
}

//跟进投票用户（点击打电话时调用） 1投票活动2海报3文章4访问店铺
+ (void)postgetSSIPcommonclerknotFollowUpMemberWithUid:(NSString*)uid type:(NSInteger)type SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonaifollowUpMember);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"uid":kMeUnNilStr(uid),@"type":@(type)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        //        [HUD hideAnimated:YES];
        [HUD hideAnimated:YES];

        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [HUD hideAnimated:YES];

        //        if([error isKindOfClass:[ZLRequestResponse class]]){
        //            ZLRequestResponse *res = (ZLRequestResponse*)error;
        //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        //        }else{
        //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        //        }
        kMeCallBlock(failure,error);
    }];
}

//任务祥情
+ (void)postgetclerktaskDetailWithTaskId:(NSString*)taskId SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonclertaskDetail);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"id":kMeUnNilStr(taskId)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//创建店员任务
+ (void)postgetSSIPcommoncreateClerkTaskWithmodel:(SSClerkCreateClerkTaskModel*)model SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonclerkcreateClerkTask);
    NSDictionary *dic = [model mj_keyValues];
    MBProgressHUD *HUD = [self commitWithHUD:@"发布中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"发布成功"];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//编写店员日志
+ (void)postgetSSIPfinishTaskWithmodel:(SSClerkFinishTaskModel*)model SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonclerkfinishTask);
    NSDictionary *dic = [model mj_keyValues];
    MBProgressHUD *HUD = [self commitWithHUD:@"提交中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//首页（返回所有数据）
+ (void)postgetclerkhomeAllWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonclerkhomeAll);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//员工管理->员工日志
+ (void)postgetclerkclerkTaskServiceWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonclerkclerkTaskService);
//    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token)} strUrl:url success:^(ZLRequestResponse *responseObject) {
//        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
//        if([error isKindOfClass:[ZLRequestResponse class]]){
//            ZLRequestResponse *res = (ZLRequestResponse*)error;
//            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
//        }else{
//            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
//        }
        kMeCallBlock(failure,error);
    }];
}

/*********************************************/

/*********************************************/
#pragma makr - GoodMannger
#pragma makr - ai
//设置用户标签
+ (void)postgetCustomerGetLabelWithLabel:(NSString*)label uid:(NSString*)uid SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonaisetMemberLabel);
    MBProgressHUD *HUD = [self commitWithHUD:@"保存中"];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"uid":kMeUnNilStr(uid),@"label":kMeUnNilStr(label)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
//获取标签列表
+ (void)postgetCustomerGetLabelWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonaigetLabel);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [HUD hideAnimated:YES];
        kMeCallBlock(failure,error);
    }];
}

//实际跟进阶段   更新
+ (void)postgetCustomerupdateFollowWithUid:(NSString*)uid follow_up:(NSString*)follow_up SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonaiupdateFollow);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"uid":kMeUnNilStr(uid),@"follow_up":kMeUnNilStr(follow_up)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//修改客户资料
+ (void)postgetCustomerDetailWithModel:(SSAiCustomerDataModel*)model SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonaiupdateDetail);
    NSDictionary *dic = [model mj_keyValues];
    MBProgressHUD *HUD = [self commitWithHUD:@"修改客户资料"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//客户详情(雷达)
+ (void)postgetCustomerDetailWithUid:(NSString*)uid SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonaigetCustomerDetail);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取客户资料"];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"uid":kMeUnNilStr(uid)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [HUD hideAnimated:YES];
        kMeCallBlock(failure,error);
    }];
}

//客户详情(雷达)
+ (void)postgetMemberBehaviorWithUid:(NSString*)uid SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonaigetMemberDetail);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"uid":kMeUnNilStr(uid)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}


//雷达--行为
+ (void)postgetMemberBehaviorWithtype:(NSString*)type SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonaigetMemberBehavior);
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"uid":kMeUnNilStr(kCurrentUser.uid),@"day_type":kMeUnNilStr(type)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}


/*********************************************/
#pragma makr - GoodMannger

//
+ (void)postgetStorePowerWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonggetStorePower);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [HUD hideAnimated:YES];
        kMeCallBlock(failure,error);
    }];
}

+ (void)postgetStoreGoodsDetailWithProduct_id:(NSString*)pid SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonStoreGoodsDetail);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中"];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"id":kMeUnNilStr(pid)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [HUD hideAnimated:YES];
        kMeCallBlock(failure,error);
    }];
}

+ (void)postgetDelStoreGoodsWithProduct_id:(NSString*)pid SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonDelStoreGoods);
    MBProgressHUD *HUD = [self commitWithHUD:@"删除中"];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"product_id":kMeUnNilStr(pid)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [HUD hideAnimated:YES];
        kMeCallBlock(failure,error);
    }];
}

+ (void)postgetGoodSpecNameWithSuccessBlock:(RequestResponse)successBlock  failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonggetSpecName);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取规格"];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [HUD hideAnimated:YES];
        kMeCallBlock(failure,error);
    }];
}

+ (void)postcommonAddOrEditGoodsWithParModel:(SSAddGoodModel *)model successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(model.token),
                          @"list_order":kMeUnNilStr(model.list_order),
                          @"title":kMeUnNilStr(model.title),
                          @"desc":kMeUnNilStr(model.desc),
                          @"market_price":kMeUnNilStr(model.market_price),
                          @"money":kMeUnNilStr(model.money),
                          @"postage":kMeUnNilStr(model.postage),
                          
                          @"store_product_type":@(model.store_product_type),
                          @"ratio_after_sales":@(model.ratio_after_sales),
                          @"ratio_marketing":@(model.ratio_marketing),
                          @"ratio_store":@(model.ratio_store),
                          @"images":kMeUnNilStr(model.images),
                          @"images_hot":kMeUnNilStr(model.images_hot),
                          @"image_rec":kMeUnNilStr(model.image_rec),
                          
                          @"group_num":kMeUnNilStr(model.group_num),
                          @"over_time":kMeUnNilStr(model.over_time),
                          @"red_packet":kMeUnNilStr(model.red_packet),
                          @"start_time":kMeUnNilStr(model.start_time),
                          @"end_time":kMeUnNilStr(model.end_time),
                          
                          @"keywords":kMeUnNilStr(model.keywords),
                          @"state":@(model.state),
                          @"tool":@(model.tool),
                          @"is_new":@(model.is_new),
                          @"is_hot":@(model.is_hot),
                          @"is_recommend":@(model.is_recommend),
                          @"is_clerk_share":@(model.is_clerk_share),
                          
                          @"restrict_num":kMeUnNilStr(model.restrict_num),
                          @"category_id":kMeUnNilStr(model.category_id),
                          @"content":kMeUnNilStr(model.content),
                          @"product_id":kMeUnNilStr(model.product_id),
                          @"spec_json":kMeUnNilStr(model.spec_json),
                          @"spec_name":kMeUnNilStr(model.spec_name),
                          @"warehouse":@"1",
                          @"prompt":kMeUnNilStr(model.prompt),
                          @"promotion":kMeUnNilStr(model.promotion),
                          @"distribution":kMeUnNilStr(model.distribution),
                          @"delivery":kMeUnNilStr(model.delivery),
                          };
    NSLog(@"%@",model.spec_json);
    NSLog(@"%@",model.spec_name);
    
    NSLog(@"%@",dic);
    NSString *url = kGetApiWithUrl(SSIPcommonAddOrEditGoods);
    MBProgressHUD *HUD = [self commitWithHUD:@"提交中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

/*********************************************/
#pragma makr - xunweishi
+ (void)postXunweishiApplyWithParModel:(SSDynamicGoodApplyModel *)model images:(NSString*)images successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"true_name":kMeUnNilStr(model.true_name),
                          @"phone":kMeUnNilStr(model.phone),
                          @"goods_name":kMeUnNilStr(model.goods_name),
                          @"goods_detail":kMeUnNilStr(model.goods_detail),
                          @"price":kMeUnNilStr(model.price),
                          @"images":images,
                          @"token":kMeUnNilStr(model.token),
                          };
    NSLog(@"%@",dic);
    NSString *url = kGetApiWithUrl(SSIPcommongXunweishiApply);
//#ifdef TestVersion
//    url = [@"http://test_dev.meshidai.com/api/" stringByAppendingString:SSIPcommongXunweishiApply];
//#else
//    url = [@"https://msd.meshidai.com/api/" stringByAppendingString:SSIPcommonStoreApply];
//#endif
    MBProgressHUD *HUD = [self commitWithHUD:@"提交中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

/*********************************************/



/*********************************************/
#pragma makr - BRAND
//能力排行
+ (void)postgetAbilityRankWithStoreId:(NSString*)storeId SuccessBlock:(RequestResponse)successBlock  failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommongAbilityRank);
    //    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"store_id":kMeUnNilStr(storeId)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        //        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        //        [HUD hideAnimated:YES];
        kMeCallBlock(failure,error);
    }];
}
//数据分析
+ (void)postgetStoreDatAnalysisWithDate:(NSString *)date storeId:(NSString*)storeId SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommongStoreDatAnalysis);
    //    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"date":kMeUnNilStr(date),@"store_id":kMeUnNilStr(storeId)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        //        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        //        [HUD hideAnimated:YES];
        kMeCallBlock(failure,error);
    }];
}
//总览
+ (void)postgetStoreOverviewWithDate:(NSString *)date SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommongStoreOverview);
//    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"date":kMeUnNilStr(date)} strUrl:url success:^(ZLRequestResponse *responseObject) {
//        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
//        [HUD hideAnimated:YES];
        kMeCallBlock(failure,error);
    }];
}

/*********************************************/
#pragma makr - 公共

//获取永久七牛云TOKEN
+ (void)postgetForEvenQiuNiuTokkenWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPgetQiniuTokenPermanent);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [HUD hideAnimated:YES];
        kMeCallBlock(failure,error);
    }];
}

//获取七牛云TOKEN
+ (void)postgetQiuNiuTokkenWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPgetQiniuToken);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:@{} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [HUD hideAnimated:YES];
        kMeCallBlock(failure,error);
    }];
}

//上传图片
+ (void)postQiNiuUpFileWithToken:(NSString *)token filePath:(NSString *)filePath successBlock:(kMeObjBlock)successBlock failure:(kMeObjBlock)failure{
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
//    NSData *imageData = UIImagePNGRepresentation(image);
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    [upManager putFile:filePath key:nil token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if(info.ok){
            kMeCallBlock(successBlock,resp);
        }
        else{
            kMeCallBlock(failure,resp);
        }
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
    }
                option:uploadOption];
//    [upManager putData:imageData key:nil token:token
//              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//        if(info.ok){
//            kMeCallBlock(successBlock,resp);
//        }
//        else{
//            kMeCallBlock(failure,resp);
//        }
//        NSLog(@"info ===== %@", info);
//        NSLog(@"resp ===== %@", resp);
//    } option:uploadOption];
}


/*********************************************/
#pragma makr - IM
+ (void)postUserInfoByTlsWithTls_id:(NSString *)tls_id successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"tls_id":kMeUnNilStr(tls_id),@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPcommongUserInfoByTls);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [HUD hideAnimated:YES];
    }];
}

/*********************************************/

/*********************************************/
#pragma makr - 动态

//上传图片
+ (void)posUploadImagesWithFile:(UIImage *)image successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonUploadImages);
    NSData *imageData = UIImagePNGRepresentation(image);
    [THTTPManager postWithUrlStr:url parameter:@{@"token":kMeUnNilStr(kCurrentUser.token)} data:imageData showProgressView:nil success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id object) {
        kMeCallBlock(failure,object);
    }];
}

//B Clerk s发表评论
+ (void)postdynamicVotingCommentWithConten:(NSString *)content images:(NSString*)images successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"content":kMeUnNilStr(content),@"token":kMeUnNilStr(kCurrentUser.token),@"images":images};
    NSString *url = kGetApiWithUrl(SSIPcommongetGetVotingComment);
    MBProgressHUD *HUD = [self commitWithHUD:@"发表中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//删除
+ (void)postdynamicDelDynamicWithdynamicId:(NSString *)dynamic_id successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"id":kMeUnNilStr(dynamic_id),@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPcommongetDynamiDelDynamic);
    MBProgressHUD *HUD = [self commitWithHUD:@"删除中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
//点赞
+ (void)postdynamicPraiselWithdynamicId:(NSString *)dynamic_id successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"dynamic_id":kMeUnNilStr(dynamic_id),@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPcommongetDynamicpraise);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
//评论
+ (void)postdynamicCommentdynamicId:(NSString *)dynamic_id content:(NSString*)content successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"dynamic_id":kMeUnNilStr(dynamic_id),@"token":kMeUnNilStr(kCurrentUser.token),@"content":kMeUnNilStr(content)};
    NSString *url = kGetApiWithUrl(SSIPcommongetDynamiccommentt);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

/*********************************************/
#pragma makr - JD
+ (void)postJDPromotionUrlGenerateWithUid:(NSString *)uid materialUrl:(NSString*)materialUrl couponUrl:(NSString*)couponUrl successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"materialUrl":kMeUnNilStr(materialUrl),@"link":kMeUnNilStr(couponUrl)};
    if(kMeUnNilStr(uid).length){
        dic = @{@"materialUrl":kMeUnNilStr(materialUrl),@"link":kMeUnNilStr(couponUrl),@"member_id":kMeUnNilStr(uid)};
    }
    MBProgressHUD *HUD = [self commitWithHUD:@"生成推广链接中"];
    NSString *url = kGetApiWithUrl(SSIPcommondJDgoodsPromotionUrlGenerate);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

/*********************************************/
#pragma makr - pinduoduo

+ (void)postGetPinduoduoCommondPoductWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"sort_type":@"20",@"pageSize":@"10"};
    NSString *url = kGetApiWithUrl(SSIPcommonduoduokeGetgetGoodsList);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}

//佣金祥情
+ (void)postGetPinduoduoBrokerageDetailBaseWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPcommonduoduokeGetBrokerageDetailBase);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}

+ (void)postPinDuoduoGoodsDetailWithGoodsId:(NSString *)goodsId successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"goods_id_list":[NSString stringWithFormat:@"[%@]",kMeUnNilStr(goodsId)],
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonduoduokeGetgetGoodsInfo);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//多多进宝推广链接生成
+ (void)postPromotionUrlGenerateWithUid:(NSString *)uid goods_id_list:(NSString*)goods_id_list SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"goods_id_list":kMeUnNilStr(goods_id_list)};
    if(kMeUnNilStr(uid).length){
        dic = @{@"member_id":kMeUnNilStr(uid),
                @"goods_id_list":kMeUnNilStr(goods_id_list)
                };
    }
    MBProgressHUD *HUD = [self commitWithHUD:@"生成推广链接中"];
    NSString *url = kGetApiWithUrl(SSIPcommonduoduokegoodsPromotionUrlGenerate);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
/*********************************************/

/*********************************************/

#pragma makr - taobao

//获取淘宝客Banner
+ (void)postAgetTbkBannerWithsuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"tool":@"1",
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonTaobaokeGetgetTbkBanner);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}

//推广券信息查询
+ (void)postCoupleTbkCouponGetWithActivity_id:(NSString *)activity_id item_id:(NSString*)item_id successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"activity_id":kMeUnNilStr(activity_id),@"item_id":kMeUnNilStr(item_id)};
    NSString *url = kGetApiWithUrl(SSIPcommonTaobaokeGetTbkCouponGet);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}

//通用物料搜索API
+ (void)postCoupledgMaterialOptionalWithType:(SSCouponSearchType)type successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"type":@(type),@"page":@"1",@"pageSize":@"6"};
    NSString *url = kGetApiWithUrl(SSIPcommonTaobaokeGetDgMaterialOptional);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}

+ (void)postShareTaobaokeGetTpwdWithTitle:(NSString *)title url:(NSString*)url logo:(NSString*)logo successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"tool":@"ios",@"text":kMeUnNilStr(title),@"logo":kMeUnNilStr(logo),@"url":kMeUnNilStr(url),@"uid":kMeUnNilStr(kCurrentUser.uid)};
    NSString *urlApi = kGetApiWithUrl(SSIPcommonTaobaokeGetGetTpwd);
    MBProgressHUD *HUD = [self commitWithHUD:@"生成口令中"];
    [THTTPManager postWithParameter:dic strUrl:urlApi success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
//淘口令
+ (void)postTaobaokeGetTpwdWithTitle:(NSString *)title url:(NSString*)url logo:(NSString*)logo successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"tool":@"ios",@"text":kMeUnNilStr(title),@"logo":kMeUnNilStr(logo),@"url":kMeUnNilStr(url)};
    NSString *urlApi = kGetApiWithUrl(SSIPcommonTaobaokeGetGetTpwd);
    MBProgressHUD *HUD = [self commitWithHUD:@"生成口令中"];
    [THTTPManager postWithParameter:dic strUrl:urlApi success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
//卷详情
+ (void)postCoupleDetailWithProductrId:(NSString *)productrId successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    //    NSString *url = [NSString stringWithFormat:@"http://api.dataoke.com/index.php?r=port/index&appkey=58de5a1fe2&v=2&id=%@",kMeUnNilStr(productrId)];
    //    MBProgressHUD *HUD = [self commitWithHUD:@""];
    //    [THTTPManager orgialGetWithUrlStr:url parameter:@{} success:^(NSDictionary *dic) {
    //        [HUD hideAnimated:YES];
    //        kMeCallBlock(successBlock,dic);
    //    } failure:^(id object) {
    //        [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
    //        kMeCallBlock(failure,object);
    //    }];
    NSDictionary *dic = @{@"tool":@"ios",@"num_iids":kMeUnNilStr(productrId)};
    NSString *url = kGetApiWithUrl(SSIPcommonTaobaokeGetGoodsInfo);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}
+ (void)postAddressTaobaokeGetCategoryWithsuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{};
    NSString *url = kGetApiWithUrl(SSIPcommonTaobaokeGetCategory);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
/*********************************************/


/*********************************************/
#pragma makr - gift
+ (void)postAgetGiftBannerWithsuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"tool":@"1",
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGetGiftBanner);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}


/*********************************************/
#pragma makr - couple

/*********************************************/

/*********************************************/
#pragma makr - B&Clerk share
+ (void)postGoodsEncodeWithProductrId:(NSString *)productrId successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token),@"product_id":kMeUnNilStr(productrId)};
    NSString *url = kGetApiWithUrl(SSIPcommonGoodsEncode);
    MBProgressHUD *HUD = [self commitWithHUD:@"生成分享口令中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postGoodsEncodeWithStr:(NSString *)str successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"share_text":kMeUnNilStr(str)};
    NSString *url = kGetApiWithUrl(SSIPcommonGoodsDecode);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            //            ZLRequestResponse *res = (ZLRequestResponse*)error;
            //            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
            //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            //            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
            //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

/*********************************************/



/*********************************************/
#pragma makr - B deal
+ (void)postGetBstatisticsWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPcommonstatistics);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
//我的佣金
+ (void)postMyBrokerageWithType:(SSClientTypeStyle)type memberId:(NSString *)memberId SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"token"] = kMeUnNilStr(kCurrentUser.token);
    if(type == SSClientBTypeStyle){
        dic[@"memberId"] = kMeUnNilStr(memberId);
    }
    NSString *url = kGetApiWithUrl(SSIPcommonMyBrokerage);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}


/*********************************************/

/*********************************************/
#pragma makr - Withdrawal

+ (void)postDestoonFinanceCashWithAttrModel:(SSWithdrawalParamModel *)attrModel successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSMutableDictionary *dic = [attrModel mj_keyValues];
    NSLog(@"%@",dic);
    NSString *url = kGetApiWithUrl(SSIPcommondestoonFinanceCash);
    MBProgressHUD *HUD = [self commitWithHUD:@"申请提现中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"申请成功"];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
/***************************************/


/***************************************/
#pragma mark - clerk
//删除店员
+ (void)postClerkToMemberWithmemberId:(NSString *)memberId successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token),@"memberId":kMeUnNilStr(memberId)};
    NSString *url = kGetApiWithUrl(SSIPcommonClerkToMember);
    MBProgressHUD *HUD = [self commitWithHUD:@"删除中"];
    [THTTPManager getWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)posMemberToClerkWithmemberId:(NSString *)memberId successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token),@"memberId":kMeUnNilStr(memberId)};
    NSString *url = kGetApiWithUrl(SSIPcommonMemberToClerk);
    MBProgressHUD *HUD = [self commitWithHUD:@"升级中"];
    [THTTPManager getWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}


/***************************************/

/***************************************/
#pragma mark - Article
//访问用户详情
+ (void)postVistorUserInfoWithuserId:(NSString *)userId successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token),@"uid":kMeUnNilStr(userId)};
    NSString *url = kGetApiWithUrl(SSIPcommonVistorUserInfo);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取用户详情"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
//访问统计
+ (void)postGetAccessWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPcommonGetAccess);
    MBProgressHUD *HUD = [self commitWithHUD:@"刷新中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postSetIntentioUserId:(NSString *)userId intentio:(NSString *)intentio SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token),@"id":kMeUnNilStr(userId),@"intentio":kMeUnNilStr(intentio)};
    NSString *url = kGetApiWithUrl(SSIPcommonSetIntentioUser);
    MBProgressHUD *HUD = [self commitWithHUD:@"设置中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postGetAccessUserWithIntention:(NSInteger)intention successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{};
    switch (intention) {
        case 0:{
            dic = @{@"token":kMeUnNilStr(kCurrentUser.token),@"page":@"1"};
        }
            break;
        case 1:{
            dic = @{@"token":kMeUnNilStr(kCurrentUser.token),@"is_intention":@"2",@"page":@"1"};
        }
            break;
        case 2:{
            dic =  @{@"token":kMeUnNilStr(kCurrentUser.token),@"is_intention":@"1",@"page":@"1"};
        }
            break;
        default:
            dic = @{};
            break;
    }
    NSString *url = kGetApiWithUrl(SSIPcommonGetAccess);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
//SSIPcommonGetAccessUser

//获取文章分类
+ (void)postArticleClassWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{};
    NSString *url = kGetApiWithUrl(SSIPcommonGetArticleClass);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postArticleClassWithId:(NSString *)aid successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"article_id":kMeUnNilStr(aid),@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPcommonFindArticle);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postShareArticelWithId:(NSString *)aid SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"article_id":aid,@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPcommonShareAricel);
    //    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        //        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
            //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
            //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postCountArticleWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPcommonCountArticlel);
    //    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        //        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}


/***************************************/

/***************************************/

#pragma mark - Poster
//获取海报分类
+ (void)postPostersClassWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{};
    NSString *url = kGetApiWithUrl(SSIPcommonGetPostersClass);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postSharePosterWithId:(NSString *)posters_id SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"posters_id":posters_id,@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPcommonSharePoster);
    //    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        //        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postDelSharePosterWithId:(NSString *)shareId SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"id":shareId,@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPcommonDelSharePosters);
    MBProgressHUD *HUD = [self commitWithHUD:@"删除中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}


/***************************************/

#pragma mark - Custom

+ (void)postGetCustomIdWithsuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{};
    NSString *url = kGetApiWithUrl(SSIPAppUserGetCustomer);
    MBProgressHUD *HUD = [self commitWithHUD:@"请稍后,正在为您分配客服"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postGetCustomerGetUserInfoWithUid:(NSString*)uid SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"customer_id":kMeUnNilStr(uid),@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPCustomerGetUserInfo);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}

+ (void)postGetUserGetUserInfoWithUid:(NSString*)uid SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"uid":kMeUnNilStr(uid),@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPUserGetUserInfo);
    [THTTPManager getWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}

#pragma mark - HomePage

//app获取店铺信息
+ (void)postGetappHomePageDataWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPcommonappHomePageData);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}

//获取秒杀商品
+ (void)postThridHomegetSeckillGoodsWithSeckillTime:(NSString*)time SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"product_position":@"3",@"seckill_time":kMeUnNilStr(time),@"page":@"1",@"pageSize":@"6"};
    NSString *url = kGetApiWithUrl(SSIPcommonGetgetSeckillGoods);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//获取秒杀时间
+ (void)postThridHomeGetSeckillTimeSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{};
    NSString *url = kGetApiWithUrl(SSIPcommonGetgetSeckillTime);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

//获取2.0首页数据
+ (void)postThridHomeStyleWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"tool":@"1"
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGetThridHomeBase);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

//获取通知消息
+ (void)postGetMessageWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"tool":@"1"
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGetMessage);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postActivityWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"tool":@"1"
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGetActivity);
    [THTTPManager getWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}
+ (void)postMystyleWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"tool":@"1"
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGetMystyle);
    [THTTPManager getWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}


+ (void)postAdWithPosition_id:(NSInteger)position_id successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"position_id":@(position_id),
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonAdGetAd);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postAdWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"tool":@"1"
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGetBanner);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}


#pragma mark - Store

+ (void)postCreatAppointWithAttrModel:(SSAppointAttrModel *)attrModel successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSMutableDictionary *dic = [attrModel mj_keyValues];
    [dic removeObjectForKey:@"storeName"];
    [dic removeObjectForKey:@"isFromStroe"];
    NSLog(@"%@",dic);
    NSString *url = kGetApiWithUrl(SSIPcommonCreateReserve);
    MBProgressHUD *HUD = [self commitWithHUD:@"预约中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"预约成功"];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}


+ (void)postDelAppointWithReserveSn:(NSString *)reserve_sn successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"reserve_sn":kMeUnNilStr(reserve_sn),@"token":kMeUnNilStr(kCurrentUser.token)
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonDeleteReserve);
    MBProgressHUD *HUD = [self commitWithHUD:@"删除预约中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"删除成功"];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//预约完成B端
+ (void)postFinishReserveWithReserveSn:(NSString *)reserve_sn successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"reserve_sn":kMeUnNilStr(reserve_sn),@"token":kMeUnNilStr(kCurrentUser.token)
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonfinishReserve);
    MBProgressHUD *HUD = [self commitWithHUD:@"预约完成中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"已完成"];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//预约取消B端
+ (void)postCancelReserveWithReserveSn:(NSString *)reserve_sn successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"reserve_sn":kMeUnNilStr(reserve_sn),@"token":kMeUnNilStr(kCurrentUser.token)
                          };
    NSString *url = kGetApiWithUrl(SSIPcommoncancelReserve);
    MBProgressHUD *HUD = [self commitWithHUD:@"预约取消中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"已取消"];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}


#pragma mark - Goods

+ (void)postGoodFilterWithsuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{};
    NSString *url = kGetApiWithUrl(SSIPGoodsGetCategory);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
        [HUD hideAnimated:YES];
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postRecommendProductWithsuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"tool":@"3"};
    NSString *url = kGetApiWithUrl(SSIPRecommendProduct);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postRushGoodWithsuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"tool":@"1"};
    NSString *url = kGetApiWithUrl(SSIPGoodsRush);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postGoodsTypeWithArticleCategoryId:(NSUInteger)ArticleCategoryId successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"article_category_id":@(ArticleCategoryId),
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGoodsGoodsType);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postHomeRecommendWithsuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"other":@"is_recommend",
                          @"uid":kMeUnNilStr(kCurrentUser.uid)
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonFindGoods);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postGoodsListTopWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"other":@"is_hot",
                           @"uid":kMeUnNilStr(kCurrentUser.uid)
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonFindGoods);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}


+ (void)postGoodsListWithType:(SSGoodsTypeNetStyle)type successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"type":@(type),
                          @"uid":kMeUnNilStr(kCurrentUser.uid)
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGoodsGetGoodsList);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postHomeNewGoodsListWithType:(NSString *)type successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"other":kMeUnNilStr(type),
                           @"uid":kMeUnNilStr(kCurrentUser.uid)
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonFindGoods);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postGoodsDetailWithGoodsId:(NSInteger)goodsId successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"goodsId":@(goodsId),
                          @"uid":kMeUnNilStr(kCurrentUser.uid)
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGoodsGoodsDetail);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postGoodsDetailWithGoodsId:(NSInteger)goodsId seckillTime:(NSString*)seckillTime successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"goodsId":@(goodsId),
                          @"seckill_time":kMeUnNilStr(seckillTime),
                          @"uid":kMeUnNilStr(kCurrentUser.uid)
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGoodsGoodsDetail);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postGoodsComboDetailWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"productType":@(3),
                          @"token":kMeUnNilStr(kCurrentUser.token)
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGoodsComboDetail);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:[NSString stringWithFormat:@"%@%@",@"获取详情失败,",kApiError]];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postPriceAndStockWithGoodsId:(NSString *)goodsId specIds:(NSString *)specIds ssuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"goods_id":goodsId,
                          @"spec_ids":specIds,
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGoodsGetPriceAndStock);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取库存中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            NSString *error = [NSString stringWithFormat:@"%@%@",@"获取库存失败,",kApiError];
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:error];
        }
        kMeCallBlock(failure,error);
    }];
}

#pragma mark - Shopcart

//删除购物车
+ (void)postDelGoodForShopWithMemberId:(NSInteger)memberId productCartId:(NSString *)productcartid successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          @"product_cart_id":kMeUnNilStr(productcartid),
                          //                          @"member_id":@(memberId)
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonCartDeleteCart);
    MBProgressHUD *HUD = [self commitWithHUD:@"删除中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)posteditCartNumWithShopCartId:(NSInteger)shopCartId num:(NSInteger)num successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          @"num":@(num).description,
                          @"id":@(shopCartId).description
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonCartEditCartNum);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postAddGoodForShopWithAttrModel:(SSShoppingCartAttrModel *)attrModel successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = [attrModel mj_keyValues];
    NSString *url = kGetApiWithUrl(SSIPcommonCartAddCart);
    MBProgressHUD *HUD = [self commitWithHUD:@"加入中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"加入成功"];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postCreateShopOrderWithAttrModel:(SSShoppingCartMakeOrderAttrModel *)attrModel successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = [attrModel mj_keyValues];
    NSLog(@"%@",dic);
    NSString *url = kGetApiWithUrl(SSIPcommonOrderCartOrder);
    MBProgressHUD *HUD = [self commitWithHUD:@"生成订单中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        //        [HUD hideAnimated:YES];
        [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"生成成功"];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}



#pragma mark - Address

//新增收货地址
+ (void)postAddAddressWithAttrModel:(SSAddAddressAttrModel *)attrModel successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    if(!kMeUnNilStr(attrModel.truename).length){
        [SSShowViewTool showMessage:@"名字不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(attrModel.telphone).length){
        [SSShowViewTool showMessage:@"手机号不能为空" view:kMeCurrentWindow];
        return;
    }
    if(![SSCommonTool isValidPhoneNum:kMeUnNilStr(attrModel.telphone)]){
        [SSShowViewTool showMessage:@"请填写正确的手机号码" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(attrModel.detail_address).length){
        [SSShowViewTool showMessage:@"地址不能为空" view:kMeCurrentWindow];
        return;
    }
    NSDictionary *dic = [attrModel mj_keyValues];
    NSString *url = kGetApiWithUrl(SSIPcommonAddressAddAddress);
    MBProgressHUD *HUD = [self commitWithHUD:@"添加地址中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
//编辑收货地址
+ (void)postEditAddressWithAttrModel:(SSAddAddressAttrModel *)attrModel successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    if(!kMeUnNilStr(attrModel.truename).length){
        [SSShowViewTool showMessage:@"名字不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(attrModel.telphone).length){
        [SSShowViewTool showMessage:@"手机号不能为空" view:kMeCurrentWindow];
        return;
        if(![SSCommonTool isValidPhoneNum:kMeUnNilStr(attrModel.telphone)]){
            [SSShowViewTool showMessage:@"请填写正确的手机号码" view:kMeCurrentWindow];
            return;
        }
    }
    if(!kMeUnNilStr(attrModel.detail_address).length){
        [SSShowViewTool showMessage:@"地址不能为空" view:kMeCurrentWindow];
        return;
    }
    NSDictionary *dic = [attrModel mj_keyValues];
    NSString *url = kGetApiWithUrl(SSIPcommonAddressEditAddress);
    MBProgressHUD *HUD = [self commitWithHUD:@"编辑地址中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
/*删除地址
 address_id    是    string    地址id
 token    是    string    用户凭证
 */
+ (void)postDelAddressWithAddressId:(NSInteger)AddressId successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"address_id":@(AddressId),
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonAddressDelAddres);
    MBProgressHUD *HUD = [self commitWithHUD:@"删除中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postAddressDetailWithAddressId:(NSInteger)AddressId successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"address_id":@(AddressId),
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonAddressGetOneAddress);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postAddressDefaultAddressWithsuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonAddressGetdefaultAddress);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}



#pragma mark - UserCentre

+ (void)postGetMemberStoreInfoWithsuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonGetMemberStoreInfo);
//#ifdef TestVersion
//    url = [@"http://test_dev.meshidai.com/api/" stringByAppendingString:SSIPcommonGetMemberStoreInfo];
//#else
//    url = [@"https://msd.meshidai.com/api/" stringByAppendingString:SSIPcommonGetMemberStoreInfo];
//#endif
    MBProgressHUD *HUD = [self commitWithHUD:@"获取审核状态"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postStoreApplyWithModel:(SSStoreApplyParModel *)model SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
//    NSMutableDictionary *dic = [model mj_keyValues];
//    [dic removeObjectForKey:@"mask_imgModel"];
//    [dic removeObjectForKey:@"mask_info_imgModel"];
//    [dic removeObjectForKey:@"business_imagesModel"];
    NSDictionary *dic = @{
                          @"true_name":kMeUnNilStr(model.true_name),
                          @"store_name":kMeUnNilStr(model.store_name),
                          @"name":kMeUnNilStr(model.name),
                          @"mobile":kMeUnNilStr(model.mobile),
                          @"intro":kMeUnNilStr(model.intro),
                          @"province":kMeUnNilStr(model.province),
                          @"city":kMeUnNilStr(model.city),
                          @"district":kMeUnNilStr(model.district),
                          @"address":kMeUnNilStr(model.address),
                          @"latitude":kMeUnNilStr(model.latitude),
                          @"longitude":kMeUnNilStr(model.longitude),
                          @"mask_img":kMeUnNilStr(model.mask_img),
                          @"mask_info_img":kMeUnNilStr(model.mask_info_img),
                          @"id_number":kMeUnNilStr(model.id_number),
                          @"business_images":kMeUnNilStr(model.business_images),
                          @"token":kMeUnNilStr(model.token),
                          @"cellphone":kMeUnNilStr(model.cellphone)
                          };
    NSLog(@"%@",dic);
    NSString *url = kGetApiWithUrl(SSIPcommonStoreApply);
    
//#ifdef TestVersion
//    url = [@"http://test_dev.meshidai.com/api/" stringByAppendingString:SSIPcommonStoreApply];
//#else
//    url = [@"https://msd.meshidai.com/api/" stringByAppendingString:SSIPcommonStoreApply];
//#endif
    MBProgressHUD *HUD = [self commitWithHUD:@"提交中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}


+ (void)getUserGetUserWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonGetUser);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager getWithParameter:@{@"token":kMeUnNilStr(kCurrentUser.token),@"uid":kMeUnNilStr(kCurrentUser.uid)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        [kCurrentUser setterWithDict:responseObject.data];
        [kCurrentUser save];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)getUserCheckFirstBuyWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonCheckFirstBuy);
    [THTTPManager getWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
        if([responseObject.data isKindOfClass:[NSDictionary class]]){
            [[NSUserDefaults standardUserDefaults] setObject:responseObject.data[@"first_buy"]  forKey:kcheckFirstBuy];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)getUserGetTokenByFourWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPgetTokenByFour);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取token"];
    [THTTPManager getWithParameter:nil strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        [kCurrentUser setterWithDict:@{@"token":responseObject.data}];
        [kCurrentUser save];
        kNoticeUserLogin
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)getUserCentreDataWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonUserUserCentre);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取个人数据"];
    [THTTPManager getWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)getUseAllReadedInfoWithType:(NSInteger)type SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonAllreadedNotice);
    MBProgressHUD *HUD = [self commitWithHUD:@"全部已读中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)getUserUnreadNoticeWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonUnreadNotice);
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)getUserHomeUnreadNoticeWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonUnreadNotice);
    //    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        //        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
            
            //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
            
            //            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)getUserCountListWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonCountList);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
        }else{
        }
        kMeCallBlock(failure,error);
    }];
}


+ (void)getUserReadedNoticeWithNoticeId:(NSInteger)noticeId SuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          @"id":@(noticeId)
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonreadedNotice);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
        }else{
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)getAdminDistributionWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonAdminDistribution);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取数据"];
    [THTTPManager getWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postcheckStoreGetOrderStatusWithGoodSn:(NSString *)order_goods_sn successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          @"order_sn":kMeUnNilStr(order_goods_sn)
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommoncheckStoreGetOrderStatus);
    MBProgressHUD *HUD = [self commitWithHUD:@"确定提取中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)getOrderDetailWithGoodSn:(NSString *)order_goods_sn successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          @"order_sn":kMeUnNilStr(order_goods_sn)
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonUserGetOrderDetail);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取订单详情"];
    [THTTPManager getWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}


+ (void)getUserDistributionWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonUserDistribution);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取分享数据..."];
    [THTTPManager getWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)getUserGetCodeWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonUserGetCode);
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    MBProgressHUD *HUD = [self commitWithHUD:@"获取二维码"];
    [THTTPManager getWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)getUserGetEquitiesWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPcommonWebGetEquities);
    NSDictionary *dic = @{};
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}
#pragma mark - Order
//取消订单
+ (void)postDelOrderWithOrderSn:(NSString *)order_sn successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          @"order_sn":kMeUnNilStr(order_sn)
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonOrderCancelOrder);
    MBProgressHUD *HUD = [self commitWithHUD:@"取消订单..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}


+ (void)postCreateServiceOrderWithAttrModel:(SSMakeOrderAttrModel *)attrModel successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = [attrModel mj_keyValues];
    NSString *url = kGetApiWithUrl(SSIPcommonOrderConvertOrde);
    MBProgressHUD *HUD = [self commitWithHUD:@"生成订单中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        //        [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"兑换成功"];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postCreateOrderWithAttrModel:(SSMakeOrderAttrModel *)attrModel successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = [attrModel mj_keyValues];
    NSString *url = kGetApiWithUrl(SSIPcommonOrderCreateOrder);
    MBProgressHUD *HUD = [self commitWithHUD:@"生成订单中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//用户支付
+ (void)postPayOrderWithOrder_sn:(NSString *)order_sn successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"order_sn":kMeUnNilStr(order_sn),
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          @"pay_type":@"app",
                          };
    NSString *url = kGetApiWithUrl(SSIPCommonOrderPayOrder);
    MBProgressHUD *HUD = [self commitWithHUD:@"支付中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postGetLogistWithOrder_sn:(NSString *)order_sn successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"order_sn":kMeUnNilStr(order_sn),
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          };
    NSString *url = kGetApiWithUrl(SSIPCommonOrderPayOrder);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取物流中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

/***************************************/
#pragma mark - AboutUser
//用户微信登录
+ (void)postWxAuthLoginWithAttrModel:(SSWxAuthModel *)model successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = [model mj_keyValues];
    NSLog(@"%@",dic);
    NSString *url = kGetApiWithUrl(SSIPAppAuthLogin);
    MBProgressHUD *HUD = [self commitWithHUD:@"微信登录中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//获取短信验证码
+ (void)postGetCodeWithrPhone:(NSString *)phone type:(NSString *)type successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    if(!kMeUnNilStr(phone).length){
        [SSShowViewTool showMessage:@"手机号不能为空" view:kMeCurrentWindow];
        return;
        if(![SSCommonTool isValidPhoneNum:kMeUnNilStr(phone)]){
            [SSShowViewTool showMessage:@"请填写正确的手机号码" view:kMeCurrentWindow];
            return;
        }
    }
    
    NSDictionary *dic = @{@"phone":kMeUnNilStr(phone),@"type":kMeUnNilStr(type)};
    NSString *url = kGetApiWithUrl(SSIPAppGetCodel);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取验证码中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)posteditPhoneWithPhone:(NSString *)phone code:(NSString*)code new_phone:(NSString*)new_phone successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    
    if(!kMeUnNilStr(phone).length){
        [SSShowViewTool showMessage:@"手机号不能为空" view:kMeCurrentWindow];
        return;
        if(![SSCommonTool isValidPhoneNum:kMeUnNilStr(phone)]){
            [SSShowViewTool showMessage:@"请填写正确的手机号码" view:kMeCurrentWindow];
            return;
        }
    }
    
    if(!kMeUnNilStr(new_phone).length){
        [SSShowViewTool showMessage:@"新手机号不能为空" view:kMeCurrentWindow];
        return;
        if(![SSCommonTool isValidPhoneNum:kMeUnNilStr(new_phone)]){
            [SSShowViewTool showMessage:@"请填写正确的新手机号码" view:kMeCurrentWindow];
            return;
        }
    }
    
    if(!kMeUnNilStr(code).length){
        [SSShowViewTool showMessage:@"验证码不能为空" view:kMeCurrentWindow];
        return;
    }
    
    NSDictionary *dic = @{@"phone":kMeUnNilStr(phone),@"code":kMeUnNilStr(code),@"new_phone":kMeUnNilStr(new_phone),@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPeditPhone);
    MBProgressHUD *HUD = [self commitWithHUD:@"修改手机号中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postloginByPhoneWithPhone:(NSString *)phone code:(NSString*)code successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    if(!kMeUnNilStr(phone).length){
        [SSShowViewTool showMessage:@"手机号不能为空" view:kMeCurrentWindow];
        return;
        if(![SSCommonTool isValidPhoneNum:kMeUnNilStr(phone)]){
            [SSShowViewTool showMessage:@"请填写正确的手机号码" view:kMeCurrentWindow];
            return;
        }
    }
    
    if(!kMeUnNilStr(code).length){
        [SSShowViewTool showMessage:@"验证码不能为空" view:kMeCurrentWindow];
        return;
    }
    
    NSDictionary *dic = @{@"phone":kMeUnNilStr(phone),@"code":kMeUnNilStr(code)};
    NSString *url = kGetApiWithUrl(SSIPLoginByPhone);
    MBProgressHUD *HUD = [self commitWithHUD:@"登录中..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postaddPhoneWithPhone:(NSString *)phone code:(NSString*)code invate:(NSString*)invate successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    if(!kMeUnNilStr(phone).length){
        [SSShowViewTool showMessage:@"手机号不能为空" view:kMeCurrentWindow];
        return;
        if(![SSCommonTool isValidPhoneNum:kMeUnNilStr(phone)]){
            [SSShowViewTool showMessage:@"请填写正确的手机号码" view:kMeCurrentWindow];
            return;
        }
    }
    
    if(!kMeUnNilStr(code).length){
        [SSShowViewTool showMessage:@"验证码不能为空" view:kMeCurrentWindow];
        return;
    }
    
    NSDictionary *dic = @{@"phone":kMeUnNilStr(phone),@"code":kMeUnNilStr(code),@"token":kMeUnNilStr(kCurrentUser.token),@"invite_code":kMeUnNilStr(invate)};
    NSString *url = kGetApiWithUrl(SSIPaddPhone);
    MBProgressHUD *HUD = [self commitWithHUD:@"绑定手机号..."];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        if([responseObject.status_code isEqualToString:kNetInvateCode]){
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(responseObject.message)];
        }else{
            [HUD hideAnimated:YES];
        }
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postGetAPPVersionWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSIPGetAPPVersion);
    [THTTPManager postWithParameter:@{} strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}
+ (void)postGetNewAPPVersionWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSString *url = kGetApiWithUrl(SSNewIPGetAPPVersion);
    [THTTPManager postWithParameter:@{@"version":kSSAppVersion} strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}

+ (void)postAddShareWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    if([SSUserInfoModel isLogin]){
        NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token)};
        NSString *url = kGetApiWithUrl(SSIPAddShare);
        [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
            kMeCallBlock(successBlock,responseObject);
        } failure:^(id error) {
            kMeCallBlock(failure,error);
        }];
    }
}

+ (void)postExpMiniprogramAtWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"member_id":kMeUnNilStr(kCurrentUser.uid),@"token":kMeUnNilStr(kCurrentUser.token)};
    NSString *url = kGetApiWithUrl(SSIPExpMiniprogramAt);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kMeCallBlock(failure,error);
    }];
}


/***************************************/
#pragma mark - member
//获取超级会员数据 产品
+ (void)getSupportMemberWithsuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{};
    NSString *url = kGetApiWithUrl(SSIPcommonSupportMember);
    [THTTPManager getWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}

//获取超级会员数据 美豆
+ (void)postSupportMemberManyGoodsWithsuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    //4 为美豆
    NSDictionary *dic = @{@"type":@"4"};
    NSString *url = kGetApiWithUrl(SSIPcommonFindManyGoods);
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool showMessage:kMeUnNilStr(res.message) view:kMeCurrentWindow];
        }else{
            [SSShowViewTool showMessage:kApiError view:kMeCurrentWindow];
        }
        kMeCallBlock(failure,error);
    }];
}


/***************************************/


/***************************************/
#pragma mark - Store
//app 更新店铺商家信息
+ (void)postStroeFindStoreInfoWithEditModel:(SSBStoreMannagerEditModel*)model successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    if(!kMeUnNilStr(model.store_name).length){
        [SSShowViewTool showMessage:@"店铺名称不能为空" view:kMeCurrentWindow];
        return;
    }
    
    if(!kMeUnNilStr(model.mobile).length){
        [SSShowViewTool showMessage:@"店铺电话不能为空" view:kMeCurrentWindow];
        return;
    }
    if(![SSCommonTool isValidPhoneNum:kMeUnNilStr(model.mobile)]){
        [SSShowViewTool showMessage:@"请填写正确的店铺电话" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(model.id_number).length){
        [SSShowViewTool showMessage:@"身份证不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(model.intro).length){
        [SSShowViewTool showMessage:@"店铺简介不能为空" view:kMeCurrentWindow];
        return;
    }
    
    
    NSDictionary *dic = [model mj_keyValues];
    NSString *url = kGetApiWithUrl(SSIPcommonUpdateStoreInfo);
    MBProgressHUD *HUD = [self commitWithHUD:@"更新店铺信息"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"更新成功"];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//app获取店铺商家信息
+ (void)postStroeFindStoreInfoWithSuccessBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token),
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonFindStoreInfo);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取店铺信息"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//获取门店祥情
+ (void)postStroeDetailWithGoodsId:(NSInteger)storeId successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"store_id":@(storeId),
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonStoreGetStore);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

//获取服务祥情
+ (void)postServiceDetailWithServiceId:(NSInteger)serviceId successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{@"serviceId":@(serviceId),
                          };
    NSString *url = kGetApiWithUrl(SSIPcommonserviceDetail);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}


+ (void)postAppointDetailWithReserve_sn:(NSString *)reserve_sn successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          @"reserve_sn":kMeUnNilStr(reserve_sn)
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonUserGetAppointDetail);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取预约详情"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

+ (void)postReserveDetailBlWithReserve_sn:(NSString *)reserve_sn successBlock:(RequestResponse)successBlock failure:(kMeObjBlock)failure{
    NSDictionary *dic = @{
                          @"token":kMeUnNilStr(kCurrentUser.token),
                          @"reserve_sn":kMeUnNilStr(reserve_sn)
                          };
    
    NSString *url = kGetApiWithUrl(SSIPcommonreserveDetailB);
    MBProgressHUD *HUD = [self commitWithHUD:@"获取预约详情"];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        if([error isKindOfClass:[ZLRequestResponse class]]){
            ZLRequestResponse *res = (ZLRequestResponse*)error;
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kMeUnNilStr(res.message)];
        }else{
            [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        }
        kMeCallBlock(failure,error);
    }];
}

/***************************************/

#pragma mark - Help

+ (MBProgressHUD *)commitWithHUD:(NSString *)str{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kMeCurrentWindow animated:YES];
    //    UIImage *image = [UIImage sd_animatedGIFNamed:@"loading"];
    //    UIImageView *cusImageV = [[UIImageView alloc] initWithImage:image];
    //    hud.mode = MBProgressHUDModeCustomView;
    //    hud.removeFromSuperViewOnHide = YES;
    //    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //    hud.bezelView.backgroundColor = [UIColor clearColor];
    //    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    //    hud.customView = cusImageV;
    hud.label.text = str;
    //    hud.label.textColor = kSSPink;
    hud.userInteractionEnabled = YES;
    return hud;
}

@end
