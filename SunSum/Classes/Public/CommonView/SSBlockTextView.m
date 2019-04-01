//
//  SSBlockTextView.m
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBlockTextView.h"

@interface SSBlockTextView()<UITextViewDelegate>

@end

@implementation SSBlockTextView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.delegate = self;
}

- (void)textViewDidChange:(UITextView *)textView{
    NSString *text = kMeUnNilStr(textView.text);
    kMeCallBlock(self.contentBlock,[text trimSpace]);
    
}

@end



