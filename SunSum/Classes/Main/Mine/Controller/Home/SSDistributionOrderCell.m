//
//  SSDistributionOrderCell.m
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSDistributionOrderCell.h"
#import "SSDistributionOrderCell.h"
#import "SSDistrbutionOrderModel.h"

@interface SSDistributionOrderCell (){
    NSArray *_arrType;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSku;
@property (weak, nonatomic) IBOutlet UILabel *lblNum;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;



@end

@implementation SSDistributionOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _arrType = SSDistrbutionOrderStyleTitle;
    
}

- (void)setUIWithModel:(id)model Type:(SSDistrbutionOrderStyle)type{
    kSDLoadImg(_imgPic, @"");
//    _lblStatus.text = _arrType[type];
//    _lblStatus.textColor = type==SSDistrbutionNeedPayOrder?kSSHexColor(@"ff809e"):kSSHexColor(@"6ed23c");
//    _lblStatus.borderColor =type==SSDistrbutionNeedPayOrder?kSSHexColor(@"ff809e"):kSSHexColor(@"6ed23c");
}

- (void)setUIWithModel:(SSDistrbutionOrderModel *)model{
    kSDLoadImg(_imgPic, SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.product_image)));
    _lblTitle.text = kMeUnNilStr(model.product_name);
    _lblSku.text = kMeUnNilStr(model.order_spec_name);
    _lblNum.text = [NSString stringWithFormat:@"X%@",@(model.product_number)];
    _lblPrice.text = kMeUnNilStr(model.all_amount);
    
}


@end
