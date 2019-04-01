//
//  SSVistorPathMainCell.m
//  SunSum
//
//  Created by hank on 2018/11/29.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSVistorPathMainCell.h"
#import "SSVistorUserModel.h"

@interface SSVistorPathMainCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UIView *viewForContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgPoster;

@end

@implementation SSVistorPathMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _viewForContent.layer.shadowColor = [UIColor colorWithHexString:@"f0f5fe"].CGColor;
    _viewForContent.layer.shadowOpacity = 1;
    _viewForContent.layer.shadowOffset = CGSizeMake(0, 0);
    _viewForContent.layer.shadowRadius = 5;;
    // Initialization code
}

- (void)setUiWIthModle:(SSVistorUserModel *)model{
    if(model.type == 1){
        _imgPoster.hidden = YES;
        _imgPic.hidden = NO;
        kSDLoadImg(_imgPic, kMeUnNilStr(model.article.images_url));
    }else{
        _imgPic.hidden = YES;
        _imgPoster.hidden = NO;
        kSDLoadImg(_imgPoster, kMeUnNilStr(model.article.images_url));
    }
    _lblTitle.text = kMeUnNilStr(model.article.title);
    _lblTime.text =  kMeUnNilStr(model.updated_at);
}
@end
