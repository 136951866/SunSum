//
//  SSDynamicGoodApplyCell.m
//  SunSum
//
//  Created by hank on 2019/3/25.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSDynamicGoodApplyCell.h"
#import "SSDynamicGoodApplyModel.h"
#import "SSBlockTextField.h"
#import "SSBlockTextView.h"
#import "SSBynamicPublishGridModel.h"
#import "SSTextView.h"
@interface SSDynamicGoodApplyCell (){
//    kMeBasicBlock _selectImgBlock;
}

@property (weak, nonatomic) IBOutlet SSBlockTextField *tfTrue_name;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfgoodname;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfcell_phone;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfgoodprice;
//@property (weak, nonatomic) IBOutlet SSBlockTextView *txGoodDes;
@property (nonatomic , strong) SSTextView *textView;

@property (strong, nonatomic) SSDynamicGoodApplyModel *model;
//@property (weak, nonatomic) IBOutlet UIButton *btnimgDel;
//@property (weak, nonatomic) IBOutlet UIImageView *imgGood;

@end

@implementation SSDynamicGoodApplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    [self addSubview:self.textView];
    _canEdit = YES;
    // Initialization code
}

- (void)setCanEdit:(BOOL)canEdit{
    _canEdit = canEdit;
    if(!canEdit){
        _tfTrue_name.enabled = NO;
        _tfgoodname.enabled = NO;
        _tfcell_phone.enabled = NO;
        _tfgoodprice.enabled = NO;
        _textView.textView.editable = NO;
    }
}

- (void)setUIWithModel:(SSDynamicGoodApplyModel *)model{
    _model = model;
//    _selectImgBlock = selectImgBlock;
    kMeWEAKSELF
    self.tfTrue_name.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_model.true_name = str;
    };
    
    self.tfgoodname.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_model.goods_name = str;
    };
    
    self.tfcell_phone.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_model.phone = str;
    };
    
    self.tfgoodprice.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_model.price = str;
    };
    
    self.textView.contenBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_model.goods_detail = str;
    };
    
    _tfTrue_name.text = kMeUnNilStr(_model.true_name);
    _tfgoodname.text = kMeUnNilStr(_model.goods_name);;
    _tfcell_phone.text = kMeUnNilStr(_model.phone);;
    _tfgoodprice.text = kMeUnNilStr(_model.price);;
    self.textView.textView.text = kMeUnNilStr(_model.goods_detail);
    if ( kMeUnNilStr(_model.goods_detail).length == 0) {
        self.textView.placeholderTextView.hidden = NO;
    }else{
        self.textView.placeholderTextView.hidden =YES;
    }

}

- (void)textViewDidChange:(UITextView *)textView{
    NSString *text = kMeUnNilStr(textView.text);
    self.model.goods_detail = [text trimSpace];
//    kMeCallBlock(self.contentBlock,[text trimSpace]);
    
}

- (SSTextView *)textView{
    if(!_textView){
        _textView = [[SSTextView alloc]initWithFrame:CGRectMake(10, kSSDynamicGoodApplyCellHeight-121, SCREEN_WIDTH-20, 100)];
        _textView.placeholderTextView.text = @"商品描述/商品规格等";
        _textView.textView.font = kMeFont(17);
        _textView.textView.textColor = kSSblack;
        _textView.borderWidth = 0.5;
        _textView.borderColor = [UIColor colorWithHexString:@"ededed"];
    }
    return _textView;
}


@end
