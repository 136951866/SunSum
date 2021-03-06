//
//  SSRushBuyView.m
//  SunSum
//
//  Created by hank on 2018/11/6.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSRushBuyView.h"
#import "SSAdModel.h"

#define ImgtopMargin (100*kMeFrameScaleY())
#define BtnTopMargin (20*kMeFrameScaleY())

@interface SSRushBuyView (){
    SSAdModel *_model;
}

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImageView *imgProduct;
@property (nonatomic, strong) UIButton *btnCaner;
@property (nonatomic, strong) UIView *superView;
@property (nonatomic, copy) kMeBasicBlock tapBlock;
@property (nonatomic, copy) kMeBasicBlock cancelBlock;

@end

@implementation SSRushBuyView

- (void)dealloc{
    NSLog(@"SSRushBuyView dealloc");
}

- (instancetype)initWithModel:(SSAdModel *)model superView:(UIView*)superView{
    if(self = [super init]){
        self.frame = superView.bounds;
        [self setUIWithModel:model];
    }
    return self;
}

- (void)setUIWithModel:(SSAdModel *)model {
    _model = model;
    [self addSubview:self.maskView];
    [self addSubview:self.imgProduct];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImg:)];
    [self.imgProduct addGestureRecognizer:ges];
    kSDLoadImg(self.imgProduct, kMeUnNilStr(model.ad_img));
    [self addSubview:self.btnCaner];
}

- (void)touchImg:(UITapGestureRecognizer *)ges{
    [self hide];
    kMeCallBlock(_tapBlock);
}

- (void)hide{
    [self removeFromSuperview];
}

- (void)hideAction:(UIButton *)btn{
    [self hide];
    kMeCallBlock(_cancelBlock);
}

- (void)hideTap:(UITapGestureRecognizer *)ges{
    [self hide];
    kMeCallBlock(_cancelBlock);
}

#pragma mark - Settet And Getter

- (UIView *)maskView{
    if(!_maskView){
        _maskView = [[UIView alloc]initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.8;
        _maskView.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesmask = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideTap:)];
        [_maskView addGestureRecognizer:gesmask];
    }
    return _maskView;
}

- (UIImageView *)imgProduct{
    if(!_imgProduct){
        _imgProduct = [[UIImageView alloc]initWithFrame:CGRectMake(0,ImgtopMargin , SCREEN_WIDTH, SCREEN_WIDTH)];
        _imgProduct.contentMode = UIViewContentModeScaleAspectFit;
        _imgProduct.userInteractionEnabled = YES;
        _imgProduct.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgProduct;
}

- (UIButton *)btnCaner{
    if(!_btnCaner){
        _btnCaner = [SSView btnWithImg:kMeGetAssetImage(@"qaj") title:@"" target:self Action:@selector(hideAction:)];
        _btnCaner.frame = CGRectMake((self.width-36)/2, self.imgProduct.bottom + BtnTopMargin, 36, 36);
        _btnCaner.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _btnCaner;
}

#pragma mark - Public API

+ (void)ShowWithModel:(SSAdModel *)model tapBlock:(kMeBasicBlock)tapBlock cancelBlock:(kMeBasicBlock)cancelBlock superView:(UIView*)superView{
    SSRushBuyView *view = [[SSRushBuyView alloc]initWithModel:model superView:superView];
    view.tapBlock = tapBlock;
    view.cancelBlock = cancelBlock;
    view.superView = superView;
    [superView addSubview:view];
}

@end
