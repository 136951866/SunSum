//
//  SSFourHomeHeaderView.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSFourHomeHeaderView.h"

@implementation SSFourHomeHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
}


- (IBAction)toAiAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toAiVC)]){
        [self.delegate toAiVC];
    }
}

- (IBAction)toStoreDiagnosisAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toStoreDiagnosisVC)]){
        [self.delegate toStoreDiagnosisVC];
    }
}

- (IBAction)toPAAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toPAVC)]){
        [self.delegate toPAVC];
    }
}

- (IBAction)toClerkManngerAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toClerkManngerVC)]){
        [self.delegate toClerkManngerVC];
    }
}

- (IBAction)toCaseAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(toCaseVC)]){
        [self.delegate toCaseVC];
    }
}


@end
