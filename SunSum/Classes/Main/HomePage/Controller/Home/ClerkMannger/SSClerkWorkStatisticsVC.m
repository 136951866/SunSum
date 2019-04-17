//
//  SSClerkWorkStatisticsVC.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkWorkStatisticsVC.h"
#import "SSClerkWorkStatisticsServerLogVC.h"
#import "SSClerkWorkStatisticsCustomerVistVC.h"

@interface SSClerkWorkStatisticsVC ()<JXCategoryViewDelegate,UIScrollViewDelegate>{
    NSArray *_arrType;
    NSInteger _currentType;
}
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SSClerkWorkStatisticsServerLogVC *serverLogVC;
@property (nonatomic, strong) SSClerkWorkStatisticsCustomerVistVC *cusomerVisitVC;

@end

@implementation SSClerkWorkStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作统计";
    _currentType = 0;
    _arrType = @[@"服务日志",@"顾客回访"];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight+kCategoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *_arrType.count,  SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.serverLogVC.view];
    [self.scrollView addSubview:self.cusomerVisitVC.view];
    [self.view addSubview:self.scrollView];
    
    //1、初始化JXCategoryTitleView
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, kCategoryViewHeight)];
    //    self.categoryView.lineStyle = JXCategoryLineStyle_None;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = kSSPink;
    self.categoryView.indicators = @[lineView];
    self.categoryView.titles = _arrType;
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = kSSPink;
    self.categoryView.contentScrollView = self.scrollView;
    [self.view addSubview:self.categoryView];
    self.categoryView.defaultSelectedIndex = _currentType;
}

- (SSClerkWorkStatisticsServerLogVC *)serverLogVC{
    if(!_serverLogVC){
        _serverLogVC = [[SSClerkWorkStatisticsServerLogVC alloc]init];
        _serverLogVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _serverLogVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        [self addChildViewController:_serverLogVC];
    }
    return _serverLogVC;
}

- (SSClerkWorkStatisticsCustomerVistVC *)cusomerVisitVC{
    if(!_cusomerVisitVC){
        _cusomerVisitVC = [[SSClerkWorkStatisticsCustomerVistVC alloc]init];
        _cusomerVisitVC.view.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _cusomerVisitVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_cusomerVisitVC];
    }
    return _cusomerVisitVC;
}

@end
