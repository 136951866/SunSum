//
//  SSStoreDetailCell.m
//  SunSum
//
//  Created by hank on 2018/10/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSStoreDetailCell.h"
#import "SSGoodModel.h"

@interface SSStoreDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAppointNum;


@end


@implementation SSStoreDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithModel:(SSGoodModel *)model{
    kSDLoadImg(_imgPic,  SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.images)));
    _lblTitle.text = kMeUnNilStr(model.title);
    _lblSubTitle.text = kMeUnNilStr(model.title);
    _lblAppointNum.text = [NSString stringWithFormat:@"%@人预约",kMeUnNilStr(model.reserve_num)];
}

@end
