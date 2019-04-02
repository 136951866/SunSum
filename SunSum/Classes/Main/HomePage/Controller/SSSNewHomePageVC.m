//
//  SSSNewHomePageVC.m
//  SunSum
//
//  Created by hank on 2018/11/29.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSSNewHomePageVC.h"
#import "SSSNewHomePageView.h"
#import "SSNoticeTypeVC.h"
#import "SSRCConversationListVC.h"
#import "SSVisiterHomeVC.h"
#import "SSFilterVC.h"
#import "SSProductListVC.h"
#import "SSPosterListVC.h"
#import "SSArticelVC.h"
#import "SSProductDetailsVC.h"
#import "SSAdModel.h"
#import "SSRushBuyView.h"
//#import "SSNewHomePage.h"
#import "SSShoppingMallVC.h"
#import "SSSNewHomeActiveVC.h"
#import "SSSActivityModel.h"
#import "ZLWebVC.h"
#import "SSProductDetailsVC.h"
#import "SSCountArticleModel.h"
#import "SSSNewHomeStyle.h"
#import "SSAdvModel.h"
#import "SSArticleDetailVC.h"
#import "SSArticelModel.h"
#import "SSCoupleMailVC.h"
#import "SSGiftVC.h"
#pragma mark - 2.0.5
#import "SSCoupleHomeVC.h"
//#import "SSCoupleFilterVC.h"
#import "SSClerkManngerVC.h"
#import "SSMyDistrbutionVC.h"
#import "SSBynamicPublishVC.h"
#import "SSNoticeVC.h"

@interface SSSNewHomePageVC ()<UIScrollViewDelegate,SSSNewHomePageViewDelegate>{
    CGFloat _allHeight;
    NSString *_noticeStr;//通知数
}
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) SSSNewHomePageView *sContenView;;
@property (nonatomic, strong) SSSActivityModel *activeModel;//banner 和 背景
@property (nonatomic, strong) SSCountArticleModel *countArticelModel;//统计
@property (nonatomic, strong) SSSNewHomeStyle *styleModel;//5个小背景图
@property (nonatomic, strong) NSArray *arrAdv;
@end

@implementation SSSNewHomePageVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _noticeStr = @"0";
    self.navBarHidden = YES;
    _allHeight = [SSSNewHomePageView getViewHeight];
    [self.scrollview addSubview:self.sContenView];
    [self.view addSubview:self.scrollview];
    self.scrollview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNetwork)];
    [self.scrollview.mj_header beginRefreshing];
    [self getRushGood];
    [[NSNotificationCenter defaultCenter] addObserver:self.scrollview.mj_header selector:@selector(beginRefreshing) name:kUnNoticeMessage object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogout) name:kUserLogout object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogin) name:kUserLogin object:nil];
}


- (void)userLogout{
    self.sContenView.lblNotice.text = @"0";
    self.sContenView.lblPoster.text = @"";
    self.sContenView.lblVistor.text = @"0";
    self.sContenView.lblArticle.text = @"";
    _countArticelModel = nil;
    _noticeStr = @"0";
}

- (void)requestNetwork{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [MBProgressHUD showMessage:@"" toView:self.view];
    

    kMeWEAKSELF
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postGetMessageWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            if([responseObject.data isKindOfClass:[NSArray class]]){
                strongSelf.arrAdv = [SSAdvModel mj_objectArrayWithKeyValuesArray:responseObject.data];
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postActivityWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            if([responseObject.data isKindOfClass:[NSDictionary class]]){
                strongSelf.activeModel = [SSSActivityModel mj_objectWithKeyValues:responseObject.data];
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postCountArticleWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            if([responseObject.data isKindOfClass:[NSDictionary class]]){
                strongSelf.countArticelModel = [SSCountArticleModel mj_objectWithKeyValues:responseObject.data];
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool getUserCountListWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            if([responseObject.data isKindOfClass:[NSDictionary class]]){
                NSInteger unread = [responseObject.data integerValue];
                strongSelf->_noticeStr =  @(unread).description;
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
        
//        [SSPublicNetWorkTool getUserHomeUnreadNoticeWithSuccessBlock:^(ZLRequestResponse *responseObject) {
//            kMeSTRONGSELF
//            if([responseObject.data isKindOfClass:[NSDictionary class]]){
//                NSNumber *notice = responseObject.data[@"notice"];
//                NSNumber *order = responseObject.data[@"order"];
//                NSNumber *versions = responseObject.data[@"versions"];
//                NSInteger unread = [notice integerValue] + [order integerValue] +[versions integerValue];
//                strongSelf->_noticeStr =  @(unread).description;
//            }
//            dispatch_semaphore_signal(semaphore);
//        } failure:^(id object) {
//            dispatch_semaphore_signal(semaphore);
//        }];
    });
    
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postMystyleWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            if([responseObject.data isKindOfClass:[NSDictionary class]]){
                strongSelf.styleModel = [SSSNewHomeStyle mj_objectWithKeyValues:responseObject.data];
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            kMeSTRONGSELF
//            [strongSelf getUnInfo];
            [strongSelf setUI];
            [MBProgressHUD hideHUDForView:strongSelf.view];
            [strongSelf.scrollview.mj_header endRefreshing];
        });
    });
}

