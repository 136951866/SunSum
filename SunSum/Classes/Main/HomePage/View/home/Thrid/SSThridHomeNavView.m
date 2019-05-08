//
//  SSThridHomeNavView.m
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSThridHomeNavView.h"
#import "SSThridHomeVC.h"
#import "SSProductSearchVC.h"
#import "SSRCConversationListVC.h"
//#import "SSNoticeTypeVC.h"
#import "SSNoticeVC.h"
#import "SSFilterVC.h"
#import "SSStoreModel.h"

@interface SSThridHomeNavView (){
    CGFloat _top;
    CGFloat _touchArea;
}

@property (nonatomic, strong)UIView *viewForBack;
@property (nonatomic, strong)UIButton *btnNotice;
@property (nonatomic, strong)UIButton *btnSort;
@property (nonatomic, strong)UIView *viewForSearch;
@property (nonatomic, strong)UIImageView *imageForSearch;
@property (nonatomic, strong)UIView *viewForUnread;
//@property (nonatomic, strong)UIView *viewForStore;
//
//@property (nonatomic, strong)UIImageView *imgStore;
//@property (nonatomic, strong)UILabel *lblStoreName;
@end

@implementation SSThridHomeNavView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.userInteractionEnabled = NO;
        [self addSubUIView];
    }
    return self;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    if(point.y <_touchArea){
//        return YES;
//    }else{
//        return NO;
//    }
//}

- (void)addSubUIView{
    self.userInteractionEnabled = YES;
    _top = ((IS_iPhoneX==YES||IS_IPHONE_Xr==YES||IS_IPHONE_Xs==YES||IS_IPHONE_Xs_Max==YES) ? 36 : 25);
//    _touchArea = kSSThridHomeNavViewHeight-(k5Margin*4)-kImgStore;
    [self addSubview:self.viewForBack];
    [self addSubview:self.viewForSearch];
    [self.viewForSearch addSubview:self.imageForSearch];
    [self addSubview:self.btnNotice];
    [self addSubview:self.btnSort];
    [self addSubview:self.viewForUnread];
//    [self addSubview:self.viewForStore];
    self.viewForUnread.hidden = YES;
}

- (void)setRead:(BOOL)read{
    self.viewForUnread.hidden = read;
}

- (void)searchProduct{
    SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
    if(homeVC){
        SSProductSearchVC *svc = [[SSProductSearchVC alloc]init];
        [homeVC.navigationController pushViewController:svc animated:NO];
    }
}

- (UIView *)viewForUnread{
    if(!_viewForUnread){
        _viewForUnread = [[UIView alloc]initWithFrame:CGRectMake(self.btnNotice.right-12, self.btnNotice.top+5,6, 6)];
        _viewForUnread.backgroundColor = [UIColor redColor];
        _viewForUnread.cornerRadius = 3;
        _viewForUnread.clipsToBounds = YES;
    }
    return _viewForUnread;
}

- (UIView *)viewForBack{
    if(!_viewForBack){
//        _viewForBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSSThridHomeNavViewHeight-(k5Margin*4)-kImgStore)];
        _viewForBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSSThridHomeNavViewHeight)];
        _viewForBack.backgroundColor = kSSea3782;
        _viewForBack.alpha = 0;
    }
    return _viewForBack;
}

