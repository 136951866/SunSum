//
//  SSCoupleFilterNavView.m
//  SunSum
//
//  Created by hank on 2018/12/24.
//  Copyright © 2018 hank. All rights reserved.
//

#import "SSCoupleFilterNavView.h"

@interface SSCoupleFilterNavView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;

@end

@implementation SSCoupleFilterNavView

- (void)awakeFromNib{
    [super awakeFromNib];
    _consTopMargin.constant = kMeStatusBarHeight;
}



- (IBAction)backAction:(UIButton *)sender {
    kMeCallBlock(_backBlock);
}

- (IBAction)searchAction:(UIButton *)sender {
    kMeCallBlock(_searchBlock);
}

@end
