//
//  SSClerkSortContentCell.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkSortContentCell.h"
#import "SSNewClerkManngerModel.h"

@interface  SSClerkSortContentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPIc;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;


@end

@implementation SSClerkSortContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWIthModel:(SSNewClerkManngerDataContentModel *)model sort:(NSInteger)sort type:(NSInteger)type{
    if(sort == 0){
        _imgPIc.image = [UIImage imageNamed:@"icon_brandAi_one"];
    }else if (sort == 1){
        _imgPIc.image = [UIImage imageNamed:@"icon_brandAi_two"];
    }else{
        _imgPIc.image = [UIImage imageNamed:@"icon_brandAi_three"];
    }
    _lblName.text = kMeUnNilStr(model.name);
    _lblCount.text = kMeUnNilStr(model.count);
//    if(type == 0){
//        _lblCount.text = kMeUnNilStr(model.share_count);
//    }else if (type == 1){
//        _lblCount.text = kMeUnNilStr(model.follow_up_count);
//    }else{
//        _lblCount.text =  kMeUnNilStr(model.member_count);
//    }
}


@end
