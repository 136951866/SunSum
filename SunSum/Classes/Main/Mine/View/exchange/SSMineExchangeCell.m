//
//  SSMineExchangeCell.m
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMineExchangeCell.h"
#import "SSGoodModel.h"

@interface SSMineExchangeCell (){
    kMeBasicBlock _exchangeBlock;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblInteral;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImgWdith;

@end

@implementation SSMineExchangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _consImgWdith.constant = 109 *kMeFrameScaleX();
    _lblInteral.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWithModel:(SSGoodModel *)model ExchangeBlock:(kMeBasicBlock)exchangeBlock{
    _exchangeBlock = exchangeBlock;
    _lblSubtitle.hidden = YES;
    kSDLoadImg (_imgPic,SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.images)));
    _lblTitle.text = kMeUnNilStr(model.title);
    _lblPrice.text = [NSString stringWithFormat:@"¥%@",model.market_price];
    _lblInteral.text =[NSString stringWithFormat:@"%@美豆",model.integral_lines];
}

- (IBAction)exchageAction:(UIButton *)sender {
    kMeCallBlock(_exchangeBlock);
}



@end
