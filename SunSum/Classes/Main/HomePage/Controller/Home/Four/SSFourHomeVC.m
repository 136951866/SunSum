//
//  SSFourHomeVC.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSFourHomeVC.h"
#import "SSFourHomeWorkShowCell.h"
#import "SSFourHomeHeaderView.h"
#import "SSFourHomeDairyCell.h"
#import "SSAIHomeVC.h"
#import "SSPNewAVistorVC.h"
#import "SSNewClerkManngerVC.h"
#import "SSClerkWorkDaliyVC.h"
#import "SSClerkPlanAchieveVC.h"
#import "SSClerkDiagnosisResultVC.h"
#import "SSClerkWorkStatisticsServerLogVC.h"
#import "SSClerkOperationDailyVC.h"
#import "SSFourHomeModel.h"

@interface SSFourHomeVC ()<UITableViewDelegate,UITableViewDataSource,SSFourHomeHeaderViewDelegate>
{
    SSFourHomeModel *_homeModel;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SSFourHomeHeaderView         *headerView;

@end

@implementation SSFourHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    [self.view addSubview:self.tableView];
    _homeModel = [SSFourHomeModel new];
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
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetclerkhomeAllWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_homeModel = [SSFourHomeModel mj_objectWithKeyValues:responseObject.data];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)toAiVC{
    SSAIHomeVC *vc = [[SSAIHomeVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toStoreDiagnosisVC{
    SSClerkDiagnosisResultVC *vc = [[SSClerkDiagnosisResultVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toPAVC{
    SSPNewAVistorVC *vc = [[SSPNewAVistorVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toClerkManngerVC{
    SSNewClerkManngerVC *vc = [[SSNewClerkManngerVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toCaseVC{
    
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        SSFourHomeDairyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSFourHomeDairyCell class]) forIndexPath:indexPath];
        [cell setUIWithType:1];
        return cell;
    }else if (indexPath.row == 1){
        SSFourHomeDairyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSFourHomeDairyCell class]) forIndexPath:indexPath];
        [cell setUIWithType:2];
        return cell;
    }else{
        SSFourHomeWorkShowCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSFourHomeWorkShowCell class]) forIndexPath:indexPath];
        [cell setUIWithModel:_homeModel];
        kMeWEAKSELF
        cell.planAchieveBlock = ^{
            kMeSTRONGSELF
            SSClerkPlanAchieveVC *vc = [[SSClerkPlanAchieveVC alloc]init];
            [strongSelf.navigationController pushViewController:vc animated:YES];
        };
        cell.workFinishBlock = ^{
            kMeSTRONGSELF
            SSClerkWorkStatisticsServerLogVC *vc = [[SSClerkWorkStatisticsServerLogVC alloc]init];
            [strongSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return kSSFourHomeDairyCellheight;
    }else if (indexPath.row == 1){
        return kSSFourHomeDairyCellheight;
    }else{
        return kSSFourHomeWorkShowCellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        //运营
        SSClerkOperationDailyVC *vc = [[SSClerkOperationDailyVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        //工作
        SSClerkWorkDaliyVC *vc = [[SSClerkWorkDaliyVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}


- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSFourHomeWorkShowCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSFourHomeWorkShowCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSFourHomeDairyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSFourHomeDairyCell class])];
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

- (SSFourHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSFourHomeHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH,kSSFourHomeHeaderViewHeight);
        _headerView.backgroundColor = [UIColor colorWithHexString:@"f6f5fa"];
        _headerView.delegate = self;
    }
    return _headerView;
}

@end
