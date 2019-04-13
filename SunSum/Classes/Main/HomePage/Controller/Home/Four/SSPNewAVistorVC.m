//
//  SSPNewAVistorVC.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSPNewAVistorVC.h"
#import "SSPNewAVistorContentVC.h"

@interface SSPNewAVistorVC ()<JXCategoryViewDelegate,UIScrollViewDelegate>
{
    NSArray *_arrType;

}
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SSPNewAVistorContentVC *posterVC;
@property (nonatomic, strong) SSPNewAVistorContentVC *articleVC;

@end

@implementation SSPNewAVistorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"获客图文";
    _arrType = @[@"获客海报",@"获客文章"] ;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight+kCategoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *_arrType.count,  SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.posterVC.view];
    [self.scrollView addSubview:self.articleVC.view];
    
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
    //self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * _currentType, 0);
    // Do any additional setup after loading the view.
}

#pragma mark - Setter And Getter

- (SSPNewAVistorContentVC *)posterVC{
    if(!_posterVC){
        _posterVC = [[SSPNewAVistorContentVC alloc]init];
        _posterVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _posterVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        [self addChildViewController:_posterVC];
    }
    return _posterVC;
}

- (SSPNewAVistorContentVC *)articleVC{
    if(!_articleVC){
        _articleVC = [[SSPNewAVistorContentVC alloc]init];
        _articleVC.view.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight);
        _articleVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addChildViewController:_articleVC];
    }
    return _articleVC;
}

@end
