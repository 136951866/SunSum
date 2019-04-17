//
//  SSEditClerkInfoCell.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSEditClerkInfoCell.h"
#import "SSTextView.h"


@interface SSEditClerkInfoCell (){
    BOOL _isMakr;
}
@property (weak, nonatomic) IBOutlet UIView *viewForText;
@property (nonatomic , strong) SSTextView *textView;
@property (nonatomic, strong) NSObject *model;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbltime;

@end

@implementation SSEditClerkInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    [_viewForText addSubview:self.textView];
    // Initialization code
}

- (void)setMarkUIWithModel:(id)model{
    _model = model;
    _isMakr = YES;
    kSDLoadImg(_imgPic, kMeUnNilStr(@""));
    _lblTitle.text = kMeUnNilStr(@"11");
    _lbltime.text = kMeUnNilStr(@"2019-09-09 00:00");
//    self.textView.textView.text = kMeUnNilStr(_model.goods_detail);
//    if ( kMeUnNilStr(_model.goods_detail).length == 0) {
//        self.textView.placeholderTextView.hidden = NO;
//    }else{
//        self.textView.placeholderTextView.hidden =YES;
//    }
}

- (void)setNoticeUIWithModel:(id)model{
    _model = model;
    _isMakr = NO;
    kSDLoadImg(_imgPic, kMeUnNilStr(@""));
    _lblTitle.text = kMeUnNilStr(@"11");
    _lbltime.text = kMeUnNilStr(@"2019-09-09 00:00");
    //    self.textView.textView.text = kMeUnNilStr(_model.goods_detail);
    //    if ( kMeUnNilStr(_model.goods_detail).length == 0) {
    //        self.textView.placeholderTextView.hidden = NO;
    //    }else{
    //        self.textView.placeholderTextView.hidden =YES;
    //    }
}


- (SSTextView *)textView{
    if(!_textView){
        _textView = [[SSTextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 178)];
        _textView.placeholderTextView.text =_isMakr?@"给这个员工备注":@"注意事项";
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
