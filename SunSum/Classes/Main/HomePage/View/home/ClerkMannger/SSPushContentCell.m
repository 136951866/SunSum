//
//  SSPushContentCell.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSPushContentCell.h"
#import "SSTextView.h"

@interface SSPushContentCell ()

@property (weak, nonatomic) IBOutlet UIView *viewForText;
@property (nonatomic , strong) SSTextView *textView;
@property (nonatomic, strong) NSObject *model;

@end

@implementation SSPushContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    [_viewForText addSubview:self.textView];
    // Initialization code
}


- (void)setUIWithModel:(id)model{
    _model = model;
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
        _textView.placeholderTextView.text = @"请填写任务内容";
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
