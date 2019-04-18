//
//  SSClerkWorkDaliyVC.m
//  SunSum
//
//  Created by hank on 2019/4/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkWorkDaliyVC.h"
#import "SSClerkWorkDaliyCell.h"
#import "SSClerkWorkDaliyModel.h"

@interface SSClerkWorkDaliyVC ()<UITableViewDelegate, UITableViewDataSource>{
    SSClerkWorkDaliyModel *_model;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SSClerkWorkDaliyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作日报";
    _model = [SSClerkWorkDaliyModel new];
    self.view.backgroundColor = kSSf6f5fa;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNetWork)];
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)requestNetWork{
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetSSIPcommoncustomerdailyWorkReportWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_model = [SSClerkWorkDaliyModel mj_objectWithKeyValues:responseObject.data];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSClerkWorkDaliyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkWorkDaliyCell class]) forIndexPath:indexPath];
    NSInteger all = _model.new_customer + _model.potential_customer + _model.Intention_customer+_model.regular_customer;
    [cell setUiWithModel:@[@(_model.new_customer),@(_model.potential_customer),@(_model.Intention_customer),@(_model.regular_customer)] Xtitle:@[@"新客户",@"潜在客户",@"意向客户",@"老客户"] title:@"" progress:@(all).description];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSClerkWorkDaliyCellHeight;
}


- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkWorkDaliyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkWorkDaliyCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kSSf6f5fa;
    }
    return _tableView;
}





@end
