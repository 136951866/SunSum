//
//  SSSecondHomePageVC.m
//  SunSum
//
//  Created by hank on 2018/11/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSSecondHomePageVC.h"


@interface SSSecondHomePageVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImgBHeigth;
@property (weak, nonatomic) IBOutlet UIImageView *consTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consLMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consMMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consRMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImgHeight;


@end

@implementation SSSecondHomePageVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F1F2F6"];
    _consImgBHeigth.constant = (SCREEN_WIDTH * 1334)/750;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
