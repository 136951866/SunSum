//
//  SSClerkTGetTaskListVC.m
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkTGetTaskListVC.h"
#import "SSClerkTGetTaskListContentVC.h"

@interface SSClerkTGetTaskListVC ()<JXCategoryViewDelegate,UIScrollViewDelegate>{
    NSArray *_arrType;
    SSOrderStyle _currentType;
}

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SSClerkTGetTaskListContentVC *finishVC;
@property (nonatomic, strong) SSClerkTGetTaskListContentVC *notfinishVC;

@end

@implementation SSClerkTGetTaskListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务记录";
    _arrType = @[@"已完成",@"未完成"] ;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight+kCategoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *_arrType.count,  SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.finishVC.view];
    [self.scrollView addSubview:self.notfinishVC.view];
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
}

#pragma mark - Setter And Getter

- (SSClerkTGetTaskListContentVC *)finishVC{
    if(!_finishVC){
        _finishVC = [[SSClerkTGetTaskListContentVC alloc]initWithType:2];
        _finishVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _finishVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        [self addChildViewController:_finishVC];
    }
    return _finishVC;
}

- (SSClerkTGetTaskListContentVC *)notfinishVC{
    if(!_notfinishVC){
        _notfinishVC = [[SSClerkTGetTaskListContentVC alloc]initWithType:1];
        _notfinishVC.view.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _notfinishVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_notfinishVC];
    }
    return _notfinishVC;
}


@end
