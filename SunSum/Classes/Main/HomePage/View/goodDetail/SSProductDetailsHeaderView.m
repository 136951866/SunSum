//
//  SSProductDetailsHeaderView.m
//  SunSum
//
//  Created by hank on 2018/9/8.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSProductDetailsHeaderView.h"
#import "SDCycleScrollView.h"
#import "SSGoodDetailModel.h"

@interface SSProductDetailsHeaderView()<SDCycleScrollViewDelegate>{
    BOOL _isInteral;
}
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblIntergal;
@property (weak, nonatomic) IBOutlet UILabel *lblMember;
@property (weak, nonatomic) IBOutlet UIView *viewMember;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *sdView;
@property (weak, nonatomic) IBOutlet UILabel *lblSave;
@property (weak, nonatomic) IBOutlet UILabel *lblCommonPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblDean;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSdHeight;

@property (weak, nonatomic) IBOutlet UILabel *lblIntervalPrice;
@end


@implementation SSProductDetailsHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    _lblPrice.adjustsFontSizeToFitWidth = YES;
    _lblIntergal.adjustsFontSizeToFitWidth = YES;
    _lblMember.adjustsFontSizeToFitWidth = YES;
    _viewMember.userInteractionEnabled = YES;
    _lblCommonPrice.adjustsFontSizeToFitWidth = YES;
    [self initSD];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMemberView:)];
    [_viewMember addGestureRecognizer:ges];
    _lblSave.hidden = YES;
    _consSdHeight.constant = kSSProductDetailsHeaderViewHeight;
}

- (void)tapMemberView:(UITapGestureRecognizer *)ges{
    NSLog(@"tapMemberView");
}

- (void)setUIWithModel:(SSGoodDetailModel *)model{
    _lblIntervalPrice.hidden = NO;
    _isInteral = NO;
//    __block NSMutableArray *arrImage = [NSMutableArray array];
//    [arrModel enumerateObjectsUsingBlock:^(NSString *model, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *url=model;
//        [arrImage addObject:kMeUnNilStr(url)];
//    }];
    self.sdView.imageURLStringsGroup = @[SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.images))];
    _lblTitle.text = kMeUnNilStr(model.title);
    _lblCommonPrice.text = @"";//[NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(model.market_price).floatValue)];
    _lblPrice.text = @"";//kMeUnNilStr(model.interval_price);
    _lblIntervalPrice.text = [NSString stringWithFormat:@"¥%@",kMeUnNilStr(model.interval_price)];
//    _lblSave.text = [NSString stringWithFormat:@"为您节省¥%.2f",[kMeUnNilStr(model.market_price) floatValue]-[kMeUnNilStr(model.money) floatValue]];
//    if(model.product_id == 4){
//        _lblMember.text = @"每人限领一支,分享后可以再购买一支.";
//    }else{
        _lblMember.text = @"棒的APP优选";
//    }
    
}

- (void)setIntergalUIWithModel:(SSGoodDetailModel *)model{
    _isInteral = YES;
    _lblIntervalPrice.hidden = YES;
    _lblTitle.text = kMeUnNilStr(model.title);
    self.sdView.imageURLStringsGroup = @[SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.images))];
    _lblSave.hidden = YES;
    _imgIcon.hidden = YES;
    _lblIntergal.hidden = YES;
    _lblDean.textColor = kSSPink;
    _lblCommonPrice.textColor = kSSHexColor(@"999999");
    
    _lblDean.text = [NSString stringWithFormat:@"%@美豆",kMeUnNilStr(model.integral_lines)];
    _lblCommonPrice.text = [NSString stringWithFormat:@"¥%@",kMeUnNilStr(model.money)];
    
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

}

- (void)initSD{
    _sdView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _sdView.pageControlStyle =SDCycleScrollViewPageContolStyleClassic;
    _sdView.autoScrollTimeInterval = 4;
    _sdView.delegate =self;
    _sdView.backgroundColor = [UIColor clearColor];
    _sdView.placeholderImage = kImgBannerPlaceholder;
    _sdView.currentPageDotColor = kSSPink;
}

+ (CGFloat)getViewHeight{
    CGFloat allHeight=530 - 375 + (kSSProductDetailsHeaderViewHeight);
    return allHeight;
}

@end
