//
//  SSCoupleHomeNavView.m
//  SunSum
//
//  Created by hank on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCoupleHomeNavView.h"

@interface SSCoupleHomeNavView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTop;

@end

@implementation SSCoupleHomeNavView

- (void)awakeFromNib{
    [super awakeFromNib];
    _conTop.constant = kMeStatusBarHeight;
    [self layoutIfNeeded];
}

- (IBAction)backAction:(UIButton *)sender {
    kMeCallBlock(_backBlock);
}

- (IBAction)searchAction:(UIButton *)sender {
    kMeCallBlock(_searchBlock);
}


@end
