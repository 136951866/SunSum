//
//  SSArticleCell.m
//  SunSum
//
//  Created by hank on 2018/11/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSArticleCell.h"
#import "SSArticelModel.h"

@interface SSArticleCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;

@end

@implementation SSArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblSubTitle.adjustsFontSizeToFitWidth = YES;
    _lblTitle.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:15];
    // Initialization code
}

- (void)setUIWithModel:(SSArticelModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.images_url));
    _lblTitle.text = kMeUnNilStr(model.title);
    _lblSubTitle.text = [NSString stringWithFormat:@"阅读量 %@ %@",@(model.read).description,kMeUnNilStr(model.updated_at)];
}

- (void)setUIWithModel:(SSArticelModel *)model withKey:(NSString *)key{
    [self setUIWithModel:model];
    if(kMeUnNilStr(key).length>0){
        _lblTitle.text = nil;
        _lblTitle.attributedText = [kMeUnNilStr(model.title) attributeWithRangeOfString:key color:kSSPink];
    }
}

@end
