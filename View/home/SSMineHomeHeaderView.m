//
//  SSMineHomeHeaderView.m
//  SunSum
//
//  Created by Hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMineHomeHeaderView.h"
#import "SSMyOrderVC.h"
#import "SSMidelButton.h"
#import "SSMineHomeVC.h"
#import "SSMineSetVC.h"


@interface SSMineHomeHeaderView()

@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btnAddPhone;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblNamWdith;
@property (weak, nonatomic) IBOutlet UIButton *btnSet;
@property (weak, nonatomic) IBOutlet UIButton *btnAllOrder;
@property (weak, nonatomic) IBOutlet UILabel *lblLevel;

@end

@implementation SSMineHomeHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    [_viewLine addBottedlineWidth:1 lineColor:[UIColor whiteColor]];
//    _lblLevel.hidden = YES;
//    _btnAddPhone.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
//    _btnAddPhone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

- (void)reloadUIWithUserInfo{
    [_btnSet setContentMode:UIViewContentModeRight];
    [_btnAllOrder setContentMode:UIViewContentModeRight];
    _lblName.text = kMeUnNilStr(kCurrentUser.name);
    kSDLoadImg(_imgPic, kMeUnNilStr(kCurrentUser.header_pic));
    if(kMeUnNilStr(kCurrentUser.mobile).length){
        _btnAddPhone.hidden = YES;
        _lblNamWdith.constant = SCREEN_WIDTH - (26 + 90 + 26 +15);
        _lblLevel.text = [NSString stringWithFormat:@"手机:%@",kMeUnNilStr(kCurrentUser.mobile)];
//        switch (kCurrentUser.user_type) {
//            case 1:{
//                //C
//                _lblLevel.text =@"售后中心";
//            }
//                break;
//            case 2:{
//                //C
//                _lblLevel.text =@"营销中心";
//            }
//                break;
//            case 4:{
//                //C
//                _lblLevel.text =@"普通会员";
//            }
//                break;
//            case 3:{
//                //B
//                _lblLevel.text =@"体验店";
//            }
//                break;
//            case 5:{
//                //clerk
//                _lblLevel.text =@"店员";
//            }
//                break;
//            default:{
//                _lblLevel.text =@"未知身份";
//            }
//                break;
//        }
    }else{
        _btnAddPhone.hidden = NO;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
        CGSize size = [kMeUnNilStr(kCurrentUser.name) boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        _lblNamWdith.constant = size.width >63?65:(size.width + 5);
    }
}

- (void)clearUIWithUserInfo{
    _lblName.text = @"";
    _lblLevel.text = @"";
    kSDLoadImg(_imgPic, @"");
    _btnAddPhone.hidden = YES;
}

- (IBAction)allOrderAction:(UIButton *)sender {
    SSMineHomeVC *home = (SSMineHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSMineHomeVC class] targetResponderView:self];
    SSMyOrderVC *orderVC = [[SSMyOrderVC alloc]initWithType:SSAllOrder];
    if(home){
        [home.navigationController pushViewController:orderVC animated:YES];
    }
}

- (IBAction)needPayAction:(SSMidelBigImageButton *)sender {
    SSMineHomeVC *home = (SSMineHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSMineHomeVC class] targetResponderView:self];
    SSMyOrderVC *orderVC = [[SSMyOrderVC alloc]initWithType:SSAllNeedPayOrder];
    if(home){
        [home.navigationController pushViewController:orderVC animated:YES];
    }
}

- (IBAction)diveryAction:(SSMidelBigImageButton *)sender {
    SSMineHomeVC *home = (SSMineHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSMineHomeVC class] targetResponderView:self];
    SSMyOrderVC *orderVC = [[SSMyOrderVC alloc]initWithType:SSAllNeedDeliveryOrder];
    if(home){
        [home.navigationController pushViewController:orderVC animated:YES];
    }
}
- (IBAction)reviceAction:(SSMidelBigImageButton *)sender {
    SSMineHomeVC *home = (SSMineHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSMineHomeVC class] targetResponderView:self];
    SSMyOrderVC *orderVC = [[SSMyOrderVC alloc]initWithType:SSAllNeedReceivedOrder];
    if(home){
        [home.navigationController pushViewController:orderVC animated:YES];
    }
}
- (IBAction)finishAction:(SSMidelBigImageButton *)sender {
    SSMineHomeVC *home = (SSMineHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSMineHomeVC class] targetResponderView:self];
    SSMyOrderVC *orderVC = [[SSMyOrderVC alloc]initWithType:SSAllFinishOrder];
    if(home){
        [home.navigationController pushViewController:orderVC animated:YES];
    }
}

- (IBAction)setAction:(UIButton *)sender {
    SSMineHomeVC *home = (SSMineHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSMineHomeVC class] targetResponderView:self];
    SSMineSetVC *setVC = [[SSMineSetVC alloc]init];
    setVC.exitBlock = ^{
        home.tabBarController.selectedIndex = 0;
    };
    if(home){
        [home.navigationController pushViewController:setVC animated:YES];
    }
}

- (IBAction)addPhoneAction:(UIButton *)sender {
    kMeCallBlock(_addPhoneBlock);
}


@end
