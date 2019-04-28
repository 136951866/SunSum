//
//  SSNewMineHomeVC.m
//  SunSum
//
//  Created by hank on 2019/1/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNewMineHomeVC.h"
#import "SSNewMineHomeHeaderView.h"
#import "SSNewMineHomeCell.h"
#import "SSProductListVC.h"


@interface SSNewMineHomeVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrtype;
    NSArray *_arrtypeTitle;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) SSNewMineHomeHeaderView *headerView;

@end

@implementation SSNewMineHomeVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogout) name:kUserLogout object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogin) name:kUserLogin object:nil];
    if([SSUserInfoModel isLogin]){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUnMeaasge) name:kUnMessage object:nil];
    }
#warning --
    
//    NSInteger f = [[[NSUserDefaults standardUserDefaults] objectForKey:kcheckFirstBuy] integerValue];
//    if(f){
//        HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"提示" andMessage:@"您有一次免费预约门店服务的机会"];
//        alertView.isSupportRotating = YES;
//        [alertView addButtonWithTitle:@"取消" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
//        }];
//        kMeWEAKSELF
//        [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
//            kMeSTRONGSELF
//            SSProductListVC *productList = [[SSProductListVC alloc]initWithType:SSGoodsTypeNetServiceStyle];
//            [strongSelf.navigationController pushViewController:productList animated:YES];
//        }];
//        [alertView show];
//    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self getUnMeaasge];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)getUnMeaasge{
    if([SSUserInfoModel isLogin] && _arrtype.count && self.tableView){
        kMeWEAKSELF
        dispatch_async(dispatch_get_main_queue(), ^{
            kMeSTRONGSELF
             [strongSelf.tableView reloadData];
        });
    }
}

- (void)userLogout{
    [self.navigationController popToViewController:self animated:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUnMessage object:nil];
    [self.headerView clearUIWithUserInfo];
    _arrtype = @[];
    [self.tableView reloadData];
}

- (void)userLogin{
    [self loadData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUnMeaasge) name:kUnMessage object:nil];
}

- (void)loadData{
    kMeWEAKSELF
    [SSPublicNetWorkTool getUserGetUserWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        NSLog(@"%@",kCurrentUser.uid);
        /*
        kMeSTRONGSELF
        switch (kCurrentUser.user_type) {
            case 1:{
                //B
                strongSelf->_arrtype = @[@[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MeShopCartt)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData)]];
            }
                break;
            case 2:{
                //
                strongSelf->_arrtype = @[@[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MeShopCartt)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData)]];
            }
                break;
            case 4:{
                //C
                strongSelf->_arrtype = @[@[@(MeMyDistribution),@(MeMyExchange),@(MeMyAppointment),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MeStoreApply),@(MeShopCartt)]];
            }
                break;
            case 3:{
                //B
                strongSelf->_arrtype = @[@[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MeShopCartt)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData)]];
            }
                break;
            case 5:{
                //clerk
                strongSelf->_arrtype = @[@[@(MeMyDistribution),@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MeShopCartt)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData)]];
            }
                break;
            default:{
                strongSelf->_arrtype = @[@[@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MeShopCartt)]];
            }
                break;
        }
        [strongSelf.headerView reloadUIWithUserInfo];
        strongSelf.tableView.tableHeaderView = strongSelf.headerView;
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
         */
        kMeSTRONGSELF
        switch (kCurrentUser.user_type) {
            case 1:{
                //B
                //                strongSelf->_arrtype = @[@[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MePAVistor)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData)]];
                
                strongSelf->_arrtype = @[@[@(MeHomeyongjing),@(MeHomeorderall),@(MeHometuandui),@(MeHomeshangji),@(MeHometixian),@(MePAVistor),@(MeHometuigcode)],@[@(MeMyAppointment),@(MeMyExchange),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData)]];
                strongSelf->_arrtypeTitle = @[@"商家管理",@"必备",@"获客"];
            }
                break;
            case 2:{
                //
                //                strongSelf->_arrtype = @[@[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MePAVistor)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData)]];
                strongSelf->_arrtype = @[@[@(MeHomeyongjing),@(MeHomeorderall),@(MeHometuandui),@(MeHomeshangji),@(MeHometixian),@(MeHomepinpaigli),@(MePAVistor),@(MeHometuigcode)],@[@(MeMyAppointment),@(MeMyExchange),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData)]];
                strongSelf->_arrtypeTitle = @[@"商家管理",@"必备",@"获客"];
            }
                break;
            case 4:{
                //C
                //                strongSelf->_arrtype = @[@[@(MeMyDistribution),@(MeMyExchange),@(MeMyAppointment),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MeStoreApply)]];
                strongSelf->_arrtype = @[@[@(MeHomemeiodu),@(MeHomeCorderall),@(MeHometuandui),@(MeHometuigcode)],@[@(MeMyAppointment),@(MeMyExchange),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MeStoreApply)]];
                strongSelf->_arrtypeTitle = @[@"中心管理",@"必备"];
            }
                break;
            case 3:{
                //B
                //                strongSelf->_arrtype = @[@[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MePAVistor),@(MeAILEI)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData)]];
                strongSelf->_arrtype = @[@[@(MeHomeyongjing),@(MeHomeorderall),@(MeHometuandui),@(MeHomeshangji),@(MeHomedianyuan),@(MeHomeyuyue),@(MeHomedata),@(MeHomedianpu),@(MeHometixian),@(MeHomeziti),@(MeHometuigcode)],
                                         @[@(MeMyAppointment),@(MeMyExchange),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData)]];
                strongSelf->_arrtypeTitle = @[@"商家管理",@"必备",@"获客"];
            }
                break;
            case 5:{
                //clerk
                //                                strongSelf->_arrtype = @[@[@(MeMyDistribution),@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile),@(MePAVistor),@(MeAILEI)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData)]];
                strongSelf->_arrtype = @[@[@(MeHomeyongjing),@(MeHomemeiodu),@(MeHomeCorderall),@(MeHomeorderall),@(MeHometuandui),@(MeHomeshangji),@(MeHomeyuyue),@(MeHometixian),@(Mehomeyongjitongji),@(MePAVistor),@(MeHometuigcode)],
                                         @[@(MeMyAppointment),@(MeMyExchange),@(MeMyActity),@(MeDynalApply),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)],@[@(MeMyPoster),@(MeMyArticel),@(MemyData)]];
                strongSelf->_arrtypeTitle = @[@"商家管理",@"必备",@"获客"];
                
            }
                
                break;
            default:{
                strongSelf->_arrtype = @[];
                strongSelf->_arrtypeTitle = @[];
                
            }
                break;
        }
        [strongSelf.headerView reloadUIWithUserInfo];
        strongSelf.tableView.tableHeaderView = strongSelf.headerView;
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.tableView.mj_header endRefreshing];
    }];
    
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrtype.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSNewMineHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSNewMineHomeCell class]) forIndexPath:indexPath];
    NSArray *arr = _arrtype[indexPath.row];
    NSString *title = _arrtypeTitle[indexPath.row];
    [cell setUIWithAtrr:arr title:title];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = _arrtype[indexPath.row];
    return [SSNewMineHomeCell getHeightWithArr:arr];;
}


#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSNewMineHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSNewMineHomeCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =  [UIColor colorWithHexString:@"fafafa"];
    }
    return _tableView;
}

- (SSNewMineHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSNewMineHomeHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kSSNewMineHomeHeaderViewHeight);
    }
    return _headerView;
}
@end
