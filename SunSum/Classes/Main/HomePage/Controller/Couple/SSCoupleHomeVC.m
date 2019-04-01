//
//  SSCoupleHomeVC.m
//  SunSum
//
//  Created by hank on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCoupleHomeVC.h"
#import "SSCoupleHomeHeaderView.h"
#import "SSCoupleHomeNavView.h"
#import "SSCoupleHomeMainCell.h"
#import "SSCoupleHomeMainGoodGoodsCell.h"
#import "SSCoupleModel.h"
#import "SSCouponSearchVC.h"
#import "SSNavigationVC.h"
#import "SSCoupleMailVC.h"
#import "SSAdModel.h"
#import "SSPinduoduoCoupleModel.h"
#import "SSPinduoduoCouponSearchDataVC.h"

@interface SSCoupleHomeVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSArray *_todayBuy;
    NSArray *_99BuyBuy;
    NSArray *_arrAdv;
}

@property (nonatomic, strong) SSCoupleHomeHeaderView         *headerView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) SSCoupleHomeNavView *navView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign)BOOL isTBk;
@end

@implementation SSCoupleHomeVC

- (instancetype)initWithIsTbK:(BOOL)isTBk{
    if(self = [super init]){
        _isTBk = isTBk;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    self.view.backgroundColor = kSSf5f4f4;
    _todayBuy = [NSArray array];
    _99BuyBuy = [NSArray array];
    _arrAdv = [NSArray array];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    _tableView.tableHeaderView = self.headerView;
    [self.refresh addRefreshView];
}

- (void)requestNetWork{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
        dispatch_group_async(group, queue, ^{
            kMeWEAKSELF
            [SSPublicNetWorkTool postAgetTbkBannerWithsuccessBlock:^(ZLRequestResponse *responseObject) {
                kMeSTRONGSELF
                strongSelf->_arrAdv =  [SSAdModel mj_objectArrayWithKeyValuesArray:responseObject.data];
                dispatch_semaphore_signal(semaphore);
            } failure:^(id object) {
                dispatch_semaphore_signal(semaphore);
            }];
        });
        dispatch_group_async(group, queue, ^{
            kMeWEAKSELF
            [SSPublicNetWorkTool postCoupledgMaterialOptionalWithType:SSCouponSearchTopBuyType successBlock:^(ZLRequestResponse *responseObject) {
                kMeSTRONGSELF
                id arrDIc = responseObject.data[@"tbk_dg_material_optional_response"][@"result_list"][@"map_data"];
                if([arrDIc isKindOfClass:[NSArray class]]){
                    strongSelf->_todayBuy = [SSCoupleModel mj_objectArrayWithKeyValuesArray:arrDIc];
                }
                dispatch_semaphore_signal(semaphore);
            } failure:^(id object) {
                dispatch_semaphore_signal(semaphore);
            }];
        });
        //9.9
        dispatch_group_async(group, queue, ^{
            kMeWEAKSELF
            [SSPublicNetWorkTool postCoupledgMaterialOptionalWithType:SSCouponSearch99BuyType successBlock:^(ZLRequestResponse *responseObject) {
                kMeSTRONGSELF
                id arrDIc = responseObject.data[@"tbk_dg_material_optional_response"][@"result_list"][@"map_data"];
                if([arrDIc isKindOfClass:[NSArray class]]){
                    strongSelf->_99BuyBuy = [SSCoupleModel mj_objectArrayWithKeyValuesArray:arrDIc];
                }
                dispatch_semaphore_signal(semaphore);
            } failure:^(id object) {
                dispatch_semaphore_signal(semaphore);
            }];
        });
        kMeWEAKSELF
        dispatch_group_notify(group, queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_async(dispatch_get_main_queue(), ^{
                kMeSTRONGSELF
                [strongSelf->_headerView setUiWithModel:strongSelf->_arrAdv isTKb:strongSelf->_isTBk];
                [strongSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:0];
            });
        });
}

- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        if(_isTBk){
           [self requestNetWork];
        }else{
            kMeWEAKSELF
            [SSPublicNetWorkTool postAgetTbkBannerWithsuccessBlock:^(ZLRequestResponse *responseObject) {
                kMeSTRONGSELF
                strongSelf->_arrAdv =  [SSAdModel mj_objectArrayWithKeyValuesArray:responseObject.data];
                [strongSelf->_headerView setUiWithModel:strongSelf->_arrAdv isTKb:strongSelf->_isTBk];
            } failure:^(id object) {
            }];
        }
    }
    if(_isTBk){
        return @{@"type":@(SSCouponSearchGoodGoodsType)};
    }else{
        return @{@"sort_type":@"12"};
    }
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    if(_isTBk){
        [self.refresh.arrData addObjectsFromArray:[SSCoupleModel mj_objectArrayWithKeyValuesArray:data]];
    }else{
        [self.refresh.arrData addObjectsFromArray:[SSPinduoduoCoupleModel mj_objectArrayWithKeyValuesArray:data]];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return [UIView new];
    }
    CGFloat imageh = (SCREEN_WIDTH*80)/750;
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"goodgoods"]];
    img.frame = CGRectMake(0, 0, SCREEN_WIDTH, imageh);
    return img;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.1;
    }
    return (SCREEN_WIDTH*80)/750;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return _isTBk?2:0;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(_isTBk){
            if(indexPath.row == 0){
                SSCoupleHomeMainCell *todaycell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSCoupleHomeMainCell class]) forIndexPath:indexPath];
                [todaycell setUIWithArr:_todayBuy type:indexPath.row];
                return todaycell;
            }else if(indexPath.row == 1){
                SSCoupleHomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSCoupleHomeMainCell class]) forIndexPath:indexPath];
                [cell setUIWithArr:_99BuyBuy type:indexPath.row];
                return cell;
            }else{
                return [UITableViewCell new];
            }
        }else{
            return [UITableViewCell new];
        }
    }else{
        SSCoupleHomeMainGoodGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSCoupleHomeMainGoodGoodsCell class]) forIndexPath:indexPath];
        if(_isTBk){
            [cell setUIWithArr:self.refresh.arrData];
        }else{
            [cell setPinduoduoUIWithArr:self.refresh.arrData];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(_isTBk){
            if(indexPath.row == 0){
                return [SSCoupleHomeMainCell getCellHeightWithArr:_todayBuy];
            }else if(indexPath.row == 1){
                return [SSCoupleHomeMainCell getCellHeightWithArr:_99BuyBuy];
            }else{
                return 0;
            }
        }else{
            return 0;
        }
    }else{
        return [SSCoupleHomeMainGoodGoodsCell getCellHeightWithArr:self.refresh.arrData];
    }
}

- (void)searchCoupon{
    kMeWEAKSELF
    SSCouponSearchVC *searchViewController = [SSCouponSearchVC searchViewControllerWithHotSearches:@[] searchBarPlaceholder:@"搜索优惠券" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        kMeSTRONGSELF
        if(strongSelf->_isTBk){
            SSCoupleMailVC *dataVC = [[SSCoupleMailVC alloc]initWithQuery:searchText];
            [searchViewController.navigationController pushViewController:dataVC animated:YES];
        }else{
            SSPinduoduoCouponSearchDataVC *dataVC = [[SSPinduoduoCouponSearchDataVC alloc]initWithQuery:searchText];
            [searchViewController.navigationController pushViewController:dataVC animated:YES];
        }
        
    }];
    [searchViewController setSearchHistoriesCachePath:kSSCouponSearchVCSearchHistoriesCachePath];
    SSNavigationVC *nav = [[SSNavigationVC alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSCoupleHomeMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSCoupleHomeMainCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSCoupleHomeMainGoodGoodsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSCoupleHomeMainGoodGoodsCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kSSf5f4f4;
    }
    return _tableView;
}

- (SSCoupleHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSCoupleHomeHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH, [SSCoupleHomeHeaderView getViewHeightWithisTKb:_isTBk]);
        [_headerView setUiWithModel:@[] isTKb:_isTBk];
    }
    return _headerView;
}

- (SSCoupleHomeNavView *)navView{
    if(!_navView){
        _navView = [[[NSBundle mainBundle]loadNibNamed:@"SSCoupleHomeNavView" owner:nil options:nil] lastObject];
        _navView.frame =CGRectMake(0, 0, SCREEN_WIDTH, kMeNavBarHeight);
        kMeWEAKSELF
        _navView.backBlock = ^{
            kMeSTRONGSELF
            [strongSelf.navigationController popViewControllerAnimated:YES];
        };
        _navView.searchBlock = ^{
            kMeSTRONGSELF
            [strongSelf searchCoupon];
        };
    }
    return _navView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        if(_isTBk){
            _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonTaobaokeGetDgMaterialOptional)];
            _refresh.isCoupleMater = YES;
        }else{
            _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonduoduokeGetgetGoodsList)];
            _refresh.isPinduoduoCoupleMater = YES;
        }
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        _refresh.showFailView = NO;
    }
    return _refresh;
}



@end
