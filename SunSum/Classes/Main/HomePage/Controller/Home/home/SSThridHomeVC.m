//
//  SSThridHomeVC.m
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSThridHomeVC.h"
#import "SSThridHomeHeaderView.h"
#import "SSThridHomeTimeSecionView.h"
#import "SSRushBuyCell.h"
#import "SSThridHomeNavView.h"
#import "SSShoppingMallVC.h"
#import "SSAdModel.h"
#import "SSRushBuyView.h"
#import "SSThridProductDetailsVC.h"
#import "SSThridHomeModel.h"
#import "SSThridHomeRudeTimeModel.h"
#import "SSThridHomeRudeGoodModel.h"
#import "SSNetListModel.h"
#import "SSStoreModel.h"
#import "SSNewStoreDetailsVC.h"

const static CGFloat kImgStore = 50;
@interface SSThridHomeVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSInteger _selectTimeIndex;
    NSArray *_arrRudeBuy;
    NSArray *_arrRudeTime;
    NSArray *_arrCommonCoupon;
    SSThridHomeModel *_homeModel;
    CGFloat _sectionHeaderHeight;
    CGFloat _alphaNum;
    SSStoreModel *_stroeModel;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) SSThridHomeHeaderView *headerView;
@property (nonatomic, strong) SSThridHomeNavView *navView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) UIImageView *imgStore;
@end

@implementation SSThridHomeVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    self.view.backgroundColor = kSSf5f4f4;
    _sectionHeaderHeight = kSSThridHomeNavViewHeight;
    _alphaNum = (kSdHeight*kMeFrameScaleX())+80;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.imgStore];
    _selectTimeIndex = 0;
    _arrRudeBuy = [NSArray array];
    _arrCommonCoupon = [NSArray array];
    _arrRudeTime = [NSArray array];
    _homeModel = [SSThridHomeModel new];
    self.tableView.tableHeaderView = self.headerView;
    [self.refresh addRefreshView];
    [self getRushGood];
    [self getUnInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUnInfo) name:kUnNoticeMessage object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogout) name:kUserLogout object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogin) name:kUserLogin object:nil];
    


}

- (void)userLogout{
    [self.navView setRead:YES];
    _stroeModel = nil;
    [_headerView setUIWithModel:_homeModel stroeModel:_stroeModel];
    _imgStore.image = [UIImage imageNamed:@"icon-wgvilogo"];
//    [_navView setStoreInfoWithModel:_stroeModel];
}

- (void)userLogin{
    [self getUnInfo];
    [self.refresh reload];
}

- (void)getUnInfo{
    if([SSUserInfoModel isLogin]){
        kMeWEAKSELF
        [SSPublicNetWorkTool getUserCountListWithSuccessBlock:^(ZLRequestResponse *responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    kMeSTRONGSELF
                    if(strongSelf->_navView){
                        NSInteger unread = [responseObject.data integerValue];
                        [strongSelf.navView setRead:!unread];
                    }
                });
        } failure:^(id object) {
        }];
    }
}

