//
//  SSClerkCell.m
//  SunSum
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSClerkCell.h"
#import "SSClerkModel.h"

@interface SSClerkCell (){
    SSClerkModel *_model;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;

@end

@implementation SSClerkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWIthModel:(SSClerkModel *)model{
    _model = model;
    kSDLoadImg(_imgHeader, kMeUnNilStr(model.header_pic));
    _lblName.text = kMeUnNilStr(model.name);
    _lblPhone.text = [NSString stringWithFormat:@"手机号:%@",kMeUnNilStr(model.cellphone)];
}

- (void)setUIWithModel:(SSClerkModel *)model withKey:(NSString *)key{
    [self setUIWIthModel:model];
    if(kMeUnNilStr(key).length>0){
        _lblName.text = nil;
        _lblName.attributedText = [kMeUnNilStr(model.name) attributeWithRangeOfString:key color:kSSPink];
        _lblPhone.text = nil;
        _lblPhone.attributedText = [kMeUnNilStr(model.cellphone) attributeWithRangeOfString:key color:kSSPink];
    }
}

- (IBAction)moreAction:(UIButton *)sender {
    kMeCallBlock(_moreBlock);
}


@end
