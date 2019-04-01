//
//  SSDistrbutionMyTeamCell.m
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSDistrbutionMyTeamCell.h"
#import "SSDistributionTeamModel.h"

@interface SSDistrbutionMyTeamCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end

@implementation SSDistrbutionMyTeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
}

- (void)setUIWithModel:(SSDistributionTeamModel *)model{
    kSDLoadImg(_imgPic, model.header_pic);
    _lblTitle.text = kMeUnNilStr(model.nick_name);
    _lblDate.text = kMeUnNilStr(model.updated_at);
}

@end
