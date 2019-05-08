//
//  SSThridHomeHeaderView.m
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSThridHomeHeaderView.h"
#import "SSThridHomeModel.h"
#import "SSThridHomeVC.h"
#import "SSThridProductDetailsVC.h"
#import "SSServiceDetailsVC.h"
#import "SSMidelButton.h"
#import "SSProductListVC.h"
#import "SSThridRushSpikeVC.h"
#import "SSFilterVC.h"
#import "SSStoreModel.h"
#import "SSStoreDetailModel.h"
#import "SSNewStoreDetailsVC.h"

typedef NS_ENUM(NSUInteger, SSThridHomeHeaderViewActiveType) {
    SSThridHomeHeaderViewActiveNewType = 0,
    SSThridHomeHeaderViewActiveRudeType =1,
    SSThridHomeHeaderViewActiveTbcouponType = 2,
    SSThridHomeHeaderViewActivePinduoduoCouponType = 3,
    SSThridHomeHeaderViewActiveJDType =4,
    SSThridHomeHeaderViewActiveServiceType =5
    
};

@interface SSThridHomeHeaderView ()<SDCycleScrollViewDelegate>{
    SSThridHomeModel *_model;
    SSStoreModel *_storeModel;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSdHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSecondImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consThridImageWidth;

@property (weak, nonatomic) IBOutlet SDCycleScrollView *sdView;
@property (weak, nonatomic) IBOutlet UIImageView *imgFrist;
@property (weak, nonatomic) IBOutlet UIImageView *imgSecond;
@property (weak, nonatomic) IBOutlet UIImageView *imgFristGood;
@property (weak, nonatomic) IBOutlet UIImageView *imgSecondGood;
@property (weak, nonatomic) IBOutlet UIImageView *imgQiao;
@property (weak, nonatomic) IBOutlet UILabel *lblFristGoodTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFristGoodSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSGoodTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSGoodSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblRudeTite;
@property (weak, nonatomic) IBOutlet UILabel *lblRudePrice;
@property (weak, nonatomic) IBOutlet UIView *viewFrist;
@property (weak, nonatomic) IBOutlet UIView *sencodView;
@property (weak, nonatomic) IBOutlet UIView *viewforScard;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consServiceHeight;

@property (weak, nonatomic) IBOutlet UIImageView *imgStore;
@property (weak, nonatomic) IBOutlet UILabel *lblStoreName;
@property (weak, nonatomic) IBOutlet UILabel *lblStoreDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;

@end

@implementation SSThridHomeHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    _btnShare.hidden = ![WXApi isWXAppInstalled];
    _sdView.delegate = self;
//    _lblFristGoodTitle.adjustsFontSizeToFitWidth = YES;
//    _lblSGoodTitle.adjustsFontSizeToFitWidth = YES;

    _consSdHeight.constant = kSdHeight*kMeFrameScaleX();
    _consSecondImageHeight.constant = kSecondImageHeight*kMeFrameScaleX();
    _lblRudePrice.adjustsFontSizeToFitWidth = YES;
    if(kMeFrameScaleX()<1){
       _consThridImageWidth.constant = kThridImageWidth*kMeFrameScaleX();
      _consServiceHeight.constant = kThridImageHeight*kMeFrameScaleX();
    }
    _viewFrist.hidden = YES;
    _sencodView.hidden = YES;
    self.userInteractionEnabled = YES;
    
     //新人专享
    UITapGestureRecognizer *memberExclusiveges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(memberExclusive)];
    _imgFrist.userInteractionEnabled = YES;
    [_imgFrist addGestureRecognizer:memberExclusiveges];
    //抢购商品
    UITapGestureRecognizer *scareBuyingges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scareBuying)];
    _imgSecond.userInteractionEnabled = YES;
    [_imgSecond addGestureRecognizer:scareBuyingges];
    //服务
    
    UITapGestureRecognizer *serviceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(serviceTap)];
    _viewFrist.userInteractionEnabled = YES;
    [_viewFrist addGestureRecognizer:serviceTap];
    
    UITapGestureRecognizer *servicetwoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(servicetwoTap)];
    _sencodView.userInteractionEnabled = YES;
    [_sencodView addGestureRecognizer:servicetwoTap];
    
    //暴抢
    
    UITapGestureRecognizer *scardGoodTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scardGoodTap)];
    _viewforScard.userInteractionEnabled = YES;
    [_viewforScard addGestureRecognizer:scardGoodTap];
}

