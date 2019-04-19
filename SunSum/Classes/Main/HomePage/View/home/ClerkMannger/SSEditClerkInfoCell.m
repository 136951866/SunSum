//
//  SSEditClerkInfoCell.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSEditClerkInfoCell.h"

#import "SSClerkFinishTaskModel.h"

@interface SSEditClerkInfoCell (){
    //0 备注 1注意 2预约数
    SSClerkEditLogType _type;
}
@property (weak, nonatomic) IBOutlet UIView *viewForText;
@property (nonatomic,strong) SSClerkFinishTaskModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbltime;

@end

@implementation SSEditClerkInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    [_viewForText addSubview:self.textView];
    _lbltime.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setServerUIWithModel:(SSClerkFinishTaskModel *)model{
    _model = model;
    _type = SSClerkEditLogServerNumType;
    _textView.textView.keyboardType = UIKeyboardTypeNumberPad;
    _textView.placeholderTextView.text = @"预约数";
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblTitle.text = kMeUnNilStr(model.name);
    _lbltime.text = kMeUnNilStr(model.last_time);
    self.textView.textView.text = kMeUnNilStr(model.reservation_num);
    if (kMeUnNilStr(model.reservation_num).length == 0) {
        self.textView.placeholderTextView.hidden = NO;
    }else{
        self.textView.placeholderTextView.hidden =YES;
    }
}

- (void)setMarkUIWithModel:(SSClerkFinishTaskModel *)model{
    _model = model;
    _type = SSClerkEditLogmarkType;
    _textView.placeholderTextView.text = @"备注";
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblTitle.text = kMeUnNilStr(model.name);
    _lbltime.text = kMeUnNilStr(model.last_time);
    self.textView.textView.text = kMeUnNilStr(model.desc);
    if ( kMeUnNilStr(model.desc).length == 0) {
        self.textView.placeholderTextView.hidden = NO;
    }else{
        self.textView.placeholderTextView.hidden =YES;
    }
}

- (void)setNoticeUIWithModel:(SSClerkFinishTaskModel *)model{
    _model = model;
    _type = SSClerkEditLogNoticeType;
    _textView.placeholderTextView.text = @"注意事项";
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblTitle.text = kMeUnNilStr(model.name);
    _lbltime.text = kMeUnNilStr(model.last_time);
    self.textView.textView.text = kMeUnNilStr(model.matters_attention);
    if ( kMeUnNilStr(model.matters_attention).length == 0) {
        self.textView.placeholderTextView.hidden = NO;
    }else{
        self.textView.placeholderTextView.hidden =YES;
    }
}


- (SSTextView *)textView{
    if(!_textView){
        _textView = [[SSTextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 178)];
//        _textView.placeholderTextView.text =_isMakr?@"备注":@"注意事项";
        _textView.textView.font = kMeFont(12);
        _textView.placeholderTextView.font = kMeFont(12);
        _textView.textView.textColor = kSSblack;
        _textView.borderWidth = 0.5;
        _textView.borderColor = [UIColor colorWithHexString:@"ededed"];
        _textView.backgroundColor = kSSf6f5fa;
        _textView.placeholderTextView.backgroundColor = kSSf6f5fa;
    }
    return _textView;
}

@end
