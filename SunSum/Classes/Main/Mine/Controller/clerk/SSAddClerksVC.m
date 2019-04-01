//
//  SSAddClerksVC.m
//  SunSum
//
//  Created by hank on 2018/12/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSAddClerksVC.h"
#import "SSAddClerkCell.h"
#import "ZLRefreshTool.h"
#import "SSClerkModel.h"
#import "SSClerkSearchVC.h"
#import "SSNavigationVC.h"
#import "SSClerkSearchDataVC.h"

@interface SSAddClerksVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@end

@implementation SSAddClerksVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSomeThing];
}

- (void)initSomeThing{
    self.title = @"添加店员";
    _consTopMargin.constant = kMeNavBarHeight;
    [_tableVIew registerNib:[UINib nibWithNibName:NSStringFromClass([SSAddClerkCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAddClerkCell class])];
    _tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableVIew.showsVerticalScrollIndicator = NO;
    _tableVIew.backgroundColor = [UIColor colorWithHexString:@"fbfbfb"];
    [self.refresh addRefreshView];
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
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
    [cell setUIWIthModel:model];
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

- (IBAction)toSearchClerk:(UIButton *)sender {
    SSClerkSearchVC *searchViewController = [SSClerkSearchVC searchViewControllerWithHotSearches:@[] searchBarPlaceholder:@"搜索会员" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        SSClerkSearchDataVC *dataVC = [[SSClerkSearchDataVC alloc]initWithKey:searchText];
        kMeWEAKSELF
        dataVC.finishUpdatClerkBlock = ^{
            kMeSTRONGSELF
            kMeCallBlock(strongSelf->_finishUpdatClerkBlock);
            [strongSelf.refresh reload];
        };
        [searchViewController.navigationController pushViewController:dataVC animated:YES];
    }];
    [searchViewController setSearchHistoriesCachePath:kSSClerkSearchVCSearchHistoriesCachePath];
    SSNavigationVC *nav = [[SSNavigationVC alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableVIew url:kGetApiWithUrl(SSIPcommonMemberList)];
        _refresh.isGet = YES;
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有会员";
        }];
    }
    return _refresh;
}




@end
