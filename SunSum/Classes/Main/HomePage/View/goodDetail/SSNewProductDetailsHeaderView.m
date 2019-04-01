//
//  SSNewProductDetailsHeaderView.m
//  SunSum
//
//  Created by hank on 2019/1/9.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNewProductDetailsHeaderView.h"
#import "SDCycleScrollView.h"
#import "SSGoodDetailModel.h"

@interface SSNewProductDetailsHeaderView ()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *sdView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblExpress;
@property (weak, nonatomic) IBOutlet UILabel *lblStock;
@property (weak, nonatomic) IBOutlet UILabel *lblSaled;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSdHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectSku;

@end

@implementation SSNewProductDetailsHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    _lblPrice.adjustsFontSizeToFitWidth = YES;
    _lblSelectSku.adjustsFontSizeToFitWidth = YES;
    _consSdHeight.constant = SCREEN_WIDTH;
    _lblStock.adjustsFontSizeToFitWidth = YES;
    _lblExpress.adjustsFontSizeToFitWidth = YES;
    _lblSaled.adjustsFontSizeToFitWidth = YES;
    [self initSD];
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

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

- (void)setUIWithModel:(SSGoodDetailModel *)model{
    self.sdView.imageURLStringsGroup = @[SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.images))];
    _lblTitle.text = kMeUnNilStr(model.title);
    
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:kMeUnNilStr(model.title) font:[UIFont systemFontOfSize:15] width:(SCREEN_WIDTH - 20) lineH:0 maxLine:0];
    _consTitleHeight.constant = titleHeight>19?titleHeight:19;
    [_lblTitle setAtsWithStr:kMeUnNilStr(model.title) lineGap:0];
    _lblSubTitle.text = kMeUnNilStr(model.title);
    _lblPrice.text = [NSString stringWithFormat:@"¥%@",kMeUnNilStr(model.interval_price)];

    CGFloat postage = [model.postage floatValue];
    if(postage<=0){
        _lblExpress.text = @"快递:包邮";
    }else{
        _lblExpress.text = [NSString stringWithFormat:@"快递:%@元",model.postage];
    }
}

- (void)reloadStockAndSaled:(SSGoodDetailModel *)model{
    _lblStock.text = [NSString stringWithFormat:@"参与数:%@",kMeUnNilStr(model.browse)];
    _lblSaled.text = [NSString stringWithFormat:@"销量:%@",kMeUnNilStr(model.sales)];
    _lblSelectSku.text = [NSString stringWithFormat:@"已选:数量x%@,规格:%@",@(model.buynum),kMeUnNilStr(model.skus)];
}

- (IBAction)selectSku:(UIButton *)sender {
    kMeCallBlock(_selectSkuBlock);
}


+ (CGFloat)getHeightWithModel:(SSGoodDetailModel *)model{
    CGFloat height = 17+11+14+12+28+7+16+10+44+10;
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:kMeUnNilStr(model.title) font:[UIFont systemFontOfSize:15] width:(SCREEN_WIDTH - 20) lineH:0 maxLine:0];
    height += titleHeight>19?titleHeight:19;
    height += SCREEN_WIDTH;
    return height;
}
@end
