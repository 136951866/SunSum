//
//  kSSClerkPlanAchieveListCell.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "kSSClerkPlanAchieveListCell.h"

@interface kSSClerkPlanAchieveListCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblSore;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@end

@implementation kSSClerkPlanAchieveListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
}

- (void)setUIWIthModel:(id)model sort:(NSInteger)sort{
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
    _lblTitle.text = kMeUnNilStr(@"111");
    _lblTime.text = kMeUnNilStr(@"2019-09-90 00:00");
    _lblSubtitle.text = kMeUnNilStr(@"111");
}
@end
