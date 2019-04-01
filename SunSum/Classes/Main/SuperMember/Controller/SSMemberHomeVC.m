//
//  SSMemberHomeVC.m
//  SunSum
//
//  Created by hank on 2018/9/6.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMemberHomeVC.h"
#import "SSMemberHomeDeanCell.h"
#import "SSMineExchangeDetailVC.h"
//#import "SSMemberHomeImageCell.h"
#import "SSMemberHomeProductCell.h"
#import "SSSuperMemberHomeModel.h"
#import "SSNetListModel.h"
#import "SSGoodModel.h"
#import "SSMineExchangeDetailVC.h"

@interface SSMemberHomeVC ()<UITableViewDelegate,UITableViewDataSource>{
    SSSuperMemberHomeModel *_model;
    NSArray *_arrDean;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imgHeader;

@end

@implementation SSMemberHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [SSSuperMemberHomeModel new];
    _arrDean = [NSArray array];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.imgHeader;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(networkRequest)];
    [self.tableView.mj_header beginRefreshing];

}

- (void)networkRequest{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    kMeWEAKSELF
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool getSupportMemberWithsuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_model = [SSSuperMemberHomeModel mj_objectWithKeyValues:responseObject.data];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postSupportMemberManyGoodsWithsuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            SSNetListModel *nlModel = [SSNetListModel mj_objectWithKeyValues:responseObject.data];
            strongSelf->_arrDean = [SSGoodModel mj_objectArrayWithKeyValuesArray:nlModel.data];
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
            [strongSelf.tableView.mj_header endRefreshing];
            [strongSelf.tableView reloadData];
        });
    });
    
}

#pragma mark - tableView deleagte and sourcedata

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return self.imgHeader;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    CGFloat height = ((self.view.width * 288)/750);
//    return height;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row){
        SSMemberHomeProductCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSMemberHomeProductCell class])];
        [cell setUiWithModel:_model];
        return cell;
    }else{
        if(_arrDean.count){
            SSMemberHomeDeanCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSMemberHomeDeanCell class])];
            [cell setUIWithArr:_arrDean];
            kMeWEAKSELF
            cell.indexBlock = ^(NSInteger index) {
                kMeSTRONGSELF
                SSGoodModel *model = strongSelf->_arrDean[index];
                SSMineExchangeDetailVC *dvc = [[SSMineExchangeDetailVC alloc]initWithId:model.product_id];
                [strongSelf.navigationController pushViewController:dvc animated:YES];
            };
            return cell;
        }
        return [UITableViewCell new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row){
        return [SSMemberHomeProductCell getCellHeightWithModel:_model];;
    }else{
        return _arrDean.count?kSSMemberHomeDeanCellHeight:0.1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (UIImageView *)imgHeader{
    if(!_imgHeader){
        CGFloat height = ((self.view.width * 288)/750);
        _imgHeader = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        _imgHeader.image = kMeGetAssetImage(@"mheader");
    }
    return _imgHeader;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMemberHomeDeanCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSMemberHomeDeanCell class])];
         [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMemberHomeProductCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSMemberHomeProductCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}


@end