- (IBAction)shareAction:(UIButton *)sender {
    SSShareTool *shareTool = [SSShareTool me_instanceForTarget:self];
    shareTool.sharWebpageUrl = SSIPShare;
    NSLog(@"%@",SSIPShare);
#warning --
    shareTool.shareTitle = @"棒的APP";
    shareTool.shareDescriptionBody = @"棒的APP";
    shareTool.shareImage = kMeGetAssetImage(@"icon-wgvilogo");
    
    [shareTool shareWebPageToPlatformType:UMSocialPlatformType_WechatSession success:^(id data) {
        NSLog(@"分享成功%@",data);
        [SSPublicNetWorkTool postAddShareWithSuccessBlock:nil failure:nil];
        [SSShowViewTool showMessage:@"分享成功" view:kMeCurrentWindow];
    } failure:^(NSError *error) {
        NSLog(@"分享失败%@",error);
        [SSShowViewTool showMessage:@"分享失败" view:kMeCurrentWindow];
    }];
}

- (IBAction)toStoreAction:(UIButton *)sender {
    SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
    if(_storeModel&&homeVC){
        SSNewStoreDetailsVC *details = [[SSNewStoreDetailsVC alloc]initWithId:_storeModel.store_id];
        [homeVC.navigationController pushViewController:details animated:YES];
    }else{
        homeVC.tabBarController.selectedIndex = 1;
    }
}



//新人专享
- (void)memberExclusive{
    if(!_model.member_exclusive){
        return;
    }
    SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
    if(homeVC){
        SSThridProductDetailsVC *details = [[SSThridProductDetailsVC alloc]initWithId:_model.member_exclusive.product_id];
        [homeVC.navigationController pushViewController:details animated:YES];
    }
}

//抢购商品
- (void)scareBuying{
    if(!_model.scare_buying_banner){
        return;
    }
    SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
    if(homeVC){
        SSThridProductDetailsVC *details = [[SSThridProductDetailsVC alloc]initWithId:_model.scare_buying_banner.product_id];
        [homeVC.navigationController pushViewController:details animated:YES];
    }
}

//服务
- (void)serviceTap{
    if(kMeUnArr(_model.service).count==0){
        return;
    }
    SSThridHomeserviceModel *smodel = _model.service[0];
    SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
    if(homeVC){
        if(_storeModel){
            SSStoreDetailModel *modle = [SSStoreDetailModel modelWithStoreModel:_storeModel];
            SSServiceDetailsVC *details = [[SSServiceDetailsVC alloc]initWithId:smodel.product_id storeDetailModel:modle];
            [homeVC.navigationController pushViewController:details animated:YES];
        }else{
            SSServiceDetailsVC *details = [[SSServiceDetailsVC alloc]initWithId:smodel.product_id];
            [homeVC.navigationController pushViewController:details animated:YES];
        }
    }
}

- (void)servicetwoTap{
    if(kMeUnArr(_model.service).count!=2){
        return;
    }
    SSThridHomeserviceModel *smodel = _model.service[1];
    SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
    if(homeVC){
        if(_storeModel){
            SSStoreDetailModel *modle = [SSStoreDetailModel modelWithStoreModel:_storeModel];
            SSServiceDetailsVC *details = [[SSServiceDetailsVC alloc]initWithId:smodel.product_id storeDetailModel:modle];
            [homeVC.navigationController pushViewController:details animated:YES];
        }else{
            SSServiceDetailsVC *details = [[SSServiceDetailsVC alloc]initWithId:smodel.product_id];
            [homeVC.navigationController pushViewController:details animated:YES];
        }
    }
}

//暴抢
- (void)scardGoodTap{
    if(!kMeUnArr(_model.scare_buying_goods).count){
        return ;
    }
    SSThridHomeBuyingGoodsModel *scare_buying_good = _model.scare_buying_goods[0];
    SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
    if(homeVC){
        SSThridProductDetailsVC *details = [[SSThridProductDetailsVC alloc]initWithId:scare_buying_good.product_id];
        [homeVC.navigationController pushViewController:details animated:YES];
    }
}



- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    SSThridHomeAdModel *model = kMeUnArr(_model.top_banner)[index];
    SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
    if(homeVC){
        SSThridProductDetailsVC *dvc = [[SSThridProductDetailsVC alloc]initWithId:model.product_id];
        [homeVC.navigationController pushViewController:dvc animated:YES];
    }
}

