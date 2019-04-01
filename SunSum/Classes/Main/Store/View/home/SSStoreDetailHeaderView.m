//
//  SSStoreDetailHeaderView.m
//  SunSum
//
//  Created by hank on 2018/10/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSStoreDetailHeaderView.h"
#import "SSStoreDetailModel.h"

@interface SSStoreDetailHeaderView (){
    SSStoreDetailModel *_model;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnTel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImgHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consAddressHeight;

@end

@implementation SSStoreDetailHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
//    _lblAddress.adjustsFontSizeToFitWidth = YES;
    _consImgHeight.constant = (220 * kMeFrameScaleX());
    
//    _btnTel.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setUIWithModel:(SSStoreDetailModel *)model{
    _model = model;
    kSDLoadImg(_imgPic, SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.mask_info_img)));
    _lblTitle.text = kMeUnNilStr(model.store_name);
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",kMeUnNilStr(model.province),kMeUnNilStr(model.city),kMeUnNilStr(model.district),kMeUnNilStr(model.address)];
    CGFloat addressHeight = [NSAttributedString heightForAtsWithStr:address font:[UIFont systemFontOfSize:12] width:(SCREEN_WIDTH - 30) lineH:0 maxLine:0];
    _consAddressHeight.constant = addressHeight>15?addressHeight:15;
//    _lblAddress.text = address;
     [_lblAddress setAtsWithStr:address lineGap:0];
    if(kMeUnNilStr(_model.mobile).length){
        [_btnTel setTitle:kMeUnNilStr(_model.mobile) forState:UIControlStateNormal];
    }else{
        [_btnTel setTitle:kMeUnNilStr(_model.cellphone) forState:UIControlStateNormal];
    }
}
- (IBAction)callAction:(UIButton *)sender {
    if(kMeUnNilStr(_model.mobile).length){
        [SSCommonTool showWithTellPhone:kMeUnNilStr(_model.mobile) inView:kMeCurrentWindow];
    }else{
        [SSCommonTool showWithTellPhone:kMeUnNilStr(_model.cellphone) inView:kMeCurrentWindow];
    }
}

+ (CGFloat)getViewHeight:(SSStoreDetailModel *)model{
    CGFloat height = kSSStoreDetailHeaderViewHeight;
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",kMeUnNilStr(model.province),kMeUnNilStr(model.city),kMeUnNilStr(model.district),kMeUnNilStr(model.address)];
    CGFloat addressHeight = [NSAttributedString heightForAtsWithStr:address font:[UIFont systemFontOfSize:12] width:(SCREEN_WIDTH - 30) lineH:0 maxLine:0];
    if(addressHeight>15){
        height  =  height-15+addressHeight;
        return height;
    }
    return height;
}

@end
