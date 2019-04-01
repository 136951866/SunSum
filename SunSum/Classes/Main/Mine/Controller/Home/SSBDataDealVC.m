//
//  SSBDataDealVC.m
//  SunSum
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBDataDealVC.h"
//#import "SSBDataDealView.h"
#import "SSBDataDealModel.h"
#import "SSBNewDataDealView.h"
#import "SSBDataDealStoreAchievementVC.h"
#import "SSDataDealStoreCustomerVC.h"

@interface SSBDataDealVC ()<UIScrollViewDelegate>{
    SSBDataDealModel *_model;
}

@property (nonatomic, strong) SSBNewDataDealView *cview;
@property (nonatomic, strong) UIScrollView *scrollerView;

@end

@implementation SSBDataDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"数据统计";
    self.view.backgroundColor = [UIColor whiteColor];//[UIColor colorWithHexString:@"fbfbfb"];
    [self.view addSubview:self.scrollerView];
    [self.scrollerView addSubview:self.cview];
    self.scrollerView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNetWork)];
    [self.scrollerView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)requestNetWork{
    kMeWEAKSELF
    [SSPublicNetWorkTool postGetBstatisticsWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        if(![responseObject.data isKindOfClass:[NSDictionary class]]){
            [strongSelf.scrollerView.mj_header endRefreshing];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
        strongSelf->_model = [SSBDataDealModel mj_objectWithKeyValues:responseObject.data ];
        [strongSelf.cview setUIWithModel:strongSelf->_model];
        [strongSelf.scrollerView.mj_header endRefreshing];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.scrollerView.mj_header endRefreshing];
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (UIScrollView *)scrollerView{
    if(!_scrollerView){
        _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight)];
        _scrollerView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithHexString:@"fbfbfb"];
        _scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, kSSBNewDataDealViewHeight);
        _scrollerView.bounces = YES;
        _scrollerView.showsVerticalScrollIndicator =NO;
        _scrollerView.delegate = self;
    }
    return _scrollerView;
}

- (SSBNewDataDealView *)cview{
    if(!_cview){
        _cview = [[[NSBundle mainBundle]loadNibNamed:@"SSBNewDataDealView" owner:nil options:nil] lastObject];
        _cview.frame = CGRectMake(0, 0, SCREEN_WIDTH, kSSBNewDataDealViewHeight);
        kMeWEAKSELF
        _cview.StructBlock = ^{
            kMeSTRONGSELF
            if(strongSelf->_model){
                SSBDataDealStoreAchievementVC *vc = [[SSBDataDealStoreAchievementVC alloc]initWithModel:strongSelf->_model];
                [strongSelf.navigationController pushViewController:vc animated:YES];
            }
        };
        _cview.storeCustomer = ^{
            kMeSTRONGSELF
            SSDataDealStoreCustomerVC *vc = [[SSDataDealStoreCustomerVC alloc]initWithModel:strongSelf->_model];
            [strongSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _cview;
}

@end
