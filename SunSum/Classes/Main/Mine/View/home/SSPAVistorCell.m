//
//  SSPAVistorCell.m
//  SS时代
//
//  Created by hank on 2019/4/4.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSPAVistorCell.h"
#import "SSVistorUserModel.h"

@interface SSPAVistorCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation SSPAVistorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithModel:(SSVistorUserModel *)model{
    kSDLoadImg(_imgHeader, kMeUnNilStr(model.user.header_pic));
    if(model.type == 1){
        //文章
        _lblTitle.text = [NSString stringWithFormat:@"%@访问了文章",kMeUnNilStr(model.user.nick_name)];

    }else if (model.type == 2){
        //海报
        _lblTitle.text = [NSString stringWithFormat:@"%@访问了海报",kMeUnNilStr(model.user.nick_name)];
    }
}

@end
