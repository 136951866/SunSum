//
//  SSClerkOperationDailyMainCell.m
//  SunSum
//
//  Created by hank on 2019/4/18.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkOperationDailyMainCell.h"
#import "SSClerkOperationDailyMainModel.h"

@interface SSClerkOperationDailyMainCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;

@end

@implementation SSClerkOperationDailyMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
}

- (void)setUiWithModel:(SSClerkOperationDailyMainModel *)model{
    _lblName.text = kMeUnNilStr(model.nick_name);
    _lblCount.text = [@(model.task_count).description stringByAppendingString:@"个"];
}


@end
