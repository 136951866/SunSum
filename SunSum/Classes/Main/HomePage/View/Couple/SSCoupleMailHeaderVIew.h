//
//  SSCoupleMailHeaderVIew.h
//  SunSum
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSCoupleModel;
@class SSPinduoduoCoupleInfoModel;
@class SSJDCoupleModel;
#define SSCoupleMailHeaderVIewHeight (SCREEN_WIDTH + 205)

@interface SSCoupleMailHeaderVIew : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
- (void)setUIWithModel:(SSCoupleModel *)model;
- (void)setPinduoduoUIWithModel:(SSPinduoduoCoupleInfoModel *)model;
@property (nonatomic ,copy)kMeBasicBlock getCoupleBlock;
- (void)setJDUIWithModel:(SSJDCoupleModel *)model;


@end
