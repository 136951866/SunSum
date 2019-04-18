//
//  SSCLerkSortHomeCell.m
//  SunSum
//
//  Created by hank on 2019/4/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCLerkSortHomeCell.h"
#import "SSNewClerkManngerModel.h"

@interface SSCLerkSortHomeCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblSore;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;

@end

@implementation SSCLerkSortHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithModel:(SSNewClerkManngerDataContentModel *)model sort:(NSInteger)sort{
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
    _lblTitle.text = kMeUnNilStr(model.name);
    _lblSubTitle.text = kMeUnNilStr(model.count);
}

@end
