//
//  SSHomeSearchView.m
//  SunSum
//
//  Created by hank on 2018/11/1.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSHomeSearchView.h"
#import "SSMidelButton.h"

@interface SSHomeSearchView ()

@property (weak, nonatomic) IBOutlet UIView *viewForSearch;

@end

@implementation SSHomeSearchView

- (void)awakeFromNib{
    [super awakeFromNib];
    _viewForSearch.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tuchSearchView:)];
    [_viewForSearch addGestureRecognizer:ges];
}

- (void)tuchSearchView:(UITapGestureRecognizer *)ges{
    kMeCallBlock(_searchBlock);
}

- (IBAction)filtAction:(SSMidelButton *)sender {
    kMeCallBlock(_filetBlock);
}


@end
