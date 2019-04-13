//
//  SSNewHomePage.m
//  SunSum
//
//  Created by hank on 2018/11/5.
//  Copyright © 2018年 hank. All rights reserved.
//  已废弃

#import "SSNewHomePage.h"
#import "SSNewHomePageHeaderView.h"
#import "SSHomePageSaveModel.h"
#import "SSAdModel.h"
#import "SSNewBaoQiangCell.h"
#import "SSGoodModel.h"
#import "SSHomeGoodModel.h"
#import "SSNewActiveCell.h"
#import "SSNewHomeMainCell.h"
#import "SSGoodModel.h"
#import "SSProductListVC.h"
#import "SSProductDetailsVC.h"
#import "SSActiveVC.h"
#import "SSServiceDetailsVC.h"
#import "SSRushBuyView.h"
#import "SSNetListModel.h"
#import "SSNoticeVC.h"

#import "SSPosterListVC.h"
#import "SSArticleListVC.h"
#import "SSVisiterHomeVC.h"
#import "SSSNewHomePageVC.h"

typedef enum : NSUInteger {
    KMeHomeTypeCommond = 0,
    KMeHomeTypeActive = 1,
    KMeHomeTypeProduct = 2,
    KMeHomeTypeService = 3
} KMeHomeType;

const static CGFloat kSectionViewHeight = 67;

@interface SSNewHomePage ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>{
    KMeHomeType _type;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic,strong) SSNewHomePageHeaderView *headerView;
@property (nonatomic, strong) SDCycleScrollView *sdView;
@property (nonatomic,strong) NSArray *arrMainProductModel;
@property (nonatomic,strong) NSArray *arrMainPrjoctModel;
@property (nonatomic,strong) NSArray *arrMainTopModel;
@property (nonatomic,strong) NSArray *arrAdModel;
@end

@implementation SSNewHomePage

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    _type = KMeHomeTypeCommond;
    [self.view addSubview:self.headerView];
    NSLog(@"%@",@(self.headerView.height));
    self.tableView.tableHeaderView = self.sdView;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNetWork)];
    [self.tableView.mj_header beginRefreshing];
//    [self getRushGood];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUnInfo) name:kUnNoticeMessage object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogout) name:kUserLogout object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogin) name:kUserLogin object:nil];
}

//- (void)userLogout{
//    self.headerView.viewForUnread.hidden =YES;
//}
//
//- (void)userLogin{
//    [self getUnInfo];
//}

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
//                    if(strongSelf->_headerView){
//                        strongSelf.headerView.viewForUnread.hidden =!unread;
//                    }
//                });
//            }
//        } failure:^(id object) {
//            
//        }];
//    }
//}

//- (void)getRushGood{
//    kMeWEAKSELF
//    [SSPublicNetWorkTool postRushGoodWithsuccessBlock:^(ZLRequestResponse *responseObject) {
//        if([responseObject.data isKindOfClass:[NSDictionary class]]){
//            SSAdModel *model = [SSAdModel mj_objectWithKeyValues:responseObject.data];
//            [SSRushBuyView ShowWithModel:model tapBlock:^{
//                kMeSTRONGSELF
//                strongSelf.tabBarController.selectedIndex = 0;
//                SSProductDetailsVC *dvc = [[SSProductDetailsVC alloc]initWithId:model.product_id];
//                [strongSelf.navigationController pushViewController:dvc animated:YES];
//            } cancelBlock:^{
//
//            } superView:weakSelf.view];
//        }
//    } failure:^(id object) {
//
//    }];
//}