- (void)getNetWork{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    

    kMeWEAKSELF
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postGetappHomePageDataWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
                strongSelf->_stroeModel = [SSStoreModel mj_objectWithKeyValues:responseObject.data];
            }else{
                strongSelf->_stroeModel = nil;
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            kMeSTRONGSELF
            strongSelf->_stroeModel = nil;
            dispatch_semaphore_signal(semaphore);
        }];
    });
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postThridHomeStyleWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_homeModel = [SSThridHomeModel mj_objectWithKeyValues:responseObject.data];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postGetPinduoduoCommondPoductWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF

            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postThridHomeGetSeckillTimeSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_arrRudeTime =[SSThridHomeRudeTimeModel mj_objectArrayWithKeyValuesArray:responseObject.data];
            for (NSInteger i =0; i<strongSelf->_arrRudeTime.count; i++) {
                SSThridHomeRudeTimeModel *model = strongSelf->_arrRudeTime[i];
                if(model.status==1){
                    strongSelf->_selectTimeIndex = i;
                }
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
        dispatch_async(dispatch_get_main_queue(), ^{
            kMeSTRONGSELF
            [strongSelf->_headerView setUIWithModel:strongSelf->_homeModel stroeModel:strongSelf->_stroeModel];
            if(strongSelf->_stroeModel){
                 kSDLoadImg(strongSelf->_imgStore, kMeUnNilStr(strongSelf->_stroeModel.mask_img));
            }else{
                strongSelf->_imgStore.image = [UIImage imageNamed:@"icon-wgvilogo"];
            }
            strongSelf->_imgStore.hidden = YES;
//            [strongSelf->_navView setStoreInfoWithModel:strongSelf->_stroeModel];
            strongSelf->_headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [SSThridHomeHeaderView getViewHeightWithModel:strongSelf->_homeModel]);
            [strongSelf getRushGoods];
            strongSelf.tableView.tableHeaderView = strongSelf->_headerView;
            [strongSelf.tableView reloadData];
        });
    });
}
-(void)getRushGoods{
    if(!kMeUnArr(_arrRudeTime).count){
        _arrRudeBuy = @[];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    SSThridHomeRudeTimeModel *model = _arrRudeTime[_selectTimeIndex];
    kMeWEAKSELF
    [SSPublicNetWorkTool postThridHomegetSeckillGoodsWithSeckillTime:kMeUnNilStr(model.time) SuccessBlock:^(ZLRequestResponse *responseObject) {
        SSNetListModel *nlModel = [SSNetListModel mj_objectWithKeyValues:responseObject.data];
        kMeSTRONGSELF
        strongSelf->_arrRudeBuy =[SSThridHomeRudeGoodModel mj_objectArrayWithKeyValuesArray:nlModel.data];
        [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(id object) {
        kMeSTRONGSELF
        strongSelf->_arrRudeBuy = @[];
        [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

//弹窗
- (void)getRushGood{
    kMeWEAKSELF
    [SSPublicNetWorkTool postRushGoodWithsuccessBlock:^(ZLRequestResponse *responseObject) {
        if([responseObject.data isKindOfClass:[NSDictionary class]]){
            SSAdModel *model = [SSAdModel mj_objectWithKeyValues:responseObject.data];
            [SSRushBuyView ShowWithModel:model tapBlock:^{
                if(model.product_id!=0){
                    kMeSTRONGSELF
                    strongSelf.tabBarController.selectedIndex = 0;
                    SSThridProductDetailsVC *dvc = [[SSThridProductDetailsVC alloc]initWithId:model.product_id];
                    [strongSelf.navigationController pushViewController:dvc animated:YES];
                }
            } cancelBlock:^{
                
            } superView:weakSelf.view];
        }
    } failure:^(id object) {
        
    }];
}

- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        [self getNetWork];
    }
    return @{@"sort_type":@"12"};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)toStore{
    if(_stroeModel){
        SSNewStoreDetailsVC *details = [[SSNewStoreDetailsVC alloc]initWithId:_stroeModel.store_id];
        [self.navigationController pushViewController:details animated:YES];
    }else{
        self.tabBarController.selectedIndex = 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section?1:2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 1){
        if(_homeModel && _homeModel.coupon_background && _homeModel.coupon_background.product_id){
            SSThridProductDetailsVC *details = [[SSThridProductDetailsVC alloc]initWithId:_homeModel.coupon_background.product_id];
            [self.navigationController pushViewController:details animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(!section){
        return kSSThridHomeTimeSecionViewHeight;
    }
    return 41;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(!section){
        SSThridHomeTimeSecionView *headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SSThridHomeTimeSecionView class])];
        kMeWEAKSELF
        [headview setUIWithArr:_arrRudeTime selectIndex:_selectTimeIndex selectBlock:^(NSInteger index) {
            kMeSTRONGSELF
            strongSelf->_selectTimeIndex = index;
            [strongSelf getRushGoods];
        }];
        return headview;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 41)];
        view.backgroundColor = kSSf6f6f6;
        UILabel *lbl = [SSView lblWithFram:CGRectMake(11, 0, SCREEN_WIDTH-22, 41) textColor:kSSblack str:@"拼多多优惠券" font:kMeFont(16)];
        [view addSubview:lbl];
        return view;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = _sectionHeaderHeight;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        _navView.hidden = NO;
        CGFloat alpha = scrollView.contentOffset.y/kSSThridHomeNavViewHeight;
        [_navView setBackAlpha:alpha];
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y<0) {
        _navView.hidden = YES;
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        [_navView setBackAlpha:1];
        _navView.hidden = NO;
        scrollView.contentInset = UIEdgeInsetsMake(sectionHeaderHeight, 0, 0, 0);
    }
    
    if(scrollView.contentOffset.y>=_alphaNum){
        _imgStore.hidden = NO;
//        if (scrollView.contentOffset.y<=(_alphaNum + kSSThridHomeNavViewHeight)&&scrollView.contentOffset.y>=0) {
//            _navView.hidden = NO;
//            CGFloat alpha = scrollView.contentOffset.y/(kSSThridHomeNavViewHeight+_alphaNum);
//            [_navView setStroeBackAlpha:alpha];
//        } else if (scrollView.contentOffset.y>=(_alphaNum+kSSThridHomeNavViewHeight)) {
//            [_navView setStroeBackAlpha:1];
//            _navView.hidden = NO;
//        }
    }else if (scrollView.contentOffset.y<0){
//        _navView.hidden = YES;
        _imgStore.hidden = YES;
    }else{
         _imgStore.hidden = YES;
//        _navView.hidden = NO;
//        [_navView setStroeBackAlpha:0];
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSRushBuyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSRushBuyCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSThridHomeTimeSecionView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SSThridHomeTimeSecionView class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kSSf5f4f4;
        _tableView.scrollsToTop = NO;
    }
    return _tableView;
}

- (UIImageView *)imgStore{
    if(!_imgStore){
        _imgStore = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-k15Margin-kImgStore, SCREEN_HEIGHT-kMeTabBarHeight-k15Margin-kImgStore, kImgStore, kImgStore)];
        _imgStore.cornerRadius = kImgStore/2;
        _imgStore.clipsToBounds = YES;
        _imgStore.hidden = YES;
        _imgStore.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toStore)];
        [_imgStore addGestureRecognizer:ges];
    }
    return _imgStore;
}

- (SSThridHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSThridHomeHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [SSThridHomeHeaderView getViewHeightWithModel:_homeModel]);
    }
    return _headerView;
}

- (SSThridHomeNavView *)navView{
    if(!_navView){
        _navView = [[SSThridHomeNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSSThridHomeNavViewHeight)];
    }
    return _navView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonduoduokeGetgetGoodsList)];
        _refresh.delegate = self;
        _refresh.isCoupleMater = NO;
        _refresh.isPinduoduoCoupleMater = YES;
        _refresh.isDataInside = YES;
        _refresh.showFailView = NO;
    }
    return _refresh;
}

@end
