//
//  SSDistributionOrderVC.m
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSDistributionOrderVC.h"
#import "SSDistributionOrderContentVC.h"

@interface SSDistributionOrderVC ()<JXCategoryViewDelegate,UIScrollViewDelegate>{
    NSArray *_arrType;
    SSDistrbutionOrderStyle _currentType;
}

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SSDistributionOrderContentVC *allVC;
@property (nonatomic, strong) SSDistributionOrderContentVC *needPayVC;
@property (nonatomic, strong) SSDistributionOrderContentVC *needPayedVC;
@property (nonatomic, strong) SSDistributionOrderContentVC *finishVC;

@end

@implementation SSDistributionOrderVC

- (instancetype)initWithType:(SSDistrbutionOrderStyle)type{
    if(self = [super init]){
        _currentType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    _arrType = @[@"全部",@"待付款",@"已打款",@"已完成"];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight+kCategoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *_arrType.count,  SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.allVC.view];
    [self.scrollView addSubview:self.needPayVC.view];
    [self.scrollView addSubview:self.needPayedVC.view];
    [self.scrollView addSubview:self.finishVC.view];
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
    //self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * _currentType, 0);
    // Do any additional setup after loading the view.
}

#pragma mark - Setter And Getter

- (SSDistributionOrderContentVC *)allVC{
    if(!_allVC){
        _allVC = [[SSDistributionOrderContentVC alloc]initWithType:0];
        _allVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _allVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        [self addChildViewController:_allVC];
    }
    return _allVC;
}

- (SSDistributionOrderContentVC *)needPayVC{
    if(!_needPayVC){
        _needPayVC = [[SSDistributionOrderContentVC alloc]initWithType:1];
        _needPayVC.view.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _needPayVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_needPayVC];
    }
    return _needPayVC;
}

- (SSDistributionOrderContentVC *)needPayedVC{
    if(!_needPayedVC){
        _needPayedVC = [[SSDistributionOrderContentVC alloc]initWithType:2];
        _needPayedVC.view.frame = CGRectMake(SCREEN_WIDTH*2,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _needPayedVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_needPayedVC];
    }
    return _needPayedVC;
}

- (SSDistributionOrderContentVC *)finishVC{
    if(!_finishVC){
        _finishVC = [[SSDistributionOrderContentVC alloc]initWithType:3];
        _finishVC.view.frame = CGRectMake(SCREEN_WIDTH*3,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _finishVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_finishVC];
    }
    return _finishVC;
}



@end
