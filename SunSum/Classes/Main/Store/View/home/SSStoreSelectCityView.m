//
//  SSStoreSelectCityView.m
//  SunSum
//
//  Created by gao lei on 2018/9/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSStoreSelectCityView.h"
#import "SSLocationCLLModel.h"

@interface SSStoreSelectCityView(){
    //    NSString *_currentAddress;
    SSLocationCLLModel *_lllModel;
}

@property (weak, nonatomic) IBOutlet UILabel *lblCurCity;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consAddressWdith;


@end

@implementation SSStoreSelectCityView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _lllModel = [[SSLocationHelper sharedHander] getLocationModel];
    //_currentAddress = [SSLocationTool setInfoWithLocation:[[SSLocationTool sharedHander] getLocation]];
    _lblCurCity.text = kMeUnNilStr(_lllModel.city);
    //CGFloat w =  [NSString getWidthWithText:kMeUnNilStr(_currentAddress) height:20 font:16];
    //_consAddressWdith.constant = w>SCREEN_WIDTH/2?SCREEN_WIDTH/2:w;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [self addGestureRecognizer:ges];
    _lblCurCity.adjustsFontSizeToFitWidth = YES;
}

- (void)tapView:(UITapGestureRecognizer *)ges{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
//    [[SSLocationTool sharedHander] startLocation];
    kMeWEAKSELF
    [[SSLocationHelper sharedHander] getCurrentLocation:^(CLLocation *location, CLPlacemark *placeMark, NSString *error) {
        kMeSTRONGSELF
        strongSelf->_lllModel = [[SSLocationHelper sharedHander] getLocationModel];
        strongSelf->_lblCurCity.text = kMeUnNilStr(strongSelf->_lllModel.city);
        kMeCallBlock(strongSelf->_locationBlock,strongSelf->_lllModel);
        [MBProgressHUD hideHUDForView:strongSelf];
    } failure:^{
        kMeSTRONGSELF
        strongSelf->_lblCurCity.text = @"定位失败";
        [MBProgressHUD hideHUDForView:strongSelf];
    }];
}

@end