- (void)setUI{
    if(_sContenView){
        [_sContenView setSdViewWithArr:self.activeModel.banner];
        [_sContenView setAdWithArr:self.arrAdv];
        _sContenView.lblNotice.text = _noticeStr;
        _sContenView.lblArticle.text = [NSString stringWithFormat:@"分享:%@ 阅读:%@",kMeUnNilStr(self.countArticelModel.share),kMeUnNilStr(self.countArticelModel.read)];
        _sContenView.lblPoster.text = [NSString stringWithFormat:@"分享:%@",kMeUnNilStr(self.countArticelModel.share_posters)];
        _sContenView.lblVistor.text = kMeUnNilStr(self.countArticelModel.share_article);
        
        
        //总背景
        [_sContenView.imgBackground sd_setImageWithURL:[NSURL URLWithString:kMeUnNilStr(self.activeModel.background.img)] placeholderImage: [UIImage imageNamed:@"homeb"]];
        
#warning --
        //未读数背景
        [_sContenView.imgTop sd_setImageWithURL:[NSURL URLWithString:kMeUnNilStr(self.styleModel.top_style.img)] placeholderImage: [UIImage imageNamed:@"talt"]];
        //商城->动态 kMeUnNilStr(self.styleModel.shop_style.img)
        [_sContenView.imgShop sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"home_dynal"]];
        //服务->店铺中心 kMeUnNilStr(self.styleModel.store_style.img)
        [_sContenView.imgStore sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"home_center"]];
        //海报
        [_sContenView.imgPoster sd_setImageWithURL:[NSURL URLWithString:kMeUnNilStr(self.styleModel.posters_style.img)] placeholderImage:[UIImage imageNamed:@"tgdmitrb"]];
        //文章
        [_sContenView.imgArticle sd_setImageWithURL:[NSURL URLWithString:kMeUnNilStr(self.styleModel.article_style.img)] placeholderImage:[UIImage imageNamed:@"SSyyuj"]];
        //s优惠卷->商城 kMeUnNilStr(self.styleModel.taobao_coupon_style.img)
        [_sContenView.imgCouple sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"home_mail"]];
        //许愿屋->员工管理 kMeUnNilStr(self.styleModel.gift_style.img)
        [_sContenView.imgGift sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"home_clerk"]];
    }
}

- (void)userLogin{
    [self.scrollview.mj_header beginRefreshing];
}

//- (void)getUnInfo{
//    if([SSUserInfoModel isLogin]){
//        kMeWEAKSELF
//        [SSPublicNetWorkTool getUserHomeUnreadNoticeWithSuccessBlock:^(ZLRequestResponse *responseObject) {
//            if([responseObject.data isKindOfClass:[NSDictionary class]]){
//                NSNumber *notice = responseObject.data[@"notice"];
//                NSNumber *order = responseObject.data[@"order"];
//                NSNumber *versions = responseObject.data[@"versions"];
//                NSInteger unread = [notice integerValue] + [order integerValue] +[versions integerValue];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    kMeSTRONGSELF
//                    if(strongSelf->_sContenView){
//                        strongSelf->_sContenView.lblNotice.text = @(unread).description;
//                    }
////                    [strongSelf.scrollview.mj_header endRefreshing];
//                });
//            }
//        } failure:^(id object) {
////            kMeSTRONGSELF
////            [strongSelf.scrollview.mj_header endRefreshing];
//        }];
//    }else{
////        [self.scrollview.mj_header endRefreshing];
//    }
//}

- (void)getRushGood{
    kMeWEAKSELF
    [SSPublicNetWorkTool postRushGoodWithsuccessBlock:^(ZLRequestResponse *responseObject) {
        if([responseObject.data isKindOfClass:[NSDictionary class]]){
            SSAdModel *model = [SSAdModel mj_objectWithKeyValues:responseObject.data];
            [SSRushBuyView ShowWithModel:model tapBlock:^{
                kMeSTRONGSELF
                strongSelf.tabBarController.selectedIndex = 0;
                SSProductDetailsVC *dvc = [[SSProductDetailsVC alloc]initWithId:model.product_id];
                [strongSelf.navigationController pushViewController:dvc animated:YES];
            } cancelBlock:^{
                
            } superView:weakSelf.view];
        }
    } failure:^(id object) {
        
    }];
}

