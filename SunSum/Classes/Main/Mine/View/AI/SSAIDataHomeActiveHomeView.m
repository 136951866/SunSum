//
//  SSAIDataHomeActiveHomeView.m
//  SS时代
//
//  Created by hank on 2019/4/9.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAIDataHomeActiveHomeView.h"

@interface  SSAIDataHomeActiveHomeView(){
    UIButton *_btncurrent;
}

@property (weak, nonatomic) IBOutlet UIButton *btnAll;
@property (weak, nonatomic) IBOutlet UIButton *btnToDay;
@property (weak, nonatomic) IBOutlet UIButton *btnSeven;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth;

@end

@implementation SSAIDataHomeActiveHomeView

- (void)awakeFromNib{
    [super awakeFromNib];
    [_btnAll setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_btnToDay setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_btnSeven setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_btnMonth setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    [_btnAll setBackgroundImage:[SSCommonTool createImageWithColor:kSS333333] forState:UIControlStateSelected];
    [_btnToDay setBackgroundImage:[SSCommonTool createImageWithColor:kSS333333] forState:UIControlStateSelected];
    [_btnSeven setBackgroundImage:[SSCommonTool createImageWithColor:kSS333333] forState:UIControlStateSelected];
    [_btnMonth setBackgroundImage:[SSCommonTool createImageWithColor:kSS333333] forState:UIControlStateSelected];
    _btncurrent = _btnAll;
    _btnAll.selected = YES;
    _btnToDay.selected = NO;
    _btnSeven.selected = NO;
    _btnMonth.selected = NO;
}

- (void)setUiWithType:(SSAIDataHomeActiveHomeViewType)type{
    NSInteger tag = 2000+type;
    UIButton *btn = [self viewWithTag:tag];
    btn.selected = YES;
    _btncurrent = btn;
}

- (IBAction)tapBtn:(UIButton *)sender {
    NSInteger index = sender.tag - 2000;
    _btncurrent.selected = NO;
    _btncurrent = sender;
    sender.selected = YES;
    kMeCallBlock(_selectBlock,index);
}



@end
