//
//  SSNewClerkManngerVC.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNewClerkManngerVC.h"
#import "SSClerkTaskCell.h"
#import "SSClerkLogCell.h"
#import "SSClerkSortCell.h"
#import "SSCLerkTaskHomeVC.h"
#import "SSCLerkLogHomeVC.h"
#import "SSCLerkSortHomeVC.h"
#import "SSClerkPlanAchieveVC.h"
#import "SSEditClerkLogVC.h"
#import "SSNewClerkManngerModel.h"
#import "SSClerkTaskMoreVC.h"

@interface SSNewClerkManngerVC ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *_arrSelect;
    NSInteger _currentIndex;
    SSNewClerkManngerModel *_model;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SSNewClerkManngerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"员工管理";
    _currentIndex = 0;
    _model = [SSNewClerkManngerModel new];
    _arrSelect = @[@[],@[],@[]];
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetclerkclerkManagementWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_model = [SSNewClerkManngerModel mj_objectWithKeyValues:responseObject.data];
        strongSelf->_arrSelect = @[kMeUnArr(strongSelf->_model.clerk_order.clerkOrderByShareCount.data),kMeUnArr(strongSelf->_model.clerk_order.clerkOrderByFollowUpCount.data),kMeUnArr(strongSelf->_model.clerk_order.clerkOrderByFollowUpMemberCount.data)];
        [strongSelf.view addSubview:strongSelf.tableView];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kMeWEAKSELF
    if(indexPath.row == 0){
        SSClerkTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkTaskCell class]) forIndexPath:indexPath];
        [cell setUIWithArr:_model];
        kMeWEAKSELF
        cell.moreBlock = ^{
            kMeSTRONGSELF
            SSClerkTaskMoreVC *vc = [[SSClerkTaskMoreVC alloc]init];
            [strongSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else if (indexPath.row == 1){
        SSClerkLogCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkLogCell class]) forIndexPath:indexPath];
        [cell setUIWithArr:_model];
//        cell.selectIndexBlock = ^(NSInteger index) {
//            kMeSTRONGSELF
//            SSNewClerkManngerClerkTaskclientModel *cmodel = kMeUnArr(strongSelf->_model.clerk_task_service.client)[index];
//            SSEditClerkLogVC *vc = [[SSEditClerkLogVC alloc]initWithModel:cmodel];
//            [strongSelf.navigationController pushViewController:vc animated:YES];
//        };
        return cell;
    }else{
        SSClerkSortCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkSortCell class]) forIndexPath:indexPath];
        NSArray *arr = _arrSelect[_currentIndex];
        [cell setUIWithArr:arr selectBlock:^(NSInteger index) {
            kMeSTRONGSELF
            strongSelf->_currentIndex = index;
            [strongSelf.tableView reloadData];
        } selectIndex:_currentIndex];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        return [SSClerkTaskCell getCellHeightWithArr:_model];
    }else if (indexPath.row == 1){
        return [SSClerkLogCell getCellHeightWithArr:_model];
    }else{
        NSArray *arr = _arrSelect[_currentIndex];
        return [SSClerkSortCell getCellHeightWithArr:arr];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        SSCLerkTaskHomeVC *vc = [[SSCLerkTaskHomeVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        if(kCurrentUser.client_type == SSClientBTypeStyle){
            return;
        }
        SSCLerkLogHomeVC *vc = [[SSCLerkLogHomeVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        SSCLerkSortHomeVC *vc = [[SSCLerkSortHomeVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkTaskCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkTaskCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkLogCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkLogCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkSortCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkSortCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = kSSf6f5fa;
        _tableView.tableFooterView = view;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kSSf6f5fa;
    }
    return _tableView;
}

@end
