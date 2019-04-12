//
//  SSAICustomerHomeCell.m
//  SS时代
//
//  Created by hank on 2019/4/10.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAICustomerHomeCell.h"
#import "SSAICustomerHomeModel.h"

@interface  SSAICustomerHomeCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;


@end

@implementation SSAICustomerHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUiWithAddModel:(SSAICustomerHomeModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblTitle.text = kMeUnNilStr(model.nick_name);
    _lblSubtitle.text = kMeUnNilStr(model.comunication).length?[NSString stringWithFormat:@"%@小时前跟进",model.comunication]:@"还未跟进";
    if(kMeUnNilStr(model.created_at).length){
         _lblTime.text = [model.created_at substringToIndex:10];
    }else{
        _lblTime.text = @"";
    }
}

- (void)setSearchUiWithAddModel:(SSAICustomerHomeModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblTitle.text = kMeUnNilStr(model.nick_name);
    _lblSubtitle.text = kMeUnNilStr(model.comunication).length?[NSString stringWithFormat:@"%@小时前跟进",model.comunication]:@"还未跟进";
    if(kMeUnNilStr(model.predict_bargain).length){
        _lblTime.text = [model.created_at substringToIndex:10];
    }else{
        _lblTime.text = @"";
    }
}


@end