- (void)requestNetWork{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    kMeWEAKSELF
    //ad
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postAdWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            if([responseObject.data isKindOfClass:[NSDictionary class]]){
                NSArray *banner_headArr = responseObject.data[@"banner_head"];
                NSArray *arr = [SSAdModel mj_objectArrayWithKeyValuesArray:banner_headArr];
                [SSHomePageSaveModel saveAdsModel:arr];
                strongSelf.arrAdModel = arr;
                dispatch_semaphore_signal(semaphore);
            }else{
                strongSelf.arrAdModel = [SSHomePageSaveModel getAdsModel];
                dispatch_semaphore_signal(semaphore);
            }
        } failure:^(id object) {
            kMeSTRONGSELF
            strongSelf.arrAdModel = [SSHomePageSaveModel getAdsModel];
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    //top
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postGoodsListTopWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            SSNetListModel *lmode = [SSNetListModel mj_objectWithKeyValues:responseObject.data];
            NSArray *arr = [SSGoodModel mj_objectArrayWithKeyValuesArray:lmode.data];
            strongSelf.arrMainTopModel = arr;
            [SSHomePageSaveModel saveHotModel:arr];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            kMeSTRONGSELF
            strongSelf.arrMainTopModel = [SSHomePageSaveModel getHotModel];
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    //product
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postHomeRecommendWithsuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            SSNetListModel *lmode = [SSNetListModel mj_objectWithKeyValues:responseObject.data];
            NSArray *arr = [SSGoodModel mj_objectArrayWithKeyValuesArray:lmode.data];
            strongSelf.arrMainProductModel = arr;
            [SSHomePageSaveModel saveProductModel:arr];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            kMeSTRONGSELF
            strongSelf.arrMainProductModel = [SSHomePageSaveModel getProductModel];
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postGoodsTypeWithArticleCategoryId:20 successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            SSHomeGoodModel *model = [SSHomeGoodModel mj_objectWithKeyValues:responseObject.data];
            NSArray *arr = model.goodsList;
            strongSelf.arrMainPrjoctModel = arr;
            [SSHomePageSaveModel saveServiceModel:arr];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            kMeSTRONGSELF
            strongSelf.arrMainPrjoctModel = [SSHomePageSaveModel getServiceModel];
            dispatch_semaphore_signal(semaphore);
        }];
        
    });
    
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            kMeSTRONGSELF
            strongSelf.headerView.frame = CGRectMake(0, kMeStatusBarHeight, SCREEN_WIDTH, kSSNewHomePageHeaderViewHeight);
            [strongSelf setAdUI];
//            [strongSelf getUnInfo];
            [strongSelf.tableView.mj_header endRefreshing];
            [strongSelf.tableView reloadData];
        });
    });
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    switch (_type) {
        case KMeHomeTypeCommond:
            return  3;
            break;
        case KMeHomeTypeActive:
            return  1;
            break;
        case KMeHomeTypeProduct:
            return  1;
            break;
        case KMeHomeTypeService:
            return  1;
            break;
        default:
            return  0;
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (_type) {
        case KMeHomeTypeCommond:
            switch (section) {
                case KMeHomeTypeCommond:
                    return 1;
                    break;
                case KMeHomeTypeActive:
                    return 1;
                    break;
                case KMeHomeTypeProduct:
                    return self.arrMainProductModel.count;
                    break;
//                case KMeHomeTypeService:
//                    return self.arrMainPrjoctModel.count;
//                    break;
                default:
                    return 0;
                    break;
            }
            return  4;
            break;
        case KMeHomeTypeActive:
            return  1;
            break;
        case KMeHomeTypeProduct:
            return  self.arrMainProductModel.count;
            break;
        case KMeHomeTypeService:
            return  self.arrMainPrjoctModel.count;
            break;
        default:
            return  0;
            break;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_type) {
        case KMeHomeTypeCommond:
            switch (indexPath.section) {
                case KMeHomeTypeCommond:{
                    SSNewBaoQiangCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSNewBaoQiangCell class]) forIndexPath:indexPath];
                    [cell setUIWithArr:self.arrMainTopModel];
                    kMeWEAKSELF
                    cell.indexBlock = ^(NSInteger index) {
                        kMeSTRONGSELF
                        SSGoodModel *model = self.arrMainTopModel[index];
                        SSProductDetailsVC *dvc = [[SSProductDetailsVC alloc]initWithId:model.product_id];
                        [strongSelf.navigationController pushViewController:dvc animated:YES];
                    };
                    return cell;
                }
                    break;
                case KMeHomeTypeActive:
                {
                    SSNewActiveCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSNewActiveCell class]) forIndexPath:indexPath];
                    return cell;
                }
                    break;
                case KMeHomeTypeProduct:{
                    SSNewHomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSNewHomeMainCell class]) forIndexPath:indexPath];
                    SSGoodModel *model = self.arrMainProductModel[indexPath.row];
                    [cell setUIWithModel:model];
                    return cell;
                }
                    break;
