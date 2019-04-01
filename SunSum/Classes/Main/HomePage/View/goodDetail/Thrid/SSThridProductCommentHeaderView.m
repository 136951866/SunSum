//
//  SSThridProductCommentHeaderView.m
//  SunSum
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSThridProductCommentHeaderView.h"
#import "SSStarControl.h"
#import "SSGoodDetailModel.h"

@interface SSThridProductCommentHeaderView (){
    SSThridProductCommentHeaderViewType _type;
}

@property (weak, nonatomic) IBOutlet SSStarControl *starView;
@property (weak, nonatomic) IBOutlet UIButton *btnAll;
@property (weak, nonatomic) IBOutlet UIButton *btnGood;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblGood;

@end

@implementation SSThridProductCommentHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    _type = SSThridProductCommentHeaderViewAllType;
    _starView.starSize = CGSizeMake(16, 16);
}

- (void)setUIWithModel:(SSGoodDetailModel *)model type:(SSThridProductCommentHeaderViewType)type{
    _type = type;
    [_btnAll setTitle:[NSString stringWithFormat:@"全部(%@)",kMeUnNilStr(model.comment_count)] forState:UIControlStateNormal];
    [_btnGood setTitle:[NSString stringWithFormat:@"好评(%@)",kMeUnNilStr(model.good_comment_count)] forState:UIControlStateNormal];
    [_btnPhoto setTitle:[NSString stringWithFormat:@"晒图(%@)",kMeUnNilStr(model.show_pic_comment_count)] forState:UIControlStateNormal];
    _starView.score = model.value;
    _lblGood.text = [NSString stringWithFormat:@"%@好评率",kMeUnNilStr(model.equities)];
    [self reloadBtnStatusWithSelectBtn:_type];
}

- (void)reloadBtnStatusWithSelectBtn:(SSThridProductCommentHeaderViewType)type{
    switch (type) {
        case SSThridProductCommentHeaderViewAllType:{
            _btnAll.backgroundColor = kSSfeedfe;
            [_btnAll setTitleColor:kSSe74291 forState:UIControlStateNormal];
            _btnAll.borderWidth = 0;
            _btnGood.backgroundColor = [UIColor whiteColor];
            [_btnGood setTitleColor:kSS666666 forState:UIControlStateNormal];
            _btnGood.borderWidth = 1;
            _btnPhoto.backgroundColor = [UIColor whiteColor];
            [_btnPhoto setTitleColor:kSS666666 forState:UIControlStateNormal];
            _btnPhoto.borderWidth = 1;
        }
            break;
        case SSThridProductCommentHeaderViewGoodType:{
            _btnGood.backgroundColor = kSSfeedfe;
            [_btnGood setTitleColor:kSSe74291 forState:UIControlStateNormal];
            _btnGood.borderWidth = 0;
            _btnAll.backgroundColor = [UIColor whiteColor];
            [_btnAll setTitleColor:kSS666666 forState:UIControlStateNormal];
            _btnAll.borderWidth = 1;
            _btnPhoto.backgroundColor = [UIColor whiteColor];
            [_btnPhoto setTitleColor:kSS666666 forState:UIControlStateNormal];
            _btnPhoto.borderWidth = 1;
        }
            break;
        case SSThridProductCommentHeaderViewPhotoType:{
            _btnPhoto.backgroundColor = kSSfeedfe;
            [_btnPhoto setTitleColor:kSSe74291 forState:UIControlStateNormal];
            _btnPhoto.borderWidth = 0;
            _btnAll.backgroundColor = [UIColor whiteColor];
            [_btnAll setTitleColor:kSS666666 forState:UIControlStateNormal];
            _btnAll.borderWidth = 1;
            _btnGood.backgroundColor = [UIColor whiteColor];
            [_btnGood setTitleColor:kSS666666 forState:UIControlStateNormal];
            _btnGood.borderWidth = 1;
        }
            break;
        default:
            break;
    }
}

- (IBAction)allAction:(UIButton *)sender {
    _type = SSThridProductCommentHeaderViewAllType;
    [self reloadBtnStatusWithSelectBtn:_type];
    kMeCallBlock(_selectBlock,_type);
}

- (IBAction)goodAction:(UIButton *)sender {
    _type = SSThridProductCommentHeaderViewGoodType;
    [self reloadBtnStatusWithSelectBtn:_type];
    kMeCallBlock(_selectBlock,_type);
}

- (IBAction)photoAction:(UIButton *)sender {
    _type = SSThridProductCommentHeaderViewPhotoType;
    [self reloadBtnStatusWithSelectBtn:_type];
    kMeCallBlock(_selectBlock,_type);
}


@end
