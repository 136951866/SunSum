//
//  SSCoupleMailHeaderVIew.m
//  SunSum
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSCoupleMailHeaderVIew.h"
#import "SSCoupleModel.h"
#import "SSPinduoduoCoupleInfoModel.h"
#import "SSJDCoupleModel.h"

@interface SSCoupleMailHeaderVIew (){
    SSCoupleModel *_model;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImgHeight;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblOralPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblJuanedPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblJuan;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSubViewW;


@end

@implementation SSCoupleMailHeaderVIew

- (void)awakeFromNib{
    [super awakeFromNib];
    _consImgHeight.constant = SCREEN_WIDTH;
    _consSubViewW.constant = 100 * kMeFrameScaleX();
    
}

- (void)setUIWithModel:(SSCoupleModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.pict_url));
    _lblTitle.text = kMeUnNilStr(model.title);
    //原价
    _lblOralPrice.text =[NSString stringWithFormat:@"原价¥%@",@(kMeUnNilStr(model.zk_final_price).floatValue)];
    ////卷后价
    _lblJuanedPrice.text =[NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.truePrice).floatValue)];
    //卷价格
    _lblJuan.text =[NSString stringWithFormat:@"%@元券",kMeUnNilStr(model.couponPrice)];
    _lblTime.text =[NSString stringWithFormat:@"有效时间%@~%@",kMeUnNilStr(model.coupon_start_time),kMeUnNilStr(model.coupon_end_time)];
}

- (void)setPinduoduoUIWithModel:(SSPinduoduoCoupleInfoModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.goods_thumbnail_url));
    _lblTitle.text = kMeUnNilStr(model.goods_name);
    //原价
    _lblOralPrice.text =[NSString stringWithFormat:@"原价¥%@",[SSCommonTool changeformatterWithFen:@(model.min_group_price)]];
    ////卷后价
    _lblJuanedPrice.text =[NSString stringWithFormat:@"¥%@",[SSCommonTool changeformatterWithFen:@(model.min_group_price-model.coupon_discount)]];
    //卷价格
    _lblJuan.text =[NSString stringWithFormat:@"%@元券",[SSCommonTool changeformatterWithFen:@(model.coupon_discount)]];

    _lblTime.text =[NSString stringWithFormat:@"有效时间%@~%@",[SSTimeTool timestampSwitchTime:model.coupon_start_time  andFormatter:@"yyyy-MM-dd"],[SSTimeTool timestampSwitchTime:model.coupon_end_time andFormatter:@"yyyy-MM-dd"]];
}

- (void)setJDUIWithModel:(SSJDCoupleModel *)model{
    NSString *str = @"";
    if(kMeUnArr(model.imageInfo.imageList).count>0){
        ImageContentInfo *imageInfo = model.imageInfo.imageList[0];
        str = kMeUnNilStr(imageInfo.url);
    }
    kSDLoadImg(_imgPic, str);
    _lblTitle.text = kMeUnNilStr(model.skuName);
    //原价
    _lblOralPrice.text = [NSString stringWithFormat:@"原价¥%@",kMeUnNilStr(model.priceInfo.price)];
    CouponContentInfo *couponInfoModel = [CouponContentInfo new];
    if(kMeUnArr(model.couponInfo.couponList).count>0){
        couponInfoModel = model.couponInfo.couponList[0];
    }
    ////卷后价
    CGFloat oPrice = [kMeUnNilStr(model.priceInfo.price) floatValue];
    CGFloat dPrice = [kMeUnNilStr(couponInfoModel.discount) floatValue];
    CGFloat price =  oPrice- dPrice;
    if(price<0){
        price = 0;
    }
    NSString *strPrice = [NSString stringWithFormat:@"%.2f",price];
    _lblJuanedPrice.text =[NSString stringWithFormat:@"¥%@",strPrice];
    //卷价格
    _lblJuan.text =[NSString stringWithFormat:@"%@元券",kMeUnNilStr(couponInfoModel.discount)];
    _lblTime.text =[NSString stringWithFormat:@"有效时间%@~%@",[SSCommonTool changeTimeStrWithtime:kMeUnNilStr(couponInfoModel.useStartTime)],[SSCommonTool changeTimeStrWithtime:kMeUnNilStr(couponInfoModel.useEndTime)]];
}

- (IBAction)coupleAction:(UIButton *)sender {
    kMeCallBlock(_getCoupleBlock);
}




@end
