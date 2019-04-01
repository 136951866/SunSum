//
//  SSGetCaseMainSVC.m
//  SunSum
//
//  Created by hank on 2018/12/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSGetCaseMainSVC.h"
#import "SSGetCaseMainVC.h"

@interface SSGetCaseMainSVC ()<JXCategoryViewDelegate,UIScrollViewDelegate>{
    NSArray *_arrType;
    SSGetCaseStyle _currentType;
}

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SSGetCaseMainVC *allVC;
@property (nonatomic, strong) SSGetCaseMainVC *getCaseIngVC;
@property (nonatomic, strong) SSGetCaseMainVC *GetCaseedVC;
@property (nonatomic, strong) SSGetCaseMainVC *notGetCaseVC;
@property (nonatomic, strong) SSGetCaseMainVC *payedGetCaseVC;

@end

@implementation SSGetCaseMainSVC

- (instancetype)initWithType:(SSGetCaseStyle)type{
    if(self = [super init]){
        _currentType = type;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    _arrType = MSSGetCaseStyleTitle;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight+kCategoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *_arrType.count,  SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.allVC.view];
    [self.scrollView addSubview:self.getCaseIngVC.view];
    [self.scrollView addSubview:self.GetCaseedVC.view];
    [self.scrollView addSubview:self.notGetCaseVC.view];
    [self.scrollView addSubview:self.payedGetCaseVC.view];
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

#pragma mark - Setter And Getter

- (SSGetCaseMainVC *)allVC{
    if(!_allVC){
        _allVC = [[SSGetCaseMainVC alloc]initWithType:SSGetCaseAllStyle];
        _allVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _allVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        [self addChildViewController:_allVC];
    }
    return _allVC;
}

- (SSGetCaseMainVC *)getCaseIngVC{
    if(!_getCaseIngVC){
        _getCaseIngVC = [[SSGetCaseMainVC alloc]initWithType:SSGetCaseingStyle];
        _getCaseIngVC.view.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _getCaseIngVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_getCaseIngVC];
    }
    return _getCaseIngVC;
}

- (SSGetCaseMainVC *)GetCaseedVC{
    if(!_GetCaseedVC){
        _GetCaseedVC = [[SSGetCaseMainVC alloc]initWithType:SSGetCaseedStyle];
        _GetCaseedVC.view.frame = CGRectMake(SCREEN_WIDTH*2,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _GetCaseedVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_GetCaseedVC];
    }
    return _GetCaseedVC;
}

- (SSGetCaseMainVC *)notGetCaseVC{
    if(!_notGetCaseVC){
        _notGetCaseVC = [[SSGetCaseMainVC alloc]initWithType:SSGetCasenotStyle];
        _notGetCaseVC.view.frame = CGRectMake(SCREEN_WIDTH*3,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _notGetCaseVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_notGetCaseVC];
    }
    return _notGetCaseVC;
}

- (SSGetCaseMainVC *)payedGetCaseVC{
    if(!_payedGetCaseVC){
        _payedGetCaseVC = [[SSGetCaseMainVC alloc]initWithType:SSGetCasePayEdStyle];
        _payedGetCaseVC.view.frame = CGRectMake(SCREEN_WIDTH*4,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _payedGetCaseVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_payedGetCaseVC];
    }
    return _payedGetCaseVC;
}

@end
