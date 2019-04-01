//
//  SSBDataDealStoreAchievementVC.m
//  SunSum
//
//  Created by hank on 2019/2/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSDataDealStoreCustomerVC.h"
#import "SSBDataDealModel.h"
#import "SSBDataDealStoreCustomerView.h"


@interface SSDataDealStoreCustomerVC ()<UIScrollViewDelegate>{
    SSBDataDealModel *_model;
}

@property (nonatomic, strong) SSBDataDealStoreCustomerView *cview;
@property (nonatomic, strong) UIScrollView *scrollerView;

@end

@implementation SSDataDealStoreCustomerVC

- (instancetype)initWithModel:(SSBDataDealModel*)model{
    if(self = [super init]){
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"门店顾客分析";
    self.view.backgroundColor = [UIColor whiteColor];//[UIColor colorWithHexString:@"fbfbfb"];
    [self.view addSubview:self.scrollerView];
    [self.scrollerView addSubview:self.cview];
    [self.cview setUIWithModel:_model];
    self.scrollerView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNetWork)];
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
        _scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, [SSBDataDealStoreCustomerView getViewHeightWithModel:_model]);
        _scrollerView.bounces = YES;
        _scrollerView.showsVerticalScrollIndicator =NO;
        _scrollerView.delegate = self;
    }
    return _scrollerView;
}

- (SSBDataDealStoreCustomerView *)cview{
    if(!_cview){
        _cview = [[[NSBundle mainBundle]loadNibNamed:@"SSBDataDealStoreCustomerView" owner:nil options:nil] lastObject];
        _cview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [SSBDataDealStoreCustomerView getViewHeightWithModel:_model]);
    }
    return _cview;
}


@end