//                case KMeHomeTypeService:{
//                    SSNewHomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSNewHomeMainCell class]) forIndexPath:indexPath];
//                     SSGoodModel *model = self.arrMainPrjoctModel[indexPath.row];
//                    [cell setServiceUIWithModel:model];
//                    return cell;
//                }
//                    break;
                default:
                    return 0;
                    break;
            }
            break;
        case KMeHomeTypeActive:{
            SSNewActiveCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSNewActiveCell class]) forIndexPath:indexPath];
            return cell;
        }
            break;
        case KMeHomeTypeProduct:{
               SSNewHomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSNewHomeMainCell class]) forIndexPath:indexPath];
               SSGoodModel *model = self.arrMainProductModel[indexPath.row];
               [cell setUIWithModel:model];
               return cell;
        }
            break;
        case KMeHomeTypeService:{
            SSNewHomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSNewHomeMainCell class]) forIndexPath:indexPath];
            SSGoodModel *model = self.arrMainPrjoctModel[indexPath.row];
            [cell setServiceUIWithModel:model];
            return cell;
        }
            break;
        default:
            return  [UITableViewCell new];
            break;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_type) {
        case KMeHomeTypeCommond:
            switch (indexPath.section) {
                case KMeHomeTypeCommond:{
                    return kSSNewBaoQiangCellHeight;
                }
                    break;
                case KMeHomeTypeActive:
                    return kSSNewActiveCellHeight;
                    break;
                case KMeHomeTypeProduct:
                    return [SSNewHomeMainCell getCellHeight];
                    break;
//                case KMeHomeTypeService:
//                    return [SSNewHomeMainCell getCellHeight];
//                    break;
                default:
                    return 0;
                    break;
            }
            break;
        case KMeHomeTypeActive:
            return kSSNewActiveCellHeight;
            break;
        case KMeHomeTypeProduct:
            return [SSNewHomeMainCell getCellHeight];;
            break;
        case KMeHomeTypeService:
            return  [SSNewHomeMainCell getCellHeight];;
            break;
        default:
            return  1;
            break;
    }
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_type) {
        case KMeHomeTypeCommond:
            switch (indexPath.section) {
                case KMeHomeTypeActive:{
                    [self aciveAction];
                }
                    break;
                case KMeHomeTypeProduct:{
                    SSGoodModel *model = self.arrMainProductModel[indexPath.row];
                    SSProductDetailsVC *dvc = [[SSProductDetailsVC alloc]initWithId:model.product_id];
                    [self.navigationController pushViewController:dvc animated:YES];
                }
                    
                    break;
//                case KMeHomeTypeService:{
//                    SSGoodModel *model = self.arrMainPrjoctModel[indexPath.row];
//                    SSServiceDetailsVC *dvc = [[SSServiceDetailsVC alloc]initWithId:model.product_id];
//                    [self.navigationController pushViewController:dvc animated:YES];
//                }
//                    break;
                default:
                    break;
            }
            break;
        case KMeHomeTypeActive:
             [self aciveAction];
            break;
        default:
            break;
    }
}

