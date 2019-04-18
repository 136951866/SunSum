//
//  SSClerkClerkListCell.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkClerkListCell.h"
#import "SSClerkModel.h"

@interface SSClerkClerkListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgselect;

@end

@implementation SSClerkClerkListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWIthModel:(SSClerkModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lbltitle.text = kMeUnNilStr(model.name);
    _lblSubtitle.text = kMeUnNilStr(model.cellphone);
    _imgselect.hidden = !model.isSelect;
}

@end
