//
//  SSFFourCaseHeaderView.m
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSFFourCaseHeaderView.h"

@interface SSFFourCaseHeaderView (){
    UIButton *_currentbtn;
}
@property (weak, nonatomic) IBOutlet UIButton *btnEdu;
@property (weak, nonatomic) IBOutlet UIButton *btnTour;
@property (weak, nonatomic) IBOutlet UIButton *btnCar;
@property (weak, nonatomic) IBOutlet UIButton *btnZX;

@end

@implementation SSFFourCaseHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    _btnEdu.borderColor = [UIColor colorWithHexString:@"169DFF"];
    _btnTour.borderColor = [UIColor colorWithHexString:@"bbbbbb"];
    _btnCar.borderColor = [UIColor colorWithHexString:@"bbbbbb"];
    _btnZX.borderColor = [UIColor colorWithHexString:@"bbbbbb"];
    _currentbtn = _btnEdu;
}

- (IBAction)tapAction:(UIButton *)sender {
    if(_currentbtn == sender){
        return;
    }
    _currentbtn.borderColor = [UIColor colorWithHexString:@"bbbbbb"];
    _currentbtn.selected = NO;
    sender.borderColor = [UIColor colorWithHexString:@"169DFF"];
    sender.selected = YES;
    _currentbtn = sender;
    NSInteger tag = sender.tag - 1000;
    kMeCallBlock(_selectBlock,tag);
}





@end
