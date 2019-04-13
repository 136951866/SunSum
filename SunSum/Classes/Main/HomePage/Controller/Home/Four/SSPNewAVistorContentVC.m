//
//  SSPNewAVistorContentVC.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSPNewAVistorContentVC.h"
#import "SSPAVistorCell.h"
#import "SSVistorUserModel.h"
#import "SSRCConversationVC.h"

@interface SSPNewAVistorContentVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSPNewAVistorContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
}

- (NSDictionary *)requestParameter{
    
    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
//    [self.refresh.arrData addObjectsFromArray:[SSVistorUserModel mj_objectArrayWithKeyValuesArray:data]];
     [self.refresh.arrData addObjectsFromArray:@[[SSVistorUserModel new],[SSVistorUserModel new]]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSPAVistorCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSPAVistorCell class]) forIndexPath:indexPath];
    SSVistorUserModel *model = self.refresh.arrData[indexPath.row];
    [cell setUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSPAVistorCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSVistorUserModel *model = self.refresh.arrData[indexPath.row];
    if(model.user == nil){
        [SSShowViewTool showMessage:@"未获取到用户信息" view:self.view];
        return;
    }
    if(kMeUnNilStr(model.tls_id).length == 0){
        [SSShowViewTool showMessage:@"未获取到用户信息" view:self.view];
        return;
    }
    if(kMeUnNilStr(model.user.cellphone).length == 0){
        [SSShowViewTool showMessage:@"未获取到用户信息" view:self.view];
        return;
    }
    
    SSCustomActionSheet *sheet = [[SSCustomActionSheet alloc]initWithTitles:@[@"聊天",@"拨打电话"]];
    kMeWEAKSELF
    sheet.blockBtnTapHandle = ^(NSInteger index){
        kMeSTRONGSELF
        if(index){
            [SSCommonTool showWithTellPhone:kMeUnNilStr(model.user.cellphone) inView:strongSelf.view];
        }else{
            if([kMeUnNilStr(model.tls_id) isEqualToString:kCurrentUser.tls_data.tls_id]){
                [SSShowViewTool showMessage:@"暂不支持和自己聊天" view:strongSelf.view];
            }else{
                TConversationCellData *data = [[TConversationCellData alloc] init];
                data.convId = kMeUnNilStr(model.tls_id);
                data.convType = TConv_Type_C2C;
                data.title = kMeUnNilStr(model.user.nick_name);;
                SSRCConversationVC *chat = [[SSRCConversationVC alloc] initWIthconversationData:data];
                [strongSelf.navigationController pushViewController:chat animated:YES];
            }
        }
    };
    [sheet show];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSPAVistorCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSPAVistorCell class])];
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
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonGetAccessUser)];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有记录";
        }];
    }
    return _refresh;
}


@end
