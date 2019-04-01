//
//  SSAppointmentDetailVC.m
//  SunSum
//
//  Created by hank on 2018/9/15.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSAppointmentDetailVC.h"
#import "SSMyOrderDetailCell.h"
#import "SSOrderDetailView.h"
#import "SSOrderDetailContentCell.h"
#import "SSAppointDetailModel.h"
#import "SSAppointmentDetailBootomView.h"

@interface SSAppointmentDetailVC ()<UITableViewDelegate, UITableViewDataSource>{
    SSAppointmenyStyle _appointType;
    NSString *_reserve_sn;
    SSAppointDetailModel *_detaliModel;
    
    //那个端进来
    SSClientTypeStyle _userType;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrData;//预约信息
@property (nonatomic, strong) SSOrderDetailView *headerView;
@property (nonatomic, strong) NSArray *arrDataStr;

@property (nonatomic, strong) NSArray *arrUserData;//用户信息
@property (nonatomic, strong) NSArray *arrUserDataStr;
@property (nonatomic, strong) SSAppointmentDetailBootomView *bottomView;

//@property (nonatomic, strong) NSArray *arrChild;
@end

@implementation SSAppointmentDetailVC

- (instancetype)initWithOrderreserve_sn:(NSString *)reserve_sn{
    if(self = [super init]){
        _reserve_sn = reserve_sn;
    }
    return self;
}

- (instancetype)initWithReserve_sn:(NSString *)reserve_sn userType:(SSClientTypeStyle)userType{
    if(self = [super init]){
        _reserve_sn = reserve_sn;
        _userType = userType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约详情";
    kMeWEAKSELF
    //c端
    if(_userType == SSClientCTypeStyle){
        [SSPublicNetWorkTool postAppointDetailWithReserve_sn:_reserve_sn successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_detaliModel =  [SSAppointDetailModel mj_objectWithKeyValues:responseObject.data];
            strongSelf->_appointType = strongSelf->_detaliModel.is_use;
            if( strongSelf->_detaliModel.is_first_buy){
                strongSelf->_arrData = @[@(SSAppointmentSettlmentTime),@(SSAppointmentSettlmentFristBuy)];
                strongSelf.arrDataStr = @[kMeUnNilStr(strongSelf->_detaliModel.arrive_time),@""];
            }else{
                strongSelf->_arrData = @[@(SSAppointmentSettlmentTime)];
                strongSelf.arrDataStr = @[kMeUnNilStr(strongSelf->_detaliModel.arrive_time)];
            }
            
            //        strongSelf.arrChild = @[strongSelf->_detaliModel];
            strongSelf.tableView.tableHeaderView =strongSelf.headerView;
            [strongSelf.view addSubview:strongSelf.tableView];
            [strongSelf.tableView reloadData];
        } failure:^(id object) {
            kMeSTRONGSELF
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        //B 店员 端
        [SSPublicNetWorkTool postReserveDetailBlWithReserve_sn:_reserve_sn successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_detaliModel =  [SSAppointDetailModel mj_objectWithKeyValues:responseObject.data];
            strongSelf->_appointType = strongSelf->_detaliModel.is_use;
            if( strongSelf->_detaliModel.is_first_buy){
                strongSelf->_arrData = @[@(SSAppointmentSettlmentTime),@(SSAppointmentSettlmentFristBuy)];
                strongSelf.arrDataStr = @[kMeUnNilStr(strongSelf->_detaliModel.arrive_time),@""];
                strongSelf.arrUserData = @[@(SSAppointmentSettlmentUserNameStyle),@(SSAppointmentSettlmentUserTelStyle)];
                strongSelf.arrUserDataStr = @[kMeUnNilStr(strongSelf->_detaliModel.name),kMeUnNilStr(strongSelf->_detaliModel.member_cellphone)];
                
            }else{
                strongSelf->_arrData = @[@(SSAppointmentSettlmentTime)];
                strongSelf.arrDataStr = @[kMeUnNilStr(strongSelf->_detaliModel.arrive_time)];
                
                strongSelf.arrUserData = @[@(SSAppointmentSettlmentUserNameStyle),@(SSAppointmentSettlmentUserTelStyle)];
                strongSelf.arrUserDataStr = @[kMeUnNilStr(strongSelf->_detaliModel.name),kMeUnNilStr(strongSelf->_detaliModel.member_cellphone)];
            }
            strongSelf.tableView.tableHeaderView =strongSelf.headerView;
            if(strongSelf->_appointType == SSAppointmenyUseing){
                strongSelf.tableView.tableFooterView = strongSelf.bottomView;
            }
            [strongSelf.view addSubview:strongSelf.tableView];
            [strongSelf.tableView reloadData];
        } failure:^(id object) {
            kMeSTRONGSELF
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }];
 
    }
}
#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(_userType == SSClientCTypeStyle){
        return 2;
    }else{
        return 3;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_userType == SSClientCTypeStyle){
        if(section){
            return _arrData.count;
        }else{
            return 1;
        }
    }else{
        switch (section) {
            case 0:
            {
                return 1;
            }
                break;
            case 1:
            {
                return _arrData.count;
            }
                break;
            case 2:
            {
                return _arrUserData.count;
            }
                break;
            default:
                return 0;
                break;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            SSOrderDetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSOrderDetailContentCell class]) forIndexPath:indexPath];
            //        id model = _arrChild[indexPath.row];
            [cell setAppointUIWithChildModel:_detaliModel];
            return cell;
        }
            break;
        case 1:{
            SSMyOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSMyOrderDetailCell class]) forIndexPath:indexPath];
            ;
            [cell setAppointUIWithModel:_arrDataStr[indexPath.row] appointType:[_arrData[indexPath.row] integerValue] orderType:_appointType];
            return cell;
        }
            break;
        case 2:{
            SSMyOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSMyOrderDetailCell class]) forIndexPath:indexPath];
            ;
            [cell setAppointUIWithModel:_arrUserDataStr[indexPath.row] appointType:[_arrUserData[indexPath.row] integerValue] orderType:_appointType];
            return cell;
        }
            break;
        default:
            return  [UITableViewCell new];
            break;
    }
    
