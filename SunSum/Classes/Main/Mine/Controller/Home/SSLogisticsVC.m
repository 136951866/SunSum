//
//  SSLogisticsVC.m
//  SunSum
//
//  Created by hank on 2018/10/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSLogisticsVC.h"
#import "SSLogisticsCell.h"
#import "SSLogisticsHeaderView.h"
#import "SSOrderDetailModel.h"

@interface SSLogisticsVC ()<UITableViewDelegate, UITableViewDataSource>{
//    NSString *_orderGoodsSn;
    SSOrderDetailModel *_model;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SSLogisticsHeaderView *headerView;
@property (nonatomic, strong) NSArray *logistArr;
@end

@implementation SSLogisticsVC

- (instancetype)initWithmodel:(SSOrderDetailModel *)model{
    if(self = [super init]){
        _model = model;
//        self.logistArr = kMeUnArr(_model.logistics.data);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流信息";
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logistArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSLogisticsCell class]) forIndexPath:indexPath];
    SSLogistDataModel *model = self.logistArr[indexPath.row];
    [cell setUIWIthModel:model isSelect:indexPath.row == 0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSLogistDataModel *model = self.logistArr[indexPath.row];
    return [SSLogisticsCell getCellHeightWithModel:model];
}
#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSLogisticsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSLogisticsCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (SSLogisticsHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSLogisticsHeaderView" owner:nil options:nil] lastObject];
        [_headerView setUIWithModel:_model];
    }
    return _headerView;
}

@end