- (void)aciveAction{

//    SSArticleListVC *vc = [[SSArticleListVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    if([SSUserInfoModel isLogin]){
            SSActiveVC *avc = [[SSActiveVC alloc]init];
            [self.navigationController pushViewController:avc animated:YES];
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            SSActiveVC *avc = [[SSActiveVC alloc]init];
            [strongSelf.navigationController pushViewController:avc animated:YES];
        } failHandler:nil];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (_type) {
        case KMeHomeTypeCommond:
            switch (section) {
                case KMeHomeTypeCommond:{
                    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
                    view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
                    return view;
                }
                    break;
                case KMeHomeTypeActive:{
                        UIView *view = [self getSectionViewWithTitle:@"活动专区"];
                        return  view;
                }
                    break;
                case KMeHomeTypeProduct:{
                    UIView *view = [self getSectionViewWithTitle:@"产品选购"];
                    return  view;
                }
                    break;
//                case KMeHomeTypeService:{
//                    UIView *view = [self getSectionViewWithTitle:@"服务选购"];
//                    return  view;
//                }
//                    break;
                default:
                    return 0;
                    break;
            }
            break;
        case KMeHomeTypeActive:{
            UIView *view = [self getSectionViewWithTitle:@"活动专区"];
            return  view;
        }
        break;
        case KMeHomeTypeProduct:{
            UIView *view = [self getSectionViewWithTitle:@"产品选购"];
            return  view;
        }
            break;
        case KMeHomeTypeService:{
            UIView *view = [self getSectionViewWithTitle:@"服务选购"];
            return  view;
        }
            break;
        default:
            {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
                view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
                return view;
            }
            break;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(_type == KMeHomeTypeCommond && section==KMeHomeTypeCommond){
        return 10;
    }else{
        return kSectionViewHeight;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    SSAdModel *model = kMeUnArr(_arrAdModel)[index];
    SSProductDetailsVC *dvc = [[SSProductDetailsVC alloc]initWithId:model.product_id];
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeStatusBarHeight+kSSNewHomePageHeaderViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeStatusBarHeight-kSSNewHomePageHeaderViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSNewBaoQiangCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSNewBaoQiangCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSNewActiveCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSNewActiveCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSNewHomeMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSNewHomeMainCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    }
    return _tableView;
}

- (SSNewHomePageHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSNewHomePageHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, kMeStatusBarHeight, SCREEN_WIDTH, kSSNewHomePageHeaderViewHeight);
        kMeWEAKSELF
        _headerView.selectMemuBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            if(index == KMeHomeTypeProduct){
                SSProductListVC *productList = [[SSProductListVC alloc]initWithType:SSGoodsTypeNetCommendStyle];
                [strongSelf.navigationController pushViewController:productList animated:YES];
                 [strongSelf.headerView returnCommon];
                strongSelf->_type = KMeHomeTypeCommond;
                [strongSelf.tableView reloadData];
                
            }else if (index == KMeHomeTypeService){
                [strongSelf.headerView returnCommon];
                SSProductListVC *productList = [[SSProductListVC alloc]initWithType:SSGoodsTypeNetServiceStyle];
                [strongSelf.navigationController pushViewController:productList animated:YES];
                strongSelf->_type = KMeHomeTypeCommond;
                [strongSelf.tableView reloadData];
            }else{
                strongSelf->_type = index;
                [strongSelf.tableView reloadData];
            }
        };
    }
    return _headerView;
}

- (SDCycleScrollView *)sdView{
    if(!_sdView){
        _sdView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  210*kMeFrameScaleX())];
        _sdView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _sdView.clipsToBounds = YES;
        _sdView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _sdView.pageControlStyle =SDCycleScrollViewPageContolStyleClassic;
        _sdView.autoScrollTimeInterval = 4;
        _sdView.delegate =self;
        _sdView.backgroundColor = [UIColor whiteColor];
        _sdView.placeholderImage = kImgBannerPlaceholder;
        _sdView.currentPageDotColor = kSSPink;
    }
    return _sdView;
}

- (void)setAdUI{
    __block NSMutableArray *arrImage = [NSMutableArray array];
    [_arrAdModel enumerateObjectsUsingBlock:^(SSAdModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrImage addObject:kMeUnNilStr(model.ad_img)];
    }];
    self.sdView.imageURLStringsGroup = arrImage;
}

- (UIView *)getSectionViewWithTitle:(NSString *)title{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSectionViewHeight)];
    view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, kSectionViewHeight-10)];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.backgroundColor = [UIColor whiteColor];
    lbl.font = kMeFont(15);
    lbl.textColor = kSSblack;
    lbl.text = title;
    [view addSubview:lbl];
    return view;
}



@end
