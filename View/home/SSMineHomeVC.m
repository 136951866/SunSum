//
//  SSMineHomeVC.m
//  SunSum
//
//  Created by Hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMineHomeVC.h"
#import "SSMineHomeHeaderView.h"
#import "SSMineHomeCell.h"
#import "SSMyDistrbutionVC.h"
#import "SSMyAppointmentVC.h"
#import "SSInteralExchangVC.h"
#import "SSLoginVC.h"
#import "SSAddTelView.h"
#import "SSRCConversationListVC.h"
#import "AppDelegate.h"
#import "SSMineCustomerPhone.h"
#import "SSExpireTipView.h"
#import "SSSelectAddressVC.h"
#import "SSMyMobileVC.h"
#import "SSProductListVC.h"
#import "MeMyActityMineVC.h"

@interface SSMineHomeVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrtype;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) SSMineHomeHeaderView *headerView;
@property (strong, nonatomic) SSAddTelView *addTelVIew;
@property (strong, nonatomic) SSExpireTipView *tipVIew;
//@property (nonatomic, strong)SSLoginVC *loginVC;
@end


@implementation SSMineHomeVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogout) name:kUserLogout object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogin) name:kUserLogin object:nil];
    if([SSUserInfoModel isLogin]){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUnMeaasge) name:kUnMessage object:nil];
    }
    NSInteger f = [[[NSUserDefaults standardUserDefaults] objectForKey:kcheckFirstBuy] integerValue];
    if(f){
        HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"提示" andMessage:@"您有一次免费预约门店服务的机会"];
        alertView.isSupportRotating = YES;
        [alertView addButtonWithTitle:@"取消" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        }];
        kMeWEAKSELF
        [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
            kMeSTRONGSELF
            SSProductListVC *productList = [[SSProductListVC alloc]initWithType:SSGoodsTypeNetServiceStyle];
            [strongSelf.navigationController pushViewController:productList animated:YES];
        }];
        [alertView show];
        
//        SSAlertView *aler = [[SSAlertView alloc] initWithTitle:@"提示" message:@"您有一次免费预约门店服务的机会"];
//        [aler addButtonWithTitle:@"取消"];
//        kMeWEAKSELF
//        [aler addButtonWithTitle:@"确定" block:^{
//            kMeSTRONGSELF
//            SSProductListVC *productList = [[SSProductListVC alloc]initWithType:SSGoodsTypeNetServiceStyle];
//            [strongSelf.navigationController pushViewController:productList animated:YES];
//        }];
//        [aler show];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getUnMeaasge];
}

