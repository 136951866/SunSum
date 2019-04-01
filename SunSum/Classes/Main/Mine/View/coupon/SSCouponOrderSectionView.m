//
//  SSCouponOrderSectionView.m
//  SunSum
//
//  Created by hank on 2019/2/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCouponOrderSectionView.h"


@interface SSCouponOrderSectionView ()

@property (weak, nonatomic) IBOutlet UIView *viewForLine;
@property (weak, nonatomic) IBOutlet UIButton *btnPinduoduo;
@property (weak, nonatomic) IBOutlet UIButton *btnJd;
@property (weak, nonatomic) IBOutlet UIView *viewForJdLine;


@end

@implementation SSCouponOrderSectionView


- (IBAction)pinduoduoAction:(UIButton *)sender {
    if(sender.selected == YES){
        return;
    }
    [self reloadUIWIthType:SSCouponOrderSectionViewPinduoduoType];
    kMeCallBlock(_selectBlock,SSCouponOrderSectionViewPinduoduoType);
}

- (IBAction)jdAction:(UIButton *)sender {
    if(sender.selected == YES){
        return;
    }
    [self reloadUIWIthType:SSCouponOrderSectionViewJDType];
    kMeCallBlock(_selectBlock,SSCouponOrderSectionViewJDType);
}

- (void)setType:(SSCouponOrderSectionViewType)type{
    _type = type;
    [self reloadUIWIthType:type];
}

- (void)reloadUIWIthType:(SSCouponOrderSectionViewType)type{
    if(type==SSCouponOrderSectionViewPinduoduoType){
        _viewForJdLine.hidden = YES;
        _viewForLine.hidden = NO;
        _btnPinduoduo.selected = YES;
        _btnJd.selected = NO;
    }else{
        _viewForJdLine.hidden = NO;
        _viewForLine.hidden = YES;
        _btnPinduoduo.selected = NO;
        _btnJd.selected = YES;
    }
}


@end
