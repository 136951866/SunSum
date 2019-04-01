//
//  SSThridHomeTimeSecionContentCell.m
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSThridHomeTimeSecionContentCell.h"
#import "SSThridHomeRudeTimeModel.h"

@interface SSThridHomeTimeSecionContentCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIView *viewForSelect;

@end

@implementation SSThridHomeTimeSecionContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUIWIthModel:(SSThridHomeRudeTimeModel *)model isSelect:(BOOL)isSelect{
    _lblTime.text = kMeUnNilStr(model.time);
    _lblStatus.text = kMeUnNilStr(model.tip);
    if(isSelect){
        _lblStatus.textColor = kSSea3782;
        _viewForSelect.hidden = NO;
        _lblTime.textColor = [UIColor whiteColor];
    }else{
        _lblStatus.textColor = kSS999999;
        _viewForSelect.hidden = YES;
        _lblTime.textColor = kSSblack;
    }
}

@end