//- (UIView *)viewForStore{
//    if(!_viewForStore){
//        _viewForStore.userInteractionEnabled = NO;
//        _viewForStore = [[UIView alloc]initWithFrame:CGRectMake(0, self.viewForBack.bottom, SCREEN_WIDTH, kImgStore+(k5Margin *4))];
//        _viewForStore.backgroundColor = [UIColor clearColor];
//        _viewForStore.alpha = 0;
//
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, k5Margin, SCREEN_WIDTH-20, kImgStore+(k5Margin*2))];
//        view.cornerRadius = (kImgStore+(k5Margin*2))/2;
//        view.clipsToBounds = YES;
//        view.backgroundColor = [UIColor blackColor];
//        view.alpha = 0.7;
//        view.userInteractionEnabled = NO;
//        [_viewForStore addSubview:view];
//
//        _imgStore = [[UIImageView alloc]initWithFrame:CGRectMake(10+((kImgStore+(k5Margin*2))/2), k5Margin*2, kImgStore, kImgStore)];
//        _imgStore.userInteractionEnabled = NO;
//        [_viewForStore addSubview:_imgStore];
//
//        _lblStoreName = [[UILabel alloc]initWithFrame:CGRectMake(_imgStore.right+10, k5Margin*2, self.width-kImgStore-(10+((kImgStore+(k5Margin*2))/2))-20, kImgStore)];
//        _lblStoreName.userInteractionEnabled = NO;
//        _lblStoreName.textColor = [UIColor whiteColor];
//        _lblStoreName.font = kMeFont(15);
//        [_viewForStore addSubview:_lblStoreName];
//    }
//    return _viewForStore;
//}




- (UIView *)viewForSearch{
    if(!_viewForSearch){
        _viewForSearch = [[UIView alloc]initWithFrame:CGRectMake(self.btnNotice.right+10, _top, self.width-110, 35)];
        _viewForSearch.backgroundColor = [UIColor whiteColor];
        _viewForSearch.cornerRadius = 35/2;
        _viewForSearch.clipsToBounds = YES;
        UITapGestureRecognizer *search = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchProduct)];
        _viewForSearch.userInteractionEnabled = YES;
        [_viewForSearch addGestureRecognizer:search];
    }
    return _viewForSearch;
}

- (UIButton *)btnNotice{
    if(!_btnNotice){
        _btnNotice = [SSView btnWithFrame:CGRectMake(10, _top, 35, 35) Img:[UIImage imageNamed:@"thirdHomeNotice"]];
        [_btnNotice addTarget:self action:@selector(noticeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnNotice;
}

- (UIButton *)btnSort{
    if(!_btnSort){
        _btnSort = [SSView btnWithFrame:CGRectMake(self.viewForSearch.right+10, self.viewForSearch.top, 35, 35) Img:[UIImage imageNamed:@"thirdHomeSort"]];
        [_btnSort addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSort;
}

- (void)noticeAction:(UIButton*)btn{
    if([SSUserInfoModel isLogin]){
        [self toNotice];
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            [strongSelf toNotice];
        } failHandler:nil];
    }
}

- (void)sortAction:(UIButton*)btn{
     SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
    if(homeVC){
        SSFilterVC *vc = [[SSFilterVC alloc]init];
        [homeVC.navigationController pushViewController:vc animated:YES];
    }
}

- (void)toNotice{
    SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
//        if([kCurrentUser.mobile isEqualToString:AppstorePhone]){
//            SSRCConversationListVC *svc = [[SSRCConversationListVC alloc]init];
//            [homeVC.navigationController pushViewController:svc animated:YES];
//        }else{
        if(homeVC){
            SSNoticeVC *svc = [[SSNoticeVC alloc]init];
            [homeVC.navigationController pushViewController:svc animated:YES];
        }
//    }
}

- (UIImageView *)imageForSearch{
    if(!_imageForSearch){
        _imageForSearch = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchHome"]];
        _imageForSearch.contentMode = UIViewContentModeScaleAspectFit;
        _imageForSearch.frame = CGRectMake(10, 9.5, 16, 16);
    }
    return _imageForSearch;
}

- (void)setBackAlpha:(CGFloat)alpha{
    _viewForBack.alpha = alpha;
//    _viewForStore.alpha = alpha;
    if(alpha>1){
        _viewForBack.alpha = 1;
//        _viewForStore.alpha = 1;
    }
    if(alpha<0){
        _viewForBack.alpha = 0;
//        _viewForStore.alpha = 0;
    }
}

//- (void)setStroeBackAlpha:(CGFloat)alpha{
////    _viewForBack.alpha = alpha;
//    _viewForStore.alpha = alpha;
//    if(alpha>1){
////        _viewForBack.alpha = 1;
//        _viewForStore.alpha = 1;
//    }
//    if(alpha<0){
////        _viewForBack.alpha = 0;
//        _viewForStore.alpha = 0;
//    }
//}


@end
