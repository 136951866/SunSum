//
//  SSMyAppointmentContentVC.m
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMyAppointmentContentVC.h"
#import "SSMyAppointmentCell.h"
#import "SSAppointmentDetailVC.h"
#import "SSAppointmentModel.h"


@interface SSMyAppointmentContentVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
    SSAppointmenyStyle _type;
    SSClientTypeStyle _userType;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSMyAppointmentContentVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (instancetype)initWithType:(SSAppointmenyStyle)type userType:(SSClientTypeStyle)userType{
    if(self = [super init]){
        _type = type;
        _userType = userType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    kAppointReload
    // Do any additional setup after loading the view.
}

- (NSDictionary *)requestParameter{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"token"] = kMeUnNilStr(kCurrentUser.token);
    dic[@"is_use"] = @(_type).description;
    return dic;
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSAppointmentModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSAppointmentModel *model = self.refresh.arrData[indexPath.row];
    SSMyAppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSMyAppointmentCell class]) forIndexPath:indexPath];
    if(_userType == SSClientCTypeStyle){
        cell.cancelAppointBlock = ^{
            
        };
        [cell setUIWithModel:model Type:_type];
    }else{
        [cell setBUIWithModel:model Type:_type];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSMyAppointmentCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSAppointmentModel *model = self.refresh.arrData[indexPath.row];
    SSAppointmentDetailVC *vc = [[SSAppointmentDetailVC alloc]initWithReserve_sn:kMeUnNilStr(model.reserve_sn) userType:_userType];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMyAppointmentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSMyAppointmentCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        NSString *IPStr = SSIPcommonreserveListB;
        if(_userType == SSClientCTypeStyle){
            IPStr = SSIPcommonGetReserveList;
        }
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(IPStr)];
        _refresh.isDataInside = YES;
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有预约";
        }];
    }
    return _refresh;
}

@end
