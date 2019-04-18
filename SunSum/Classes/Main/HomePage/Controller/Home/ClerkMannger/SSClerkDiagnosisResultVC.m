//
//  SSClerkDiagnosisResultVC.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkDiagnosisResultVC.h"
#import "SSClerkDiagnosisResultHeaderView.h"
#import "SSClerkDiagnosisResultCustomerVC.h"
#import "SSClerkDiagnosisResultClerkVC.h"
#import "SSClerkDiagnosisResultmodel.h"

@interface SSClerkDiagnosisResultVC ()<JXCategoryViewDelegate>{
    NSArray *_arrType;
    NSInteger _currentType;
    SSClerkDiagnosisResultmodel *_model;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic , strong) UIView *viewForNav;
@property (nonatomic, strong) SSClerkDiagnosisResultHeaderView *headerView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SSClerkDiagnosisResultCustomerVC *customerVC;
@property (nonatomic, strong) SSClerkDiagnosisResultClerkVC *clerkVC;
@end

@implementation SSClerkDiagnosisResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    self.view.backgroundColor = kSS171c30;
    _model = [SSClerkDiagnosisResultmodel new];
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetSSIPcommoncustomercustomerDiagnoseWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_model = [SSClerkDiagnosisResultmodel mj_objectWithKeyValues:responseObject.data];
        [strongSelf initSomethin];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)initSomethin{
    [self.view addSubview:self.viewForNav];
    [self.view addSubview:self.headerView];
    [self.headerView setUiWithModel:_model];
    [self.view addSubview:self.tableView];
    
    _arrType = @[@"客户成长转化分析图",@"员工排名"];
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,kMeNavBarHeight+kSSClerkDiagnosisResultHeaderViewHeight, SCREEN_WIDTH, kCategoryViewHeight)];
    self.categoryView.backgroundColor = kSS171c30;
    //    self.categoryView.lineStyle = JXCategoryLineStyle_None;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewHeight = 0.5;
    lineView.indicatorLineWidth = 25;
    lineView.indicatorLineViewColor = [UIColor colorWithHexString:@"#FFD0AC"];;
    self.categoryView.indicators = @[lineView];
    self.categoryView.titles = _arrType;
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor colorWithHexString:@"#FFD0AC"];
    self.categoryView.titleColor = [UIColor whiteColor];
    self.categoryView.defaultSelectedIndex = _currentType;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight+kCategoryViewHeight+kSSClerkDiagnosisResultHeaderViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kSSClerkDiagnosisResultHeaderViewHeight)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *_arrType.count, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kSSClerkDiagnosisResultHeaderViewHeight);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.categoryView.contentScrollView = self.scrollView;
    [self.scrollView addSubview:self.customerVC.view];
    [self.scrollView addSubview:self.clerkVC.view];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.categoryView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma Action--

- (void)pop:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)viewForNav{
    if(!_viewForNav){
        _viewForNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kMeNavBarHeight)];
        _viewForNav.backgroundColor = kSS171c30;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kMeStatusBarHeight, 50, kMeNavBarHeight-kMeStatusBarHeight);
        [btn setImage:[UIImage imageNamed:@"icon-rrqcdatuud"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
        [_viewForNav addSubview:btn];
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(btn.right + 14, kMeStatusBarHeight, SCREEN_WIDTH-128, kMeNavBarHeight-kMeStatusBarHeight)];
        lbl.text = @"诊断结果";
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont systemFontOfSize:20];
        lbl.textColor = [UIColor whiteColor];
        [_viewForNav addSubview:lbl];
    }
    return _viewForNav;
}

- (SSClerkDiagnosisResultHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSClerkDiagnosisResultHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, kSSClerkDiagnosisResultHeaderViewHeight);
    }
    return _headerView;
}


- (SSClerkDiagnosisResultCustomerVC *)customerVC{
    if(!_customerVC){
        _customerVC = [[SSClerkDiagnosisResultCustomerVC alloc]initWithModel:_model];
        _customerVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kSSClerkDiagnosisResultHeaderViewHeight);
        _customerVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_customerVC];
    }
    return _customerVC;
}

- (SSClerkDiagnosisResultClerkVC *)clerkVC{
    if(!_clerkVC){
        _clerkVC = [[SSClerkDiagnosisResultClerkVC alloc]init];
        _clerkVC.view.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kSSClerkDiagnosisResultHeaderViewHeight);
        _clerkVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_clerkVC];
    }
    return _clerkVC;
}

@end
