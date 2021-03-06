//
//  SSAddGoodAssembleCell.m
//  SunSum
//
//  Created by hank on 2019/3/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAddGoodAssembleCell.h"
#import "SSAddGoodModel.h"
#import "THDatePickerView.h"
#import "SSBlockTextField.h"
#import "MEPickerDayView.h"

@interface SSAddGoodAssembleCell ()

@property (nonatomic, strong) NSDate *selectedDate;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfStartTime;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfEndTime;
@property (nonatomic, strong) SSAddGoodModel *model;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfgroup_num;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfOverTime;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfRed;

@end

@implementation SSAddGoodAssembleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}
- (void)setUIWithModel:(SSAddGoodModel *)model{
    _model = model;
    _tfStartTime.text = kMeUnNilStr(_model.start_time);
    _tfEndTime.text = kMeUnNilStr(_model.end_time);
    _tfOverTime.text = kMeUnNilStr(_model.over_time);
    kMeWEAKSELF
    _tfgroup_num.contentBlock = ^(NSString *str) {
      kMeSTRONGSELF
        strongSelf->_model.group_num = kMeUnNilStr(str);
    };
    _tfgroup_num.text = kMeUnNilStr(_model.group_num);
    
    _tfRed.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_model.red_packet = kMeUnNilStr(str);
    };
    _tfRed.text = kMeUnNilStr(_model.red_packet);
    
}

- (IBAction)overAction:(UIButton *)sender {
    kMeWEAKSELF
    MEPickerDayView *view = [[MEPickerDayView alloc]initWithSelectedDate:^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_tfOverTime.text = kMeUnNilStr(str);
        strongSelf->_model.over_time = kMeUnNilStr(str);
    } arrDay:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"]];
    [kMeCurrentWindow endEditing:YES];
    [kMeCurrentWindow addSubview:view];
}


- (IBAction)startAction:(UIButton *)sender {
    kMeWEAKSELF
    THDatePickerView *view = [[THDatePickerView alloc]initWithSelectDaye:^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_tfStartTime.text = str;
        strongSelf->_model.start_time = str;
    }];
    [kMeCurrentWindow endEditing:YES];

    [kMeCurrentWindow addSubview:view];

}

- (IBAction)endAction:(UIButton *)sender {
    kMeWEAKSELF
    THDatePickerView *view = [[THDatePickerView alloc]initWithSelectDaye:^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_tfEndTime.text = str;
        strongSelf->_model.end_time = str;
    }];
    [kMeCurrentWindow endEditing:YES];

    [kMeCurrentWindow addSubview:view];
}




@end
