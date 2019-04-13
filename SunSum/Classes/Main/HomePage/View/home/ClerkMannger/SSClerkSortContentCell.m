//
//  SSClerkSortContentCell.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkSortContentCell.h"

@interface  SSClerkSortContentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPIc;


@end

@implementation SSClerkSortContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWIthModel:(id)model sort:(NSInteger)sort{
    if(sort == 0){
        _imgPIc.image = [UIImage imageNamed:@"icon_brandAi_one"];
    }else if (sort == 1){
        _imgPIc.image = [UIImage imageNamed:@"icon_brandAi_two"];
    }else{
        _imgPIc.image = [UIImage imageNamed:@"icon_brandAi_three"];
    }
}


@end
