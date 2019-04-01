//
//  SSAddGoodDivideCell.m
//  SunSum
//
//  Created by hank on 2019/3/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAddGoodDivideCell.h"
#import "SSAddGoodModel.h"
#import "SSBlockTextField.h"

@interface SSAddGoodDivideCell ()

@property (weak, nonatomic) IBOutlet SSBlockTextField *tfSale;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfMarket;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfStore;
@property (nonatomic, strong) SSAddGoodModel *model;

@end

@implementation SSAddGoodDivideCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
}

- (void)setUIWithModel:(SSAddGoodModel *)model{
    _model = model;
    kMeWEAKSELF
    _tfSale.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf.model.ratio_after_sales = kMeUnNilStr(str).floatValue;
    };
    _tfSale.text = @(_model.ratio_after_sales).description;
    
    _tfMarket.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf.model.ratio_marketing = kMeUnNilStr(str).floatValue;
    };
    _tfMarket.text = @(_model.ratio_marketing).description;
    
    _tfStore.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf.model.ratio_store = kMeUnNilStr(str).floatValue;
    };
    _tfStore.text = @(_model.ratio_store).description;
}

@end
