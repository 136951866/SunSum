//
//  SSMyChildOrderContentCell.m
//  SunSum
//
//  Created by gao lei on 2018/9/21.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMyChildOrderContentCell.h"
#import "SSOrderModel.h"

@interface SSMyChildOrderContentCell (){
    NSArray *_arrType;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSkuAndNum;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@end

@implementation SSMyChildOrderContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _arrType = SSOrderStyleTitle;
    // Initialization code
}

- (void)setUIWithModel:(SSOrderGoodModel *)model{
    kSDLoadImg(_imgPic, SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.product_image)));
    _lblStatus.text = kMeUnNilStr(model.order_goods_status_name);
    _lblPrice.text = [NSString stringWithFormat:@"¥%@",kMeUnNilStr(model.product_amount)];
    _lblTitle.text = kMeUnNilStr(model.product_name);
    _lblSkuAndNum.text = [NSString stringWithFormat:@"规格:%@ 数量:%@",kMeUnNilStr(model.order_spec_name),@(model.product_number)];
}

- (void)setSelfUIWithModel:(SSOrderGoodModel *)model extractStatus:(NSString *)status{
    kSDLoadImg(_imgPic, SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.product_image)));
    _lblStatus.text = kMeUnNilStr(status);
    _lblPrice.text = [NSString stringWithFormat:@"¥%@",kMeUnNilStr(model.product_amount)];
    _lblTitle.text = kMeUnNilStr(model.product_name);
    _lblSkuAndNum.text = [NSString stringWithFormat:@"规格:%@ 数量:%@",kMeUnNilStr(model.order_spec_name),@(model.product_number)];
}


@end
