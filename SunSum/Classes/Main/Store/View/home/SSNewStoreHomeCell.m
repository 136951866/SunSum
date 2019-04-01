//
//  SSNewStoreHomeCell.m
//  SunSum
//
//  Created by hank on 2019/1/22.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNewStoreHomeCell.h"
#import "SSStarControl.h"
#import "SSStoreModel.h"
#import "SSFlowLabelView.h"

@interface SSNewStoreHomeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet SSStarControl *starView;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet SSFlowLabelView *flowLabelView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consflowHeight;

@end

@implementation SSNewStoreHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblDistance.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWithModel:(SSStoreModel *)model{
    kSDLoadImg(_imgPic, SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.mask_img)));
    _lblTitle.text = kMeUnNilStr(model.store_name);
    _lblAddress.text =[NSString stringWithFormat:@"%@%@%@%@",kMeUnNilStr(model.province),kMeUnNilStr(model.city),kMeUnNilStr(model.district),kMeUnNilStr(model.address)];
    _starView.score = model.stars;
    _lblScore.text = [NSString stringWithFormat:@"%@分",@(model.stars).description];
    _lblDistance.text = [NSString stringWithFormat:@"%@",kMeUnNilStr(model.distance)];
    if(kMeUnArr(model.label).count){
        _flowLabelView.hidden = NO;
        _consflowHeight.constant = [SSFlowLabelView getSSFlowLabelViewHeightWithArr:kMeUnArr(model.label)];
        [_flowLabelView reloaWithArr:kMeUnArr(model.label)];
    }else{
        _flowLabelView.hidden = YES;
        _consflowHeight.constant = 0;
    }
    
}

- (void)setUIWithModel:(SSStoreModel *)model WithKey:(NSString *)key{
    [self setUIWithModel:model];
    if(kMeUnNilStr(key).length>0){
        _lblTitle.text = nil;
        _lblTitle.attributedText = [kMeUnNilStr(model.store_name) attributeWithRangeOfString:key color:kSSPink];
        _lblAddress.text = nil;
        NSString *address = [NSString stringWithFormat:@"%@%@%@%@",kMeUnNilStr(model.province),kMeUnNilStr(model.city),kMeUnNilStr(model.district),kMeUnNilStr(model.address)];
        _lblAddress.attributedText = [address attributeWithRangeOfString:key color:kSSPink];
    }
}

+ (CGFloat)getCellHeightWithmodel:(SSStoreModel *)model{
    if(kMeUnArr(model.label).count){
        CGFloat height = kSSNewStoreHomeCellHeight;
        height +=[SSFlowLabelView getSSFlowLabelViewHeightWithArr:kMeUnArr(model.label)];
        height+=13;
        return height;
    }else{
        return kSSNewStoreHomeCellHeight+13;
    }
}


@end
