//
//  SSClerkDiagnosisResultClerkHeaderView.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkDiagnosisResultClerkHeaderView.h"

@interface SSClerkDiagnosisResultClerkHeaderView (){
    UIButton *_currentBtn;
}

@property (weak, nonatomic) IBOutlet UIButton *btnNew;
@property (weak, nonatomic) IBOutlet UIButton *btnqz;
@property (weak, nonatomic) IBOutlet UIButton *btnAttention;
@property (weak, nonatomic) IBOutlet UIButton *btnOld;


@end

@implementation SSClerkDiagnosisResultClerkHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    [_btnNew setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor colorWithHexString:@"171c30"]] forState:UIControlStateNormal];
    [_btnqz setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor colorWithHexString:@"171c30"]] forState:UIControlStateNormal];
    [_btnAttention setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor colorWithHexString:@"171c30"]] forState:UIControlStateNormal];
    [_btnOld setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor colorWithHexString:@"171c30"]] forState:UIControlStateNormal];
    
    [_btnNew setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor colorWithHexString:@"262d47"]] forState:UIControlStateSelected];
    [_btnqz setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor colorWithHexString:@"262d47"]] forState:UIControlStateSelected];
    [_btnAttention setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor colorWithHexString:@"262d47"]] forState:UIControlStateSelected];
    [_btnOld setBackgroundImage:[SSCommonTool createImageWithColor:[UIColor colorWithHexString:@"262d47"]] forState:UIControlStateSelected];
    _btnNew.selected = YES;
    _currentBtn = _btnNew;
    
}

- (IBAction)tapAction:(UIButton *)sender {
    NSInteger index = sender.tag - 1000;
    _currentBtn.selected = NO;
    sender.selected = YES;
    _currentBtn = sender;
    kMeCallBlock(_indexBlock,index);
}


@end
