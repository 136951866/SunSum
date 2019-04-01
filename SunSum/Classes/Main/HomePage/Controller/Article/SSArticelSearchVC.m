//
//  SSArticelSearchVC.m
//  SunSum
//
//  Created by hank on 2018/11/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSArticelSearchVC.h"

@interface SSArticelSearchVC ()

@end

@implementation SSArticelSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
//    self.navigationController.navigationBar.tintColor  = [UIColor whiteColor];
//}

- (void)dealloc{
    NSLog(@"dealloc");
}

@end
