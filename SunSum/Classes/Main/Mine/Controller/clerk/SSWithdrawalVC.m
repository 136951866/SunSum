//
//  SSWithdrawalVC.m
//  SunSum
//
//  Created by hank on 2018/12/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSWithdrawalVC.h"
#import "SSWithdrawalView.h"
#import "SSWithdrawalParamModel.h"

@interface SSWithdrawalVC ()<UIScrollViewDelegate>{
    BOOL _isCouponMoney;
}

@property (nonatomic, strong) SSWithdrawalView *cview;
@property (nonatomic, strong) UIScrollView *scrollerView;

@end

@implementation SSWithdrawalVC

- (instancetype)initWithCouponMoney{
    if(self = [super init]){
        _isCouponMoney = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请";
    self.view.backgroundColor = [UIColor colorWithHexString:@"fbfbfb"];
    [self.view addSubview:self.scrollerView];
    [self.scrollerView addSubview:self.cview];
    kMeWEAKSELF
    self.cview.applyFinishBlock = ^{
        kMeSTRONGSELF
//        kMeCallBlock(strongSelf->_applySucessBlock);
        [strongSelf.navigationController popViewControllerAnimated:YES];
    };
    // Do any additional setup after loading the view.
}

- (UIScrollView *)scrollerView{
    if(!_scrollerView){
        _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight)];
        _scrollerView.backgroundColor = [UIColor colorWithHexString:@"fbfbfb"];
        _scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, [SSWithdrawalView getViewHeight]);
        _scrollerView.bounces = YES;
        _scrollerView.showsVerticalScrollIndicator =NO;
        _scrollerView.delegate = self;
        _scrollerView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _scrollerView;
}

- (SSWithdrawalView *)cview{
    if(!_cview){
        _cview = [[[NSBundle mainBundle]loadNibNamed:@"SSWithdrawalView" owner:nil options:nil] lastObject];
        _cview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [SSWithdrawalView getViewHeight]);
        _cview.isCouponMoney = _isCouponMoney;
    }
    return _cview;
}




@end
