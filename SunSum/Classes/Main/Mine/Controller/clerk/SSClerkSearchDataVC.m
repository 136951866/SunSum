//
//  SSClerkSearchDataVC.m
//  SunSum
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSClerkSearchDataVC.h"
#import "SSAddClerkCell.h"
#import "ZLRefreshTool.h"
#import "SSClerkModel.h"

@interface SSClerkSearchDataVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSString *_key;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSClerkSearchDataVC

- (instancetype)initWithKey:(NSString *)key{
    if(self = [super init]){
        _key = kMeUnNilStr(key);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"搜索%@",_key];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    return @{@"token":kMeUnNilStr(kCurrentUser.token),@"select":kMeUnNilStr(_key)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSClerkModel mj_objectArrayWithKeyValuesArray:data]];
}


#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSClerkModel *model = self.refresh.arrData[indexPath.row];
    SSAddClerkCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAddClerkCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:model withKey:_key];
    kMeWEAKSELF
    cell.updateBlock = ^{
        SSAlertView *aler = [[SSAlertView alloc] initWithTitle:@"" message:@"确定升级为该员工?"];
        [aler addButtonWithTitle:@"确定" block:^{
            [SSPublicNetWorkTool posMemberToClerkWithmemberId:kMeUnNilStr(model.member_id) successBlock:^(ZLRequestResponse *responseObject) {
                kMeSTRONGSELF
                kMeCallBlock(strongSelf->_finishUpdatClerkBlock);
                [strongSelf.refresh reload];
            } failure:^(id object) {
                
            }];
        }];
        [aler addButtonWithTitle:@"取消"];
        [aler show];
    };
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSSAddClerkCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAddClerkCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAddClerkCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        view.backgroundColor = [UIColor colorWithHexString:@"f1f2f6"];
        _tableView.tableFooterView = view;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f1f2f6"];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonMemberList)];
        _refresh.isGet = YES;
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有店员";
        }];
    }
    return _refresh;
}


@end
