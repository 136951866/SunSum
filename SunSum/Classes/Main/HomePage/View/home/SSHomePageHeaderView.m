//
//  SSHomePageHeaderView.m
//  SunSum
//
//  Created by hank on 2018/9/6.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSHomePageHeaderView.h"
#import "SSAdModel.h"
#import "SSHomePageVC.h"
#import "SSProductDetailsVC.h"
#import "SSActiveVC.h"
#import "SSVActiveListVC.h"

@interface SSHomePageHeaderView()<SDCycleScrollViewDelegate>{
    NSArray *_arrModel;
}

@property(nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong) SSHomeHeaderMenuView *menuView;
//@property(nonatomic,strong) UIImageView *rimgPic;
//@property(nonatomic,strong) UIImageView *limgPic;
@property(nonatomic,strong) UILabel *lblTitle;
@property(nonatomic,strong) UIImageView *imgPic;
@property(nonatomic,strong) SSHomeSearchView *searchView;

@end

@implementation SSHomePageHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.cycleScrollView.contentMode = UIViewContentModeScaleAspectFill;
        self.cycleScrollView.clipsToBounds = YES;
        [self addSubview:self.searchView];
        [self addSubview:self.cycleScrollView];
        [self addSubview:self.lblTitle];
//        [self addSubview:self.limgPic];
//        [self addSubview:self.rimgPic];
         [self addSubview:self.imgPic];
    }
    return self;
}

- (void)setArrModel:(NSArray *)arrModel{
    _arrModel = arrModel;
    _cycleScrollView.height = 255*kMeFrameScaleY();
    __block NSMutableArray *arrImage = [NSMutableArray array];
    [arrModel enumerateObjectsUsingBlock:^(SSAdModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrImage addObject:kMeUnNilStr(model.ad_img)];
    }];
    self.cycleScrollView.contentMode = UIViewContentModeScaleAspectFill;
    self.cycleScrollView.clipsToBounds = YES;
    self.cycleScrollView.imageURLStringsGroup = arrImage;
}

- (void)ltapActionAction:(UITapGestureRecognizer *)ges{

    SSHomePageVC *home = (SSHomePageVC *)[SSCommonTool getVCWithClassWtihClassName:[SSHomePageVC class] targetResponderView:self];
    if(home){
        SSVActiveListVC *vc = [[SSVActiveListVC alloc]init];
        [home.navigationController pushViewController:vc animated:YES];
    }
}

- (void)rtapActionAction:(UITapGestureRecognizer *)ges{
    if([SSUserInfoModel isLogin]){
        SSHomePageVC *home = (SSHomePageVC *)[SSCommonTool getVCWithClassWtihClassName:[SSHomePageVC class] targetResponderView:self];
        if(home){
            SSActiveVC *avc = [[SSActiveVC alloc]init];
            [home.navigationController pushViewController:avc animated:YES];
        }
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            SSHomePageVC *home = (SSHomePageVC *)[SSCommonTool getVCWithClassWtihClassName:[SSHomePageVC class] targetResponderView:strongSelf];
            if(home){
                SSActiveVC *avc = [[SSActiveVC alloc]init];
                [home.navigationController pushViewController:avc animated:YES];
            }
        } failHandler:nil];
    }
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    SSAdModel *model = kMeUnArr(_arrModel)[index];
    SSHomePageVC *homeVC = (SSHomePageVC *)[SSCommonTool getVCWithClassWtihClassName:[SSHomePageVC class] targetResponderView:self];
    if(homeVC){
        SSProductDetailsVC *dvc = [[SSProductDetailsVC alloc]initWithId:model.product_id];
        [homeVC.navigationController pushViewController:dvc animated:YES];
    }
}

- (SDCycleScrollView *)cycleScrollView{
    if(!_cycleScrollView){
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, kSSHomeSearchViewHeight, SCREEN_WIDTH, 255*kMeFrameScaleY()) imageURLStringsGroup:nil];
        _cycleScrollView.contentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.clipsToBounds = YES;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.pageControlStyle =SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.autoScrollTimeInterval = 4;
        _cycleScrollView.delegate =self;
        _cycleScrollView.backgroundColor = [UIColor clearColor];
        _cycleScrollView.placeholderImage = kImgBannerPlaceholder;
        _cycleScrollView.currentPageDotColor = kSSPink;
    }
    return _cycleScrollView;
}

