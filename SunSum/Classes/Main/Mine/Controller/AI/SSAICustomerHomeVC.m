//
//  SSAICustomerHomeVC.m
//  SS时代
//
//  Created by hank on 2019/4/10.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAICustomerHomeVC.h"
#import "SSAICustomerHomeContentVC.h"
#import "SSAICustomerHomeHeaderSearchView.h"
#import "SSAICustomerSearchVC.h"
#import "SSNavigationVC.h"
#import "SSAICustomerSearchDataVC.h"

@interface SSAICustomerHomeVC ()<JXCategoryViewDelegate,UIScrollViewDelegate>{
    NSArray *_arrType;
    SSAICustomerHomeContentVCType _currentType;
    
}
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) SSAICustomerHomeContentVC *addtimeVC;
@property (nonatomic, strong) SSAICustomerHomeContentVC *flowtimeVC;
@property (nonatomic, strong) SSAICustomerHomeContentVC *activetimeC;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SSAICustomerHomeHeaderSearchView *headerView;

@end

@implementation SSAICustomerHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _arrType = @[@"加入时间",@"跟进时间",@"活跃时间"];
    _currentType = 0;
    [self.view addSubview:self.headerView];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight+kCategoryViewHeight+kSSAICustomerHomeHeaderSearchViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kMeTabBarHeight-kSSAICustomerHomeHeaderSearchViewHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *_arrType.count,  SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kMeTabBarHeight-kSSAICustomerHomeHeaderSearchViewHeight);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.addtimeVC.view];
    [self.scrollView addSubview:self.flowtimeVC.view];
    [self.scrollView addSubview:self.activetimeC.view];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    //1、初始化JXCategoryTitleView
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,kMeNavBarHeight+kSSAICustomerHomeHeaderSearchViewHeight, SCREEN_WIDTH, kCategoryViewHeight)];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    
    
//    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
//    lineView.indicatorLineWidth = 40;
//    lineView.indicatorLineViewColor = kSS333333;
//    lineView.indicatorLineViewHeight = 2;
    self.categoryView.indicators = @[];
    
    self.categoryView.titles = _arrType;
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor colorWithHexString:@"55ba14"];
    self.categoryView.titleColor = kSS333333;
    self.categoryView.contentScrollView = self.scrollView;
    [self.view addSubview:self.categoryView];
    self.categoryView.defaultSelectedIndex = _currentType;
    
}


- (void)toSearchData{
    kMeWEAKSELF
    SSAICustomerSearchVC *searchViewController = [SSAICustomerSearchVC searchViewControllerWithHotSearches:@[] searchBarPlaceholder:@"搜索客户" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        kMeSTRONGSELF
        SSAICustomerSearchDataVC *dataVC = [[SSAICustomerSearchDataVC alloc]initWithKey:searchText type:strongSelf->_currentType];
        [searchViewController.navigationController pushViewController:dataVC animated:YES];
    }];
    [searchViewController setSearchHistoriesCachePath:kSSSSAICustomerSearchVCHistoriesCachePath];
    SSNavigationVC *nav = [[SSNavigationVC alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}

- (SSAICustomerHomeContentVC *)addtimeVC{
    if(!_addtimeVC){
        _addtimeVC = [[SSAICustomerHomeContentVC alloc]initWithType:0];
        _addtimeVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _addtimeVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kMeTabBarHeight-kSSAICustomerHomeHeaderSearchViewHeight);
        [self addChildViewController:_addtimeVC];
    }
    return _addtimeVC;
}

- (SSAICustomerHomeContentVC *)flowtimeVC{
    if(!_flowtimeVC){
        _flowtimeVC = [[SSAICustomerHomeContentVC alloc]initWithType:1];
        _flowtimeVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _flowtimeVC.view.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kMeTabBarHeight-kSSAICustomerHomeHeaderSearchViewHeight);
        [self addChildViewController:_flowtimeVC];
    }
    return _flowtimeVC;
}

- (SSAICustomerHomeContentVC *)activetimeC{
    if(!_activetimeC){
        _activetimeC = [[SSAICustomerHomeContentVC alloc]initWithType:2];
        _activetimeC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _activetimeC.view.frame = CGRectMake(SCREEN_WIDTH*2,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kMeTabBarHeight-kSSAICustomerHomeHeaderSearchViewHeight);
        [self addChildViewController:_activetimeC];
    }
    return _activetimeC;
}

- (SSAICustomerHomeHeaderSearchView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSAICustomerHomeHeaderSearchView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, kSSAICustomerHomeHeaderSearchViewHeight);
        kMeWEAKSELF
        _headerView.touchBlock = ^{
            kMeSTRONGSELF
            strongSelf->_currentType = strongSelf.categoryView.selectedIndex;
            [strongSelf toSearchData];
        };
    }
    return _headerView;
}
@end
