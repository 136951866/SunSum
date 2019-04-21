//
//  SSClerkFollowCell.m
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkFollowCell.h"
#import "SSClerkNotFollowUpMember.h"

@interface SSClerkFollowCell ()
{
    NSArray *_arrdata;
}


@property (weak, nonatomic) IBOutlet UILabel *lblsevenday;
@property (weak, nonatomic) IBOutlet UILabel *lblhalfMonth;
@property (weak, nonatomic) IBOutlet UILabel *lblMonth;


@end

@implementation SSClerkFollowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUiWithModel:(SSClerkNotFollowUpMember *)model{
    _lblsevenday.text = @(model.seven_day).description;
    _lblhalfMonth.text = @(model.fifteen_day).description;
    _lblMonth.text = @(model.thirty_day).description;
}

@end
