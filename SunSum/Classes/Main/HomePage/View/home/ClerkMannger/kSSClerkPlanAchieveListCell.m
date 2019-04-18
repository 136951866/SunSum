//
//  kSSClerkPlanAchieveListCell.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "kSSClerkPlanAchieveListCell.h"
#import "SSClerkPlanAchieveClerkModel.h"

@interface kSSClerkPlanAchieveListCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblSore;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@property (weak, nonatomic) IBOutlet UIImageView *imgfinish;
@end

@implementation kSSClerkPlanAchieveListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblTime.adjustsFontSizeToFitWidth = YES;
}

- (void)setUIWIthModel:(SSClerkPlanAchieveClerkModel *)model sort:(NSInteger)sort{
    _lblSore.text = @(sort).description;
    if(sort == 1){
        _lblSore.backgroundColor = [UIColor colorWithHexString:@"FF9C00"];
    }else if (sort == 2){
        _lblSore.backgroundColor = [UIColor colorWithHexString:@"FFB43D"];
    }else if (sort == 3){
        _lblSore.backgroundColor = [UIColor colorWithHexString:@"FFCB78"];
    }else{
        _lblSore.backgroundColor = [UIColor colorWithHexString:@"8F8F8F"];
    }
    
    _lblTitle.text = kMeUnNilStr(model.task_title);
    _lblTime.text =kMeUnNilStr(model.last_time);
    _lblSubtitle.text =  kMeUnNilStr(model.task_content);
    _imgfinish.hidden = model.status !=2;
}
@end
