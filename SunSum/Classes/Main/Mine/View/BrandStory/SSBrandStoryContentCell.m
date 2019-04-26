//
//  SSBrandStoryContentCell.m
//  SunSum
//
//  Created by hank on 2019/4/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBrandStoryContentCell.h"
#import "MEBrandStoryModel.h"

@interface SSBrandStoryContentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UIView *viewForMark;
@property (weak, nonatomic) IBOutlet UIView *viewForSelect;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation SSBrandStoryContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _viewForSelect.hidden = YES;
    _viewForMark.hidden = YES;
    _img.hidden = YES;
    _viewForMark.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [_viewForMark addGestureRecognizer:ges];
    // Initialization code
}

- (void)tap{
    _viewForSelect.hidden = YES;
    _viewForMark.hidden = YES;
    _img.hidden = YES;
}

- (void)setUIWIthModel:(MEBrandStoryContentModel *)model{
    _viewForMark.hidden = YES;
    _viewForSelect.hidden = YES;
    _img.hidden = YES;

    if(model.type == MEBrandStoryContentModelTXTType){
        _imgPic.hidden = YES;
        _lblContent.hidden = NO;
        _lblContent.text = kMeUnNilStr(model.value);
    }else if (model.type == MEBrandStoryContentModelVideoType){
        _imgPic.hidden = NO;
        _imgPic.contentMode = UIViewContentModeCenter;
        _imgPic.image = [UIImage imageNamed:@"stortpaly"];
        _lblContent.hidden = YES;
    }else if (model.type == MEBrandStoryContentModelPicType){
        _imgPic.contentMode = UIViewContentModeScaleAspectFill;
        kSDLoadImg(_imgPic, SSLoadAddQiniuImagesWithUrl(model.value));
        _imgPic.hidden = NO;
        _lblContent.hidden = YES;
    }else{
        _imgPic.hidden = YES;
        _lblContent.hidden = YES;
    }
}

- (IBAction)addpicAction:(UIButton *)sender {
    _viewForSelect.hidden = YES;
    _viewForMark.hidden = YES;
    _img.hidden = YES;
    kMeCallBlock(_addBlcok,MEBrandStoryContentModelPicType);
}

- (IBAction)addvideocAction:(UIButton *)sender {
    _viewForSelect.hidden = YES;
    _viewForMark.hidden = YES;
    _img.hidden = YES;

    kMeCallBlock(_addBlcok,MEBrandStoryContentModelVideoType);
}

- (IBAction)addtextAction:(UIButton *)sender {
    _viewForSelect.hidden = YES;
    _viewForMark.hidden = YES;
    _img.hidden = YES;

   kMeCallBlock(_addBlcok,MEBrandStoryContentModelTXTType);
}

- (IBAction)addAction:(UIButton *)sender {
    _viewForSelect.hidden = NO;
    _viewForMark.hidden = NO;
    _img.hidden = NO;

}

- (IBAction)delAction:(UIButton *)sender {
    kMeCallBlock(_delBlcok);
}


@end
