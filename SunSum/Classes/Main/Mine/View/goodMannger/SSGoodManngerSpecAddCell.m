//
//  SSGoodManngerSpecAddCell.m
//  SunSum
//
//  Created by hank on 2019/3/28.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSGoodManngerSpecAddCell.h"
#import "SSGoodManngerGoodSpec.h"
#import "SSBlockTextField.h"

@interface SSGoodManngerSpecAddCell ()


@property (weak, nonatomic) IBOutlet UILabel *lblSpec;

@property (weak, nonatomic) IBOutlet SSBlockTextField *tfContent;

@end

@implementation SSGoodManngerSpecAddCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblSpec.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWithModel:(SSGoodManngerGoodSpec *)model{
    _lblSpec.text = kMeUnNilStr(model.spec_name);
    _tfContent.contentBlock = ^(NSString *str) {
        model.specContent = kMeUnNilStr(str);
    };
    _tfContent.text = kMeUnNilStr(model.specContent);
}

@end
