//
//  SSDistributionTeamVC.m
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSDistributionTeamVC.h"
#import "SSDistrbutionMyTeamCell.h"
#import "SSDistributionTeamModel.h"
#import "SSRCConversationVC.h"

@interface SSDistributionTeamVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
    SSClientTypeStyle _type;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSDistributionTeamVC

- (instancetype)initWithType:(SSClientTypeStyle)type{
    if(self = [super init]){
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的团队";
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

#pragma mark - RefreshToolDelegate
- (NSDictionary *)requestParameter{
    return @{@"token":kMeUnNilStr(kCurrentUser.token),
             };
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSDistributionTeamModel mj_objectArrayWithKeyValuesArray:data]];
}


#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSDistrbutionMyTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSDistrbutionMyTeamCell class]) forIndexPath:indexPath];
    SSDistributionTeamModel *model = self.refresh.arrData[indexPath.row];
    [cell setUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSDistrbutionMyTeamCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSDistributionTeamModel *model = self.refresh.arrData[indexPath.row];
    TConversationCellData *data = [[TConversationCellData alloc] init];
    data.convId = kMeUnNilStr(model.tls_id);
    data.convType = TConv_Type_C2C;
    data.title = kMeUnNilStr(model.nick_name);;
    SSRCConversationVC *chat = [[SSRCConversationVC alloc] initWIthconversationData:data];
    //    chat.conversation = data;
    [self.navigationController pushViewController:chat animated:YES];
    
    
    //    SSRCConversationVC *conversationVC = [[SSRCConversationVC alloc]init];
    //    conversationVC.conversationType = ConversationType_PRIVATE;
    //    conversationVC.targetId = @(model.member_id).description ;//RONGYUNCUSTOMID;
    //    conversationVC.title = kMeUnNilStr(model.nick_name);
    //    if([@(model.member_id).description isEqualToString:kCurrentUser.uid]){
    //        [SSShowViewTool showMessage:@"暂不支持和自己聊天" view:self.view];
    //    }else{
    //        [self.navigationController pushViewController:conversationVC animated:YES];
    //    }
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSDistrbutionMyTeamCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSDistrbutionMyTeamCell class])];
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
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(_type==SSClientCTypeStyle?SSIPcommonUserGetTeam:SSIPcommonUserGetAdminTeam)];
        _refresh.isGet = YES;
        _refresh.isDataInside = YES;
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有团队";
        }];
    }
    return _refresh;
}


@end
