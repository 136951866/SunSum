//
//  SSAIDataHomeTimeCell.m
//  SS时代
//
//  Created by hank on 2019/4/9.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAIDataHomeTimeCell.h"
#import "SSAIDataHomeTimeModel.h"
#import "SSMonthNotFollowUpMemberModel.h"

@interface SSAIDataHomeTimeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;


@end

@implementation SSAIDataHomeTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithModel:(SSAIDataHomeTimeModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblTitle.text = [NSString stringWithFormat:@"%@第%@次查看您的小店",kMeUnNilStr(model.nick_name),kMeUnNilStr(model.count)];
    _lblTime.text = kMeUnNilStr(model.created_at);
}

- (void)setFollowUIWithModel:(SSMonthNotFollowUpMemberModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblTitle.text =kMeUnNilStr(model.nick_name);
    _lblTime.text = @"";
}

- (void)setPeopleUIWithModel:(SSAIDataHomeTimeModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblTitle.text = [NSString stringWithFormat:@"%@和您互动了%@次",kMeUnNilStr(model.nick_name),kMeUnNilStr(model.count)];
    _lblTime.text = kMeUnNilStr(model.created_at);
}

@end
