//
//  SSBDataDealModel.h
//  Sumsum
//
//  Created by hank on 2018/12/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

@interface  SSBDataDealmemberModel: SSBaseModel

@property (nonatomic, assign) NSInteger  man;
@property (nonatomic, assign) NSInteger  privary;
@property (nonatomic, strong) NSString * today_new_member;
@property (nonatomic, strong) NSString * total;
@property (nonatomic, assign) NSInteger women;

@end

@interface SSBDataDealgoodsModel : SSBaseModel
@property (nonatomic, assign) NSInteger  man_sales;
@property (nonatomic, assign) NSInteger  privary_sales;
@property (nonatomic, strong) NSString * total_sales;
@property (nonatomic, assign) NSInteger  women_sales;
@end

@interface  SSBDataDealbrokerageModel: SSBaseModel
@property (nonatomic, assign) CGFloat  can_use_brokerage;
@property (nonatomic, assign) CGFloat settle_accounts_ok;
@property (nonatomic, assign) CGFloat settle_accounts_no;
@property (nonatomic, assign) CGFloat today_brokerage;
@end

@interface SSBDataDealorderModel : SSBaseModel
@property (nonatomic, strong) NSString * total_order_count;
@property (nonatomic, strong) NSString * today_order_count;
@end


@interface SSBDataDealBusinessModel : SSBaseModel
@property (nonatomic, strong) NSString * follow;
@property (nonatomic, assign) CGFloat  reserveDealPercent;
@property (nonatomic, strong) NSString * reserveMounth;
@property (nonatomic, strong) NSString * achievementMounth;
@property (nonatomic, assign) CGFloat achievementPercent;
@end

@interface SSBDataDealmarketingModel : SSBaseModel
@property (nonatomic, strong) NSString * totalPeople;
@property (nonatomic, strong) NSString * totalDeal;
@end

@interface SSBDataDealstoreProject : SSBaseModel
@property (nonatomic, strong) NSString * dealPeoplePercent;
@property (nonatomic, assign) CGFloat allProjectPercent;
@property (nonatomic, assign) CGFloat nomalProjectPercent;
@property (nonatomic, assign) CGFloat promotionProjectPercent;

@end



@interface SSBDataDealAchievementCatagery: SSBaseModel

@property (nonatomic, assign) CGFloat  percent;
@property (nonatomic, strong) NSString * category_name;
@property (nonatomic, strong) NSString * order_goods_status_name;

@end

@interface SSBDataDealAchievementMember: SSBaseModel

@property (nonatomic, assign) NSInteger  old;
@property (nonatomic, assign) NSInteger  people;
//@property (nonatomic, strong) NSString * newPeople;
@property (nonatomic, assign) NSInteger  active;

@end


@interface SSBDataDealStoreAchievement: SSBaseModel

@property (nonatomic, strong) NSArray *AchievementCatagery;//品类业务结构
@property (nonatomic, strong) NSString *AchievementMouth;//月销售额
@property (nonatomic, strong) SSBDataDealAchievementMember *AchievementMember;//顾客业绩结构
@end

@interface SSBDataDealGoodsNum: SSBaseModel
@property (nonatomic, assign) CGFloat count;
@property (nonatomic, strong) NSString *product_name;
@property (nonatomic, strong) NSString *order_goods_status_name;
@end

@interface SSBDataDealAge: SSBaseModel
@property (nonatomic, assign) CGFloat one;
@property (nonatomic, assign) CGFloat two;
@property (nonatomic, assign) CGFloat three;
@property (nonatomic, assign) CGFloat five;
@end

@interface SSBDataDealageAccessStr: SSBaseModel

@property (nonatomic, assign) CGFloat small_software;
@property (nonatomic, assign) CGFloat app;
@end

@interface SSBDataDealageAccess: SSBaseModel

@property (nonatomic, strong) SSBDataDealAge *small_software;
@property (nonatomic, strong) SSBDataDealAge *app;
@end

@interface SSBDataDealstoreCustomer: SSBaseModel

//app small_software
@property (nonatomic, strong) SSBDataDealageAccessStr *AccessTimes;
@property (nonatomic, strong) NSString *spendAmount;//消费额
@property (nonatomic, strong) NSString *spendTimes;//消费
@property (nonatomic, strong) NSString *spendMax;//消费额
//app small_software
@property (nonatomic, strong) SSBDataDealageAccessStr *AccessTimesByMouth;//月均到店次数和标准值
@property (nonatomic, strong) NSArray *GoodsNum;
@property (nonatomic, strong) SSBDataDealAge *ageFramework;//年龄结构分析
@property (nonatomic, strong) SSBDataDealAge *ageCost;//年龄消费分析
@property (nonatomic, strong) SSBDataDealageAccess *ageAccess;//不同年龄到店
@property (nonatomic, strong) SSBDataDealAge *ageAverageCost;//年龄人均消费
@property (nonatomic, strong) SSBDataDealAge *newsAge;//新客年龄结构

@property (nonatomic, strong) NSString *newsDealTimes;//新客成交
@property (nonatomic, strong) NSString *newsDealAmount;//新客消费
@end




@interface SSBDataDealModel : SSBaseModel

@property (nonatomic, strong) SSBDataDealbrokerageModel * brokerage;
@property (nonatomic, strong) SSBDataDealgoodsModel * goods;
@property (nonatomic, strong) SSBDataDealmemberModel * member;
@property (nonatomic, strong) SSBDataDealorderModel * order;

@property (nonatomic, strong) SSBDataDealBusinessModel * business;
@property (nonatomic, strong) SSBDataDealmarketingModel * marketing;
@property (nonatomic, strong) SSBDataDealstoreProject * storeProject;
@property (nonatomic, strong) SSBDataDealStoreAchievement *storeAchievement;

@property (nonatomic, strong) SSBDataDealstoreCustomer *storeCustomer;
@end
