//
//  SSThridNavView.m
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSThridNavView.h"

@interface SSThridNavView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consBottomMargin;

@end

@implementation SSThridNavView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self layoutIfNeeded];
}

@end
