//
//  SSBrandAbilityAnalysisCell.m
//  SunSum
//
//  Created by hank on 2019/3/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBrandAbilityAnalysisCell.h"
#import "SSBrandAbilityAnalysisDataModel.h"

@interface SSBrandAbilityAnalysisCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;


@end

@implementation SSBrandAbilityAnalysisCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithModel:(SSBrandAbilityAnalysisDataModel*)model{
    _lblTitle.text = kMeUnNilStr(model.title);
    _lblSubtitle.text = kMeUnNilStr(model.subtitle);
}

@end
