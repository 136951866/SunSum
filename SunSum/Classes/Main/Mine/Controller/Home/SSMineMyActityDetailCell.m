//
//  SSMineMyActityDetailCell.m
//  SunSum
//
//  Created by hank on 2019/1/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSMineMyActityDetailCell.h"
#import "SSMineActiveModel.h"

@interface SSMineMyActityDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;


@end

@implementation SSMineMyActityDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblTitle.adjustsFontSizeToFitWidth = YES;
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWIthModel:(SSMineActiveLeveModel *)model finish:(BOOL)finish nowNum:(NSString*)nowNum{
//    _lblTitle.text = [NSString stringWithFormat:@"%@级达成条件:%@/%@人",kMeUnNilStr(model.level),kMeUnNilStr(nowNum),kMeUnNilStr(model.share_number)];
//    if(finish){
//        _lblStatus.text = @"已完成";
//        _lblStatus.textColor = kSSPink;
//    }else{
//        _lblStatus.text = @"未完成";
//         _lblStatus.textColor = kSSblack;
//    }
}


@end
