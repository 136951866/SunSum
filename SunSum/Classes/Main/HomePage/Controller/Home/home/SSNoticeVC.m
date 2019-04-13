//
//  SSNoticeVC.m
//  SunSum
//
//  Created by hank on 2018/11/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSNoticeVC.h"
#import "SSNoticeCell.h"
#import "SSNoticeModel.h"
//#import "SSProductDetailsVC.h"
#import "SSThridProductDetailsVC.h"
#import "SSMyOrderDetailVC.h"
#import "SSAppointmentDetailVC.h"

@interface SSNoticeVC ()<RefreshToolDelegate,UITableViewDelegate,UITableViewDataSource>{
//    SSJpushType _type;
//    NSString *_title;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) UIButton *btnRight;
@end

@implementation SSNoticeVC

//- (instancetype)initWithNoticeType:(SSJpushType)type title:(NSString *)title{
//    if(self = [super init]){
//        _title = title;
//        _type = type;
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知";
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnRight];
    // Do any additional setup after loading the view.
}

#pragma mark - Action
- (void)allRead{
    HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"提示" andMessage:@"确定全部设为已读"];
    alertView.isSupportRotating = YES;
    [alertView addButtonWithTitle:@"取消" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
    }];
    kMeWEAKSELF
    [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        kMeSTRONGSELF
        [SSPublicNetWorkTool getUseAllReadedInfoWithType:0 SuccessBlock:^(ZLRequestResponse *responseObject) {
            [strongSelf.refresh reload];
            kNoticeUnNoticeMessage
        } failure:nil];
    }];
    [alertView show];
}

- (NSDictionary *)requestParameter{
//    @"type":@(_type)
    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSNoticeModel mj_objectArrayWithKeyValuesArray:data]];
}



#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSNoticeModel *model = self.refresh.arrData[indexPath.row];
    SSNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSNoticeCell class])];
    [cell setUIWIthModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSNoticeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSNoticeModel *model = self.refresh.arrData[indexPath.row];
    if(model.is_read==1){
        kMeWEAKSELF
        [SSPublicNetWorkTool getUserReadedNoticeWithNoticeId:model.idField SuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            model.is_read = 2;
            [strongSelf.tableView reloadData];
            kNoticeUnNoticeMessage
        } failure:nil];
    }
    switch (model.type) {
        case SSJpushNoticeType:{
            SSThridProductDetailsVC *dvc = [[SSThridProductDetailsVC alloc]initWithId:[model.ids integerValue]];
            [self.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case SSJpushOrderType:{
            SSMyOrderDetailVC *dvc = [[SSMyOrderDetailVC alloc]initWithOrderGoodsSn:kMeUnNilStr(model.ids)];
            [self.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case SSJpushVersionUpdateType:{
            NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",kSSAppId];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }
            break;
        case SSJpushServiceAppointType:{
            SSAppointmentDetailVC *dvc = [[SSAppointmentDetailVC alloc]initWithReserve_sn:kMeUnNilStr(model.ids) userType:SSClientBTypeStyle];
            [self.navigationController pushViewController:dvc animated:YES];
        }
            break;
        default:
            break;
    }

}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSNoticeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSNoticeCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kSSfbfbfb;
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonNotices)];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有通知";
        }];
    }
    return _refresh;
}

- (UIButton *)btnRight{
    if(!_btnRight){
        _btnRight= [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = CGRectMake(-15, 0, 70, 25);
        [_btnRight setTitle:@"一键已读" forState:UIControlStateNormal];
        _btnRight.titleLabel.font = kMeFont(14);
        [_btnRight setTitleColor:kSSblack forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(allRead) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}


@end
