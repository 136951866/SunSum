//
//  SSGoodManngerSpecBasicCell.m
//  SunSum
//
//  Created by hank on 2019/3/28.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSGoodManngerSpecBasicCell.h"
#import "SSGoodManngerAddSpecModel.h"
#import "SSBlockTextField.h"

@interface SSGoodManngerSpecBasicCell ()

@property (weak, nonatomic) IBOutlet SSBlockTextField *tfPrice;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfSock;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfSaleIntergal;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfShareIntergal;

@property (weak, nonatomic) IBOutlet UIButton *btnGoodDel;


@end

@implementation SSGoodManngerSpecBasicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)reloadUI{
    [self setUiWihtModel:self.model];
}

- (void)setUiWihtModel:(SSGoodManngerAddSpecModel*)model{
    _model = model;
    if(kMeUnNilStr(model.sepc_img).length){
        _btnGoodDel.hidden = NO;
        kSDLoadImg(_imgGood, SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.sepc_img)));
    }else{
        _btnGoodDel.hidden = YES;
        _imgGood.image = [UIImage imageNamed:@"icon_bynamicAdd"];
    }
    _tfPrice.contentBlock = ^(NSString *str) {
        model.price = kMeUnNilStr(str);
    };
    _tfPrice.text = kMeUnNilStr(model.price);
    
    _tfSock.contentBlock = ^(NSString *str) {
        model.stock = kMeUnNilStr(str);
    };
    _tfSock.text = kMeUnNilStr(model.stock);
    
    _tfSaleIntergal.contentBlock = ^(NSString *str) {
        model.saleIntegral = kMeUnNilStr(str);
    };
    _tfSaleIntergal.text = kMeUnNilStr(model.saleIntegral);
    
    _tfShareIntergal.contentBlock = ^(NSString *str) {
        model.shareIntegral = kMeUnNilStr(str);
    };
    _tfShareIntergal.text = kMeUnNilStr(model.shareIntegral);
}

- (IBAction)imgDelAction:(UIButton *)sender {
    _model.sepc_img = @"";
    _btnGoodDel.hidden = YES;
    _imgGood.image = [UIImage imageNamed:@"icon_bynamicAdd"];
}

- (IBAction)imgTouch:(UIButton *)sender {
        kMeCallBlock(_touchImgBlock);
}

@end
