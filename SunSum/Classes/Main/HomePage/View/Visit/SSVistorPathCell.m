//
//  SSVistorPathCell.m
//  SunSum
//
//  Created by hank on 2018/11/29.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSVistorPathCell.h"
#import "SSVistorUserPathModel.h"

@interface SSVistorPathCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblCount;
@property (weak, nonatomic) IBOutlet UIImageView *imgF;
@property (weak, nonatomic) IBOutlet UILabel *lblF;
@property (weak, nonatomic) IBOutlet UIImageView *imgT;
@property (weak, nonatomic) IBOutlet UILabel *lblT;

@end

@implementation SSVistorPathCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblCount.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUiWIthModel:(SSVistorUserPathModel *)model count:(NSInteger)count{
    _lblCount.text = @(count).description;
    kSDLoadImg(_imgF, kMeUnNilStr(model.spread_member_images));
    kSDLoadImg(_imgT, kMeUnNilStr(model.member_images));
    _lblF.text = kMeUnNilStr(model.spread_member);
    _lblT.text = kMeUnNilStr(model.member);
}
@end
