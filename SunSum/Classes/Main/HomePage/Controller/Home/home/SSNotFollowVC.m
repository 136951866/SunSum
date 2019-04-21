//
//  SSNotFollowVC.m
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNotFollowVC.h"
#import "SSNotFollowContentVC.h"


@interface SSNotFollowVC ()<JXCategoryViewDelegate,UIScrollViewDelegate>{
    NSArray *_arrType;
    SSOrderStyle _currentType;
}

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SSNotFollowContentVC *followsevenVC;
@property (nonatomic, strong) SSNotFollowContentVC *followhalfmonthVC;
@property (nonatomic, strong) SSNotFollowContentVC *followmonthVC;

@end

@implementation SSNotFollowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"未跟进客户";
    _arrType = @[@"7天未跟进",@"15天未跟进",@"30天未跟进"] ;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight+kCategoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *_arrType.count,  SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.followsevenVC.view];
    [self.scrollView addSubview:self.followhalfmonthVC.view];
    [self.scrollView addSubview:self.followmonthVC.view];
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

- (SSNotFollowContentVC *)followsevenVC{
    if(!_followsevenVC){
        _followsevenVC = [[SSNotFollowContentVC alloc]initWithday:7];
        _followsevenVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _followsevenVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        [self addChildViewController:_followsevenVC];
    }
    return _followsevenVC;
}

- (SSNotFollowContentVC *)followhalfmonthVC{
    if(!_followhalfmonthVC){
        _followhalfmonthVC = [[SSNotFollowContentVC alloc]initWithday:15];
        _followhalfmonthVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _followhalfmonthVC.view.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        [self addChildViewController:_followhalfmonthVC];
    }
    return _followhalfmonthVC;
}

- (SSNotFollowContentVC *)followmonthVC{
    if(!_followmonthVC){
        _followmonthVC = [[SSNotFollowContentVC alloc]initWithday:30];
        _followmonthVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _followmonthVC.view.frame = CGRectMake(SCREEN_WIDTH *2,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        [self addChildViewController:_followmonthVC];
    }
    return _followmonthVC;
}

@end