- (void)setUIWithModel:(SSThridHomeModel *)model stroeModel:(SSStoreModel *)storemodel{
    _model = model;
    _storeModel = storemodel;
    __block NSMutableArray *arrImage = [NSMutableArray array];
    [kMeUnArr(model.top_banner) enumerateObjectsUsingBlock:^(SSThridHomeAdModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrImage addObject:kMeUnNilStr(model.ad_img)];
    }];
    _sdView.contentMode = UIViewContentModeScaleAspectFill;
    _sdView.clipsToBounds = YES;
    _sdView.imageURLStringsGroup = arrImage;
    
    //新人专享
    kSDLoadImg(_imgFrist, kMeUnNilStr(model.member_exclusive.img));
    
    //抢购商品
    kSDLoadImg(_imgSecond, kMeUnNilStr(model.scare_buying_banner.img));

    //服务
    for (NSInteger i=0; i<kMeUnArr(model.service).count; i++) {
        SSThridHomeserviceModel *smodel = model.service[i];
        if(i==0){
            _viewFrist.hidden = NO;
            kSDLoadImg(_imgFristGood, SSLoadQiniuImagesWithUrl(kMeUnNilStr(smodel.images)));
            _lblFristGoodTitle.text = kMeUnNilStr(smodel.title);
            _lblFristGoodSubtitle.text = kMeUnNilStr(smodel.desc);
        }
        if(i==1){
            _sencodView.hidden = NO;
            kSDLoadImg(_imgSecondGood, SSLoadQiniuImagesWithUrl(kMeUnNilStr(smodel.images)));
            _lblSGoodTitle.text = kMeUnNilStr(smodel.title);
            _lblSGoodSubtitle.text = kMeUnNilStr(smodel.desc);
        }
    }
    //暴抢
    if(kMeUnArr(model.scare_buying_goods).count){
        _viewforScard.hidden = NO;
        _imgQiao.hidden = NO;
        _lblRudeTite.hidden = NO;
        _lblRudePrice.hidden = NO;
        SSThridHomeBuyingGoodsModel *scare_buying_good = model.scare_buying_goods[0];
    kSDLoadImg(_imgQiao,SSLoadQiniuImagesWithUrl(kMeUnNilStr(scare_buying_good.images)));
        _lblRudeTite.text = kMeUnNilStr(scare_buying_good.title);
        _lblRudePrice.text = [NSString stringWithFormat:@"¥%@",@(kMeUnNilStr(scare_buying_good.money).floatValue)];
    }else{
        _viewforScard.hidden = YES;
        _imgQiao.hidden = YES;
        _lblRudeTite.hidden = YES;
        _lblRudePrice.hidden = YES;
        kSDLoadImg(_imgQiao,@"");
        _lblRudeTite.text = @"";
        _lblRudePrice.text = @"";
    }
    
    //店铺
    if(storemodel){
        kSDLoadImg(_imgStore,kMeUnNilStr(storemodel.mask_img));
        _lblStoreName.text = kMeUnNilStr(storemodel.store_name);
        _lblStoreDesc.text = kMeUnNilStr(storemodel.intro);
    }else{
        _imgStore.image = [UIImage imageNamed:@"icon-wgvilogo"];
        _lblStoreName.text = @"棒的旗舰店";
        _lblStoreDesc.text = @"棒的旗舰店";
    }
    
}

- (IBAction)activeAction:(SSMidelMiddelImageButton *)sender {
    NSInteger index = sender.tag-kMeViewBaseTag;
    SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
    if(homeVC){
        switch (index) {
            case SSThridHomeHeaderViewActiveNewType:
            {
                [self memberExclusive];
            }
                break;
            case SSThridHomeHeaderViewActiveRudeType:
            {
                SSThridRushSpikeVC *vc= [[SSThridRushSpikeVC alloc]init];
                [homeVC.navigationController pushViewController:vc animated:YES];
            }
                break;
            case SSThridHomeHeaderViewActiveTbcouponType:
            {
//                SSCoupleHomeVC *vc= [[SSCoupleHomeVC alloc]initWithIsTbK:YES];
//                [homeVC.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case SSThridHomeHeaderViewActivePinduoduoCouponType:
            {
//                SSCoupleHomeVC *vc= [[SSCoupleHomeVC alloc]initWithIsTbK:NO];
//                [homeVC.navigationController pushViewController:vc animated:YES];

            }
                break;
            case SSThridHomeHeaderViewActiveServiceType:
            {
                SSProductListVC *vc= [[SSProductListVC alloc]initWithType:SSGoodsTypeNetServiceStyle];
                [homeVC.navigationController pushViewController:vc animated:YES];
            }
                break;
            case SSThridHomeHeaderViewActiveJDType:
            {
//                SSFilterVC *vc= [[SSFilterVC alloc]init];
//                [homeVC.navigationController pushViewController:vc animated:YES];
//                SSJDCoupleHomeVC *vc = [[SSJDCoupleHomeVC alloc]init];
//                [homeVC.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}




+ (CGFloat)getViewHeightWithModel:(SSThridHomeModel *)model{
    CGFloat heigth = 873 - kSdHeight - kSecondImageHeight;
    heigth+=(kSdHeight*kMeFrameScaleX());
    heigth+=(kSecondImageHeight*kMeFrameScaleX());
    if(kMeFrameScaleX()<1){
        heigth-=kThridImageHeight;
        heigth+=(kThridImageHeight * kMeFrameScaleX());
    }
    if(!kMeUnArr(model.scare_buying_goods).count){
        heigth -=95;
    }
    return heigth;
}

@end