//    if(indexPath.section){
//
//    }else{
//
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section?kSSMyOrderDetailCellHeight:kSSOrderDetailContentCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?kSSMyOrderDetailCellHeight:0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSSMyOrderDetailCellHeight)];
    UILabel *lblTitle = [[UILabel alloc]init];
    [sectionView addSubview:lblTitle];
    lblTitle.text = @"预约信息";
    if(section == 2){
        lblTitle.text = @"客户信息";
    }
    lblTitle.font = [UIFont systemFontOfSize:16];
    lblTitle.textColor = kSSHexColor(@"333333");
    [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView.mas_left).offset(15);
        make.right.equalTo(sectionView.mas_right).offset(15);
        make.top.equalTo(sectionView);
        make.bottom.equalTo(sectionView);
    }];
    return sectionView;
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMyOrderDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSMyOrderDetailCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSOrderDetailContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSOrderDetailContentCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (SSOrderDetailView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSOrderDetailView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kSSOrderDetailViewHeight);
        [_headerView setAppointUIWithModel:_detaliModel orderType:_appointType];
    }
    return _headerView;
}

- (SSAppointmentDetailBootomView *)bottomView{
    if(!_bottomView){
        _bottomView = [[[NSBundle mainBundle]loadNibNamed:@"SSAppointmentDetailBootomView" owner:nil options:nil] lastObject];
        _bottomView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kSSAppointmentDetailBootomViewheight);
        kMeWEAKSELF
        _bottomView.cancelBlock = ^{
            SSAlertView *aler = [[SSAlertView alloc] initWithTitle:@"" message:@"确定取消预约吗?"];
            [aler addButtonWithTitle:@"确定" block:^{
                kMeSTRONGSELF
                [SSPublicNetWorkTool postCancelReserveWithReserveSn:strongSelf->_detaliModel.reserve_sn successBlock:^(ZLRequestResponse *responseObject) {
                    kNoticeReloadAppoint
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                } failure:^(id object) {
                    
                }];
            }];
            [aler addButtonWithTitle:@"取消"];
            [aler show];
        };
        _bottomView.finishBlock = ^{
            SSAlertView *aler = [[SSAlertView alloc] initWithTitle:@"" message:@"确定完成预约吗?"];
            [aler addButtonWithTitle:@"确定" block:^{
                kMeSTRONGSELF
                [SSPublicNetWorkTool postFinishReserveWithReserveSn:strongSelf->_detaliModel.reserve_sn successBlock:^(ZLRequestResponse *responseObject) {
                    kNoticeReloadAppoint
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                } failure:^(id object) {
                    
                }];
            }];
            [aler addButtonWithTitle:@"取消"];
            [aler show];
        };
    }
    return _bottomView;
}




@end