#pragma mark -SSSNewHomePageViewDelegate

- (void)toNoticeVC{
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

- (void)toNotice{
    SSNoticeVC *svc = [[SSNoticeVC alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
//    if([kCurrentUser.mobile isEqualToString:AppstorePhone]){
//        SSRCConversationListVC *svc = [[SSRCConversationListVC alloc]init];
//        [self.navigationController pushViewController:svc animated:YES];
//    }else{
//        SSNoticeTypeVC *svc = [[SSNoticeTypeVC alloc]init];
//        [self.navigationController pushViewController:svc animated:YES];
//    }
}

- (void)toVisterVC{
    if([SSUserInfoModel isLogin]){
        if(kCurrentUser.user_type == 3){
            SSVisiterHomeVC *svc = [[SSVisiterHomeVC alloc]init];
            [self.navigationController pushViewController:svc animated:YES];
        }else{
            kMeAlter(@"", @"您还不是店铺");
        }
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            if(kCurrentUser.user_type == 3){
                SSVisiterHomeVC *svc = [[SSVisiterHomeVC alloc]init];
                [strongSelf.navigationController pushViewController:svc animated:YES];
            }else{
                kMeAlter(@"", @"您还不是店铺");
            }
        } failHandler:nil];
    }
}

- (void)toProdectVC{
    if([SSUserInfoModel isLogin]){
        if(kCurrentUser.user_type == 3){
            SSBynamicPublishVC *svc = [[SSBynamicPublishVC alloc]init];
            kMeWEAKSELF
            svc.publishSucessBlock = ^{
                kMeSTRONGSELF
                strongSelf.tabBarController.selectedIndex = 2;
            };
            [self.navigationController pushViewController:svc animated:YES];
        }else{
            kMeAlter(@"", @"您还不是店铺");
        }
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            if(kCurrentUser.user_type == 3){
                SSBynamicPublishVC *svc = [[SSBynamicPublishVC alloc]init];
                svc.publishSucessBlock = ^{
                    strongSelf.tabBarController.selectedIndex = 2;
                };
                [strongSelf.navigationController pushViewController:svc animated:YES];
            }else{
                kMeAlter(@"", @"您还不是店铺");
            }
        } failHandler:nil];
    }

    //s店铺动态
//    SSShoppingMallVC *svc = [[SSShoppingMallVC alloc]init];
//    [self.navigationController pushViewController:svc animated:YES];
}

- (void)toServiceVC{
    if([SSUserInfoModel isLogin]){
        if(kCurrentUser.user_type == 3){
            SSMyDistrbutionVC *svc = [[SSMyDistrbutionVC alloc]init];
            [self.navigationController pushViewController:svc animated:YES];
        }else{
            kMeAlter(@"", @"您还不是店铺");
        }
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            if(kCurrentUser.user_type == 3){
                SSMyDistrbutionVC *svc = [[SSMyDistrbutionVC alloc]init];
                [strongSelf.navigationController pushViewController:svc animated:YES];
            }else{
                kMeAlter(@"", @"您还不是店铺");
            }
        } failHandler:nil];
    }

    //s商户中心
//    SSProductListVC *productList = [[SSProductListVC alloc]initWithType:SSGoodsTypeNetServiceStyle];
//    [self.navigationController pushViewController:productList animated:YES];
}

- (void)toCoupleVC{
    //s商城
    SSShoppingMallVC *svc = [[SSShoppingMallVC alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
//    SSCoupleHomeVC *coupleVC = [[SSCoupleHomeVC alloc]init];
//    [self.navigationController pushViewController:coupleVC animated:YES];
}

- (void)toGiftVC{
    //s员工管理
    if([SSUserInfoModel isLogin]){
        if(kCurrentUser.user_type == 3){
            SSClerkManngerVC *svc = [[SSClerkManngerVC alloc]init];
            [self.navigationController pushViewController:svc animated:YES];
        }else{
            kMeAlter(@"", @"您还不是店铺");
        }
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            if(kCurrentUser.user_type == 3){
                SSClerkManngerVC *svc = [[SSClerkManngerVC alloc]init];
                [strongSelf.navigationController pushViewController:svc animated:YES];
            }else{
                kMeAlter(@"", @"您还不是店铺");
            }
        } failHandler:nil];
    }
    
 
    
//    SSGiftVC *coupleVC = [[SSGiftVC alloc]init];
//    [self.navigationController pushViewController:coupleVC animated:YES];
}

