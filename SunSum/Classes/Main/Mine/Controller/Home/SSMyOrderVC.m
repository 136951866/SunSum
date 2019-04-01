//
//  SSMyOrderVC.m
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMyOrderVC.h"
#import "SSMyOrderContentVC.h"

@interface SSMyOrderVC ()<JXCategoryViewDelegate,UIScrollViewDelegate>{
    NSArray *_arrType;
    SSOrderStyle _currentType;
}

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SSMyOrderContentVC *allVC;
@property (nonatomic, strong) SSMyOrderContentVC *needPayVC;
@property (nonatomic, strong) SSMyOrderContentVC *deliveryVC;
@property (nonatomic, strong) SSMyOrderContentVC *receivedVC;
@property (nonatomic, strong) SSMyOrderContentVC *finishVC;
@end

@implementation SSMyOrderVC

- (instancetype)initWithType:(SSOrderStyle)type{
    if(self = [super init]){
        _currentType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    _arrType = @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成"] ;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight+kCategoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *_arrType.count,  SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.allVC.view];
    [self.scrollView addSubview:self.needPayVC.view];
    [self.scrollView addSubview:self.deliveryVC.view];
    [self.scrollView addSubview:self.receivedVC.view];
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

- (SSMyOrderContentVC *)allVC{
    if(!_allVC){
        _allVC = [[SSMyOrderContentVC alloc]initWithType:0];
        _allVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _allVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        [self addChildViewController:_allVC];
    }
    return _allVC;
}

- (SSMyOrderContentVC *)needPayVC{
    if(!_needPayVC){
        _needPayVC = [[SSMyOrderContentVC alloc]initWithType:1];
        _needPayVC.view.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _needPayVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_needPayVC];
    }
    return _needPayVC;
}

- (SSMyOrderContentVC *)deliveryVC{
    if(!_deliveryVC){
        _deliveryVC = [[SSMyOrderContentVC alloc]initWithType:2];
        _deliveryVC.view.frame = CGRectMake(SCREEN_WIDTH*2,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _deliveryVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_deliveryVC];
    }
    return _deliveryVC;
}

- (SSMyOrderContentVC *)receivedVC{
    if(!_receivedVC){
        _receivedVC = [[SSMyOrderContentVC alloc]initWithType:3];
        _receivedVC.view.frame = CGRectMake(SCREEN_WIDTH*3,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _receivedVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_receivedVC];
    }
    return _receivedVC;
}

- (SSMyOrderContentVC *)finishVC{
    if(!_finishVC){
        _finishVC = [[SSMyOrderContentVC alloc]initWithType:4];
        _finishVC.view.frame = CGRectMake(SCREEN_WIDTH*4,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _finishVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_finishVC];
    }
    return _finishVC;
}

@end
