//
//  SSFourClerkHomeVC.m
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSFourClerkHomeVC.h"
#import "SSClerkLogCell.h"
#import "SSFourClerkHomeHeaderView.h"
#import "SSNewClerkManngerModel.h"
#import "SSAIHomeVC.h"
#import "SSPNewAVistorVC.h"
#import "SSCLerkLogHomeVC.h"
#import "SSClerkFollowCell.h"
#import "SSClerkNotFollowUpMember.h"
#import "SSNotFollowVC.h"

@interface SSFourClerkHomeVC ()<UITableViewDelegate,UITableViewDataSource,SSFourHomeHeaderViewDelegate>
{
    SSNewClerkManngerClerkTaskServiceModel *_homeModel;
    SSClerkNotFollowUpMember *_notFollowMoldel;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SSFourClerkHomeHeaderView         *headerView;

@end

@implementation SSFourClerkHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    [self.view addSubview:self.tableView];
    _homeModel = [SSNewClerkManngerClerkTaskServiceModel new];
    _notFollowMoldel = [SSClerkNotFollowUpMember new];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f5fa"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)reloadData{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    kMeWEAKSELF
    
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postgetclerkclerkTaskServiceWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_homeModel = [SSNewClerkManngerClerkTaskServiceModel mj_objectWithKeyValues:responseObject.data];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postgetSSIPcommonclerknotFollowUpMemberWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_notFollowMoldel = [SSClerkNotFollowUpMember mj_objectWithKeyValues:responseObject.data];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });

    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            kMeSTRONGSELF
            [strongSelf.tableView reloadData];
            [strongSelf.tableView.mj_header endRefreshing];
        });
    });
}

- (void)toAiVC{
    SSAIHomeVC *vc = [[SSAIHomeVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toPAVC{
    SSPNewAVistorVC *vc = [[SSPNewAVistorVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        SSClerkLogCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkLogCell class]) forIndexPath:indexPath];
        [cell setLogUIWithArr:_homeModel];
        return cell;
    }else{
        SSClerkFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkFollowCell class]) forIndexPath:indexPath];
        [cell setUiWithModel:_notFollowMoldel];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSSClerkLogCellOrgialHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        SSCLerkLogHomeVC *vc = [[SSCLerkLogHomeVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        SSNotFollowVC *vc = [[SSNotFollowVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkLogCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkLogCell class])];
         [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkFollowCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkFollowCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableHeaderView.backgroundColor = kSSf6f5fa;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kSSf6f5fa;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (SSFourClerkHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSFourClerkHomeHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH,kSSFourClerkHomeHeaderViewHeight);
        _headerView.backgroundColor = [UIColor colorWithHexString:@"f6f5fa"];
        _headerView.delegate = self;
    }
    return _headerView;
}

@end
