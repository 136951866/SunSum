//
//  SSHomeHeaderMenuView.m
//  SunSum
//
//  Created by hank on 2018/9/6.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSHomeHeaderMenuView.h"
#import "SSHomePageVC.h"
#import "SSActiveVC.h"

@implementation SSHomeHeaderMenuView

#pragma mark - Action

- (IBAction)collageAction:(UIButton *)sender {
    kMeAlter(@"提示", @"敬请期待");
}

- (IBAction)SecKillseconAction:(UIButton *)sender {
    kMeAlter(@"提示", @"敬请期待");
}


- (IBAction)activeAction:(UIButton *)sender {
    SSHomePageVC *home = (SSHomePageVC *)[SSCommonTool getVCWithClassWtihClassName:[SSHomePageVC class] targetResponderView:self];
    if(home){
        SSActiveVC *avc = [[SSActiveVC alloc]init];
        [home.navigationController pushViewController:avc animated:YES];
    }
}

- (IBAction)cutDownAction:(UIButton *)sender {
    kMeAlter(@"提示", @"敬请期待");
}


@end