- (void)tapActionAction:(UITapGestureRecognizer *)ges{
    if([SSUserInfoModel isLogin]){
        SSHomePageVC *home = (SSHomePageVC *)[SSCommonTool getVCWithClassWtihClassName:[SSHomePageVC class] targetResponderView:self];
        if(home){
            SSActiveVC *avc = [[SSActiveVC alloc]init];
            [home.navigationController pushViewController:avc animated:YES];
        }
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            SSHomePageVC *home = (SSHomePageVC *)[SSCommonTool getVCWithClassWtihClassName:[SSHomePageVC class] targetResponderView:strongSelf];
            if(home){
                SSActiveVC *avc = [[SSActiveVC alloc]init];
                [home.navigationController pushViewController:avc animated:YES];
            }
        } failHandler:nil];
    }
    
}

//- (SSHomeHeaderMenuView *)menuView{
//    if(!_menuView){
//        _menuView = [[[NSBundle mainBundle]loadNibNamed:@"SSHomeHeaderMenuView" owner:nil options:nil] lastObject];
//        _menuView.frame = CGRectMake(0, 254*kMeFrameScaleY(), SCREEN_WIDTH, kSSHomeHeaderMenuViewHeight);
//    }
//    return _menuView;
//}

//- (UIImageView *)limgPic{
//    if(!_limgPic){
//        _limgPic = [[UIImageView alloc]initWithFrame:CGRectMake(k15Margin, 254*kMeFrameScaleY() + 48, (SCREEN_WIDTH - (k15Margin *3))/2, kSSHomeHeaderMenuViewHeight)];
////        _limgPic.image = [UIImage imageNamed:@"lwrtltu"];
////        kSDLoadImg(_limgPic, <#url#>)
//        [_limgPic sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"ccfghgitfcfnaq"]];
//        _limgPic.contentMode = UIViewContentModeScaleAspectFill;
//        _limgPic.layer.cornerRadius = 5;
//        _limgPic.clipsToBounds = YES;
//        _limgPic.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ltapActionAction:)];
//        [_limgPic addGestureRecognizer:tap];
//    }
//    return _limgPic;
//}
//
//- (UIImageView *)rimgPic{
//    if(!_rimgPic){
//        _rimgPic = [[UIImageView alloc]initWithFrame:CGRectMake(self.limgPic.right + k15Margin, 254*kMeFrameScaleY() + 48, (SCREEN_WIDTH - (k15Margin *3))/2, kSSHomeHeaderMenuViewHeight)];
//        _rimgPic.contentMode = UIViewContentModeScaleAspectFill;
////        _rimgPic.image = [UIImage imageNamed:@"lwrtltu"];
//        [_rimgPic sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"980itfcfnaq"]];
//        _rimgPic.layer.cornerRadius = 5;
//        _rimgPic.clipsToBounds = YES;
//        _rimgPic.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rtapActionAction:)];
//        [_rimgPic addGestureRecognizer:tap];
//    }
//    return _rimgPic;
//}

- (UILabel *)lblTitle{
    if(!_lblTitle){
        _lblTitle = [SSView lblWithFram:CGRectMake(k15Margin, 254*kMeFrameScaleY()+k15Margin+kSSHomeSearchViewHeight, SCREEN_WIDTH-(k15Margin*2), 18) textColor:kSSblack str:@"980活动" font:[UIFont systemFontOfSize:15]];
    }
    return _lblTitle;
}

- (UIImageView *)imgPic{
    if(!_imgPic){
        _imgPic = [[UIImageView alloc]initWithFrame:CGRectMake(k15Margin, 254*kMeFrameScaleY() + 48+kSSHomeSearchViewHeight, SCREEN_WIDTH - (k15Margin *2), kSSHomeHeaderMenuViewHeight)];
        _imgPic.image = [UIImage imageNamed:@"lwrtltu"];
        _imgPic.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionAction:)];
        [_imgPic addGestureRecognizer:tap];
    }
    return _imgPic;
}

- (SSHomeSearchView *)searchView{
    if(!_searchView){
        _searchView = [[[NSBundle mainBundle]loadNibNamed:@"SSHomeSearchView" owner:nil options:nil] lastObject];
        _searchView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kSSHomeSearchViewHeight);
        kMeWEAKSELF
        _searchView.searchBlock = ^{
            kMeSTRONGSELF
            kMeCallBlock(strongSelf->_searchBlock);
        };
        _searchView.filetBlock = ^{
            kMeSTRONGSELF
            kMeCallBlock(strongSelf->_filetBlock);
        };
    }
    return _searchView;
}


@end
