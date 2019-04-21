//
//  SSFourClerkHomeHeaderView.m
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSFourClerkHomeHeaderView.h"

@implementation SSFourClerkHomeHeaderView


- (IBAction)toAiAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toAiVC)]){
        [self.delegate toAiVC];
    }
}

- (IBAction)toPAAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toPAVC)]){
        [self.delegate toPAVC];
    }
}

@end
