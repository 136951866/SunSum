//
//  SSDynamicGoodApplyStatusVC.m
//  SunSum
//
//  Created by hank on 2019/3/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSDynamicGoodApplyStatusVC.h"
#import "SSDynamicGoodApplyStatusContentVC.h"
#import "SSEnlargeTouchButton.h"
@interface SSDynamicGoodApplyStatusVC ()<JXCategoryViewDelegate,UIScrollViewDelegate>{
    NSArray *_arrType;
    SSDynamicGoodApplyStatusContentType _currentType;
}
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SSDynamicGoodApplyStatusContentVC *waitVC;
@property (nonatomic, strong) SSDynamicGoodApplyStatusContentVC *sucessVC;
@property (nonatomic, strong) SSDynamicGoodApplyStatusContentVC *failVC;
@property (strong, nonatomic) SSEnlargeTouchButton *btnRight;

@end

@implementation SSDynamicGoodApplyStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请记录";
    _arrType = @[@"待审核",@"申请成功",@"申请失败"] ;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight+kCategoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *_arrType.count,  SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.waitVC.view];
    [self.scrollView addSubview:self.sucessVC.view];
    [self.scrollView addSubview:self.failVC.view];
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self btnRight]];
    //self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * _currentType, 0);
    // Do any additional setup after loading the view.
}

#pragma mark - Setter And Getter

- (void)popBackAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (SSEnlargeTouchButton *)btnRight{
    SSEnlargeTouchButton *btnRight= [SSEnlargeTouchButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = CGRectMake(0, 0, 70, 25);
    [btnRight setImage:[UIImage imageNamed:@"inc-xz"] forState:UIControlStateNormal];
    [btnRight setTitle:@"返回" forState:UIControlStateNormal];
    btnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 26);
    btnRight.titleEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
    [btnRight setTitleColor:[UIColor colorWithHexString:@"e3e3e3"] forState:UIControlStateNormal];
    btnRight.titleLabel.font = kMeFont(15);
    [btnRight setTitleColor:kSSblack forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(popBackAction) forControlEvents:UIControlEventTouchUpInside];
    return btnRight;
}

- (SSDynamicGoodApplyStatusContentVC *)waitVC{
    if(!_waitVC){
        _waitVC = [[SSDynamicGoodApplyStatusContentVC alloc]initWithType:SSDynamicGoodApplyStatusContentWaitType];
        _waitVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _waitVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        [self addChildViewController:_waitVC];
    }
    return _waitVC;
}

- (SSDynamicGoodApplyStatusContentVC *)sucessVC{
    if(!_sucessVC){
        _sucessVC = [[SSDynamicGoodApplyStatusContentVC alloc]initWithType:SSDynamicGoodApplyStatusContentSucessType];
        _sucessVC.view.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _sucessVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_sucessVC];
    }
    return _sucessVC;
}

- (SSDynamicGoodApplyStatusContentVC *)failVC{
    if(!_failVC){
        _failVC = [[SSDynamicGoodApplyStatusContentVC alloc]initWithType:SSDynamicGoodApplyStatusContentFailType];
        _failVC.view.frame = CGRectMake(SCREEN_WIDTH*2,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _failVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_failVC];
    }
    return _failVC;
}

@end
