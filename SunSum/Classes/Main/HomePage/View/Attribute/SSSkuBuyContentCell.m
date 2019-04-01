//
//  SSSkuBuyContentCell.m
//  SunSum
//
//  Created by Hank on 2018/9/10.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSSkuBuyContentCell.h"
#import "SSGoodSpecModel.h"

@interface SSSkuBuyContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end

@implementation SSSkuBuyContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = kSSSkuBuyContentCellHeight * 0.5;
    _lblContent.textColor = [UIColor whiteColor];
    _lblContent.backgroundColor = kSSUnSelect;
    _lblContent.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setmodelWithStr:(SSGoodSpecModel *)model isSelect:(BOOL)isSelect{
    _lblContent.text = kMeUnNilStr(model.spec_value);
    _lblContent.backgroundColor = isSelect ? kSSPink:kSSUnSelect;
    
}


@end
