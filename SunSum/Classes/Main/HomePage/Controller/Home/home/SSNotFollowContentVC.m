//
//  SSNotFollowContentVC.m
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNotFollowContentVC.h"
#import "SSAIDataHomeTimeCell.h"
#import "SSMonthNotFollowUpMemberModel.h"
@interface SSNotFollowContentVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
    NSInteger _type;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@end

@implementation SSNotFollowContentVC

- (instancetype)initWithday:(NSInteger)day{
    if(self = [super init]){
        _type = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
}

- (NSDictionary *)requestParameter{
    return @{@"day":@(_type),@"token":kMeUnNilStr(kCurrentUser.token)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSMonthNotFollowUpMemberModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSMonthNotFollowUpMemberModel *model = self.refresh.arrData[indexPath.row];
    SSAIDataHomeTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAIDataHomeTimeCell class]) forIndexPath:indexPath];
    [cell setFollowUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSAIDataHomeTimeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSMonthNotFollowUpMemberModel *model = self.refresh.arrData[indexPath.row];
    if(kMeUnNilStr(model.cellphone).length == 0){
        [SSShowViewTool showMessage:@"未获取到用户信息" view:self.view];
        return;
    }
    //count_type: 1 分享查看 2 普通查看(访问门店) 3投票活动 4分享海报 5分享文章

    SSCustomActionSheet *sheet = [[SSCustomActionSheet alloc]initWithTitles:@[@"拨打电话"]];
    kMeWEAKSELF
    sheet.blockBtnTapHandle = ^(NSInteger index){
        kMeSTRONGSELF
//        if(index){
            [SSPublicNetWorkTool postgetSSIPcommonclerknotFollowUpMemberWithUid:kMeUnNilStr(model.uid) type:model.count_type SuccessBlock:nil failure:nil];
            [SSCommonTool showWithTellPhone:kMeUnNilStr(model.cellphone) inView:strongSelf.view];
//        }
    };
    [sheet show];
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAIDataHomeTimeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAIDataHomeTimeCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonclerkthisMonthNotFollowUpMember)];
        _refresh.isDataInside = YES;
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有客户";
        }];
    }
    return _refresh;
}

@end