- (void)getUnMeaasge{
    if([SSUserInfoModel isLogin] && _arrtype.count && self.tableView){
        kMeWEAKSELF
        dispatch_async(dispatch_get_main_queue(), ^{
            kMeSTRONGSELF
            switch (kCurrentUser.user_type) {
                    
                case 4:{
                    SSMineHomeCell *cell = [strongSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
                    [cell setUnMeaasge];
                }
                    break;
                case 1:{
                    SSMineHomeCell *cell = [strongSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
                    [cell setUnMeaasge];
                }
                    break;
                case 2:{
                        SSMineHomeCell *cell = [strongSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
                        [cell setUnMeaasge];
                    }
                    break;
                case 3:{
                    SSMineHomeCell *cell = [strongSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
                    [cell setUnMeaasge];
                }
                    break;
                case 5:{
                    SSMineHomeCell *cell = [strongSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
                    [cell setUnMeaasge];
                }
                    break;
                default:{
                    SSMineHomeCell *cell = [strongSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
                    [cell setUnMeaasge];
                }
                    break;
            }
//            NSString *admin = kCurrentUser.path.group;
//            if([kMeUnNilStr(admin) isEqualToString:@"member"]){
//                SSMineHomeCell *cell = [strongSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
//                [cell setUnMeaasge];
//            }else if([kMeUnNilStr(admin) isEqualToString:@"store"]){
//                 SSMineHomeCell *cell = [strongSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
//                [cell setUnMeaasge];
//            }else{
//                SSMineHomeCell *cell = [strongSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//                [cell setUnMeaasge];
//            }
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
        kMeSTRONGSELF
        switch (kCurrentUser.user_type) {
            case 1:{
                
                strongSelf->_arrtype = @[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)];
            }
                break;
            case 2:{
                //
                strongSelf->_arrtype = @[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)];
            }
                break;
            case 4:{
                //C
                strongSelf->_arrtype = @[@(MeMyDistribution),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)];
            }
                break;
            case 3:{
                //B
                strongSelf->_arrtype = @[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)];
            }
                break;
            case 5:{
                //clerk
                strongSelf->_arrtype = @[@(MeMyDistribution),@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)];
            }
                break;
            default:{
                strongSelf->_arrtype = @[@(MeMyExchange),@(MeMyAppointment),@(MeMyActity),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)];
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

    
//    kMeWEAKSELF
//    [SSPublicNetWorkTool getUserCentreDataWithSuccessBlock:^(ZLRequestResponse *responseObject) {
//        [kCurrentUser setterWithDict:responseObject.data];
//        [kCurrentUser save];
//        kMeSTRONGSELF
//        //B我的中心 C中心管理 admin_id nil C notnil b
//        NSString *admin = kCurrentUser.path.group;
//        if([kMeUnNilStr(admin) isEqualToString:@"member"]){
//            strongSelf->_arrtype = @[@(MeMyDistribution),@(MeMyExchange),@(MeMyAppointment),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)];
//        }else if([kMeUnNilStr(admin) isEqualToString:@"store"]){
//            strongSelf->_arrtype = @[@(MeMyCentraManagertment),@(MeMyExchange),@(MeMyAppointment),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)];
//        }else{
//            strongSelf->_arrtype = @[@(MeMyExchange),@(MeMyAppointment),@(MeMyCustomer),@(MeMyCustomerPhone),@(MeMyAddress),@(MeMyMobile)];
//        }
//        [strongSelf.headerView reloadUIWithUserInfo];
//        strongSelf.tableView.tableHeaderView = strongSelf.headerView;
//        [strongSelf.tableView reloadData];
//        [strongSelf.tableView.mj_header endRefreshing];
//    } failure:^(id object) {
//        kMeSTRONGSELF
//         [strongSelf.tableView.mj_header endRefreshing];
//    }];
}

#pragma mark - tableView deleagte and sourcedata
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrtype.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSMineHomeCellStyle type = [_arrtype[indexPath.row] intValue];
    SSMineHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSMineHomeCell class]) forIndexPath:indexPath];
    [cell setUiWithType:type];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSSMineHomeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSMineHomeCellStyle type = [_arrtype[indexPath.row] intValue];
    switch (type) {
        case MeMyDistribution:{
            //我的中心
            SSMyDistrbutionVC *dvc = [[SSMyDistrbutionVC alloc]initWithC];
            [self.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeMyCentraManagertment:{
            //管理中心
            SSMyDistrbutionVC *dvc = [[SSMyDistrbutionVC alloc]init];
            [self.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeMyAppointment:{
            SSMyAppointmentVC *dvc = [[SSMyAppointmentVC alloc]initWithType:SSAppointmenyUseing];
            [self.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeMyExchange:{
            SSInteralExchangVC *dvc = [[SSInteralExchangVC alloc]init];
            [self.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeMyCustomer:{
            SSRCConversationListVC *cvc = [[SSRCConversationListVC alloc]init];
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case MeMyCustomerPhone:{
            SSMineCustomerPhone *cvc = [[SSMineCustomerPhone alloc]init];
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case MeMyAddress:{
            SSSelectAddressVC *address = [[SSSelectAddressVC alloc]init];
            [self.navigationController pushViewController:address animated:YES];
        }
            break;
        case MeMyMobile:{
            SSMyMobileVC *mobile = [[SSMyMobileVC alloc]init];
            [self.navigationController pushViewController:mobile animated:YES];
        }
            break;
        case MeMyActity:{
            MeMyActityMineVC *mobile = [[MeMyActityMineVC alloc]init];
            [self.navigationController pushViewController:mobile animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMineHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSMineHomeCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (SSMineHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSMineHomeHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kSSMineHomeHeaderViewHeight);
        kMeWEAKSELF
        _headerView.addPhoneBlock = ^{
            kMeSTRONGSELF
            [strongSelf.addTelVIew show];
        };
    }
    return _headerView;
}

- (SSAddTelView *)addTelVIew{
    if(!_addTelVIew){
        _addTelVIew = [[[NSBundle mainBundle]loadNibNamed:@"SSAddTelView" owner:nil options:nil] lastObject];
        _addTelVIew.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        kMeWEAKSELF
        _addTelVIew.finishBlock = ^(BOOL sucess) {
            kMeSTRONGSELF
            [strongSelf.headerView reloadUIWithUserInfo];
            strongSelf.tableView.tableHeaderView = strongSelf.headerView;
        };
    }
    return _addTelVIew;
}

- (SSExpireTipView *)tipVIew{
    if(!_tipVIew){
        _tipVIew = [[[NSBundle mainBundle]loadNibNamed:@"SSExpireTipView" owner:nil options:nil] lastObject];
        _tipVIew.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _tipVIew;
}


//- (SSLoginVC *)loginVC{
//    if(!_loginVC){
//        _loginVC = [[SSLoginVC alloc]init];
//        _loginVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        _loginVC.btnReturn.hidden = YES;
//        _loginVC.view.frame = self.view.bounds;
//        [self addChildViewController:_loginVC];
//    }
//    return _loginVC;
//}


@end
