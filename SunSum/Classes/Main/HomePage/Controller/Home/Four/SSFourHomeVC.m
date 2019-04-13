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

@interface SSFourHomeVC ()<UITableViewDelegate,UITableViewDataSource,SSFourHomeHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SSFourHomeHeaderView         *headerView;

@end

@implementation SSFourHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    [self.view addSubview:self.tableView];
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
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)toAiVC{
    SSAIHomeVC *vc = [[SSAIHomeVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toStoreDiagnosisVC{
    
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
