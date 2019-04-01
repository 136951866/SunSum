//
//  SSBrandAbilityVisterCell.m
//  SunSum
//
//  Created by hank on 2019/3/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBrandAbilityVisterCell.h"
#import "SSBrandAbilityVisterModel.h"

@interface SSBrandAbilityVisterCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;


@end

@implementation SSBrandAbilityVisterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUiWithModel:(SSBrandAbilityVisterModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblName.text = kMeUnNilStr(model.nick_name);
    _lblTime.text = kMeUnNilStr(model.created_at);
}

@end