- (void)toPosterVC{
    if([SSUserInfoModel isLogin]){
        if(kCurrentUser.user_type == 3){
            SSPosterListVC *svc = [[SSPosterListVC alloc]init];
            [self.navigationController pushViewController:svc animated:YES];
        }else{
            kMeAlter(@"", @"您还不是店铺");
        }
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            if(kCurrentUser.user_type == 3){
                SSPosterListVC *svc = [[SSPosterListVC alloc]init];
                [strongSelf.navigationController pushViewController:svc animated:YES];
            }else{
                kMeAlter(@"", @"您还不是店铺");
            }
        } failHandler:nil];
    }
}

- (void)toArticelVC{
    if([SSUserInfoModel isLogin]){
        if(kCurrentUser.user_type == 3){
            SSArticelVC *svc = [[SSArticelVC alloc]init];
            [self.navigationController pushViewController:svc animated:YES];
        }else{
            kMeAlter(@"", @"您还不是店铺");
        }
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            if(kCurrentUser.user_type == 3){
                SSArticelVC *svc = [[SSArticelVC alloc]init];
                [strongSelf.navigationController pushViewController:svc animated:YES];
            }else{
                kMeAlter(@"", @"您还不是店铺");
            }
        } failHandler:nil];
    }
}

- (void)didSdSelectItemAtIndex:(NSInteger)index{
    if(index> _activeModel.banner.count){
        return;
    }
    SSSActivityContentModel *bModel = _activeModel.banner[index];
    [self tobanerVCWithModel:bModel];
}

- (void)didAdvdSelectItemAtIndex:(NSInteger)index{
    if(index> self.arrAdv.count){
        return;
    }
    //1链接到产品2链接到文章3链接到版本更新4显示内容
    SSAdvModel *model = self.arrAdv[index];
    switch (model.message_type) {
        case 1:{
            SSProductDetailsVC *vc = [[SSProductDetailsVC alloc]initWithId:model.product_id];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            SSArticelModel *modela = [SSArticelModel new];
            modela.article_id = model.article_id;
            SSArticleDetailVC *vc = [[SSArticleDetailVC alloc]initWithModel:modela];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",kSSAppId];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }
            break;
        case 4:{
            ZLWebVC *vc = [[ZLWebVC alloc]init];
            vc.title = kMeUnNilStr(model.title);
            [vc loadWebHTMLSring:kMeUnNilStr(model.content)];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}


- (void)tapBackGround{
    if(_activeModel){
        [self tobanerVCWithModel:_activeModel.background];
    }
}

- (void)tobanerVCWithModel:(SSSActivityContentModel *)model{
    if(model){
        switch (model.show_type) {
            case SSSActivityContentModelProductType:{
                SSProductDetailsVC *vc = [[SSProductDetailsVC alloc]initWithId:model.product_id];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case SSSActivityContentModelHtmlType:{
                SSSNewHomeActiveVC *vc = [[SSSNewHomeActiveVC alloc]initWithContent:model.content];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case SSSActivityContentModelUrlType:{
                ZLWebVC *vc = [[ZLWebVC alloc]initWithUrl:kMeUnNilStr(model.url)];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

- (UIScrollView *)scrollview{
    if(!_scrollview){
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeTabBarHeight)];
        _scrollview.backgroundColor = [UIColor colorWithHexString:@"F1F2F6"];
        _scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, _allHeight);
        _scrollview.bounces = YES;
        _scrollview.showsVerticalScrollIndicator =NO;
        _scrollview.delegate = self;
    }
    return _scrollview;
}

- (SSSNewHomePageView *)sContenView{
    if(!_sContenView){
        _sContenView = [[[NSBundle mainBundle]loadNibNamed:@"SSSNewHomePageView" owner:nil options:nil] lastObject];
        _sContenView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _allHeight);
        _sContenView.deleate = self;
    }
    return _sContenView;
}

- (SSSActivityModel *)activeModel{
    if(!_activeModel){
        _activeModel = [SSSActivityModel new];
    }
    return _activeModel;
}

- (SSCountArticleModel *)countArticelModel{
    if(!_countArticelModel){
        _countArticelModel = [SSCountArticleModel new];
        _countArticelModel.share = @"0";
        _countArticelModel.read = @"0";
        _countArticelModel.share_article = @"0";
        _countArticelModel.share_posters = @"0";
    }
    return _countArticelModel;
}

- (SSSNewHomeStyle *)styleModel{
    if(!_styleModel){
        _styleModel = [SSSNewHomeStyle new];
    }
    return _styleModel;
}

- (NSArray *)arrAdv{
    if(!_arrAdv){
        _arrAdv = [NSArray array];
    }
    return _arrAdv;
}

@end
