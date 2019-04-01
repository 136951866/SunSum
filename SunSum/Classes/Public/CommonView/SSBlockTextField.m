//
//  SSBlockTextField.m
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBlockTextField.h"

@implementation SSBlockTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)tfInput{
    kMeCallBlock(self.contentBlock, [kMeUnNilStr(tfInput.text) trimSpace]);
}
@end
