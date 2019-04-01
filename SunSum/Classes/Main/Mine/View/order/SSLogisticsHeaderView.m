//
//  SSLogisticsHeaderView.m
//  SunSum
//
//  Created by hank on 2018/10/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSLogisticsHeaderView.h"
#import "SSOrderDetailModel.h"

@interface SSLogisticsHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblCompand;
@property (weak, nonatomic) IBOutlet UILabel *lblNum;

@end

@implementation SSLogisticsHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    _lblNum.adjustsFontSizeToFitWidth = YES;
}

- (void)setUIWithModel:(SSOrderDetailModel *)model{
    _imgPic.image = [UIImage imageNamed:@"nnuxtriysjrh"];
//    kSDLoadImg(_imgPic,  SSLoadQiniuImagesWithUrl(model.);
//    _lblStatus.text = kMeUnNilStr(@"");
    _lblStatus.hidden = YES;
    _lblCompand.text = @"百世汇通";
//    _lblNum.text = kMeUnNilStr(model.logistics.nu);
    
}

@end
