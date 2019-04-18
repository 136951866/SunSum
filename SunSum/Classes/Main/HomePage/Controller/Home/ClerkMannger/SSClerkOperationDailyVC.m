//
//  SSClerkOperationDailyVC.m
//  SunSum
//
//  Created by hank on 2019/4/18.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkOperationDailyVC.h"
#import "SSClerkOperationDailyCell.h"
#import "SSClerkOperationDailyMainCell.h"
#import "SSClerkOperationDailyMainModel.h"
#import "SSClerkOperationDailyModel.h"

@interface SSClerkOperationDailyVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
    SSClerkOperationDailyModel *_model;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@end

@implementation SSClerkOperationDailyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运营日报";
    _model = [SSClerkOperationDailyModel new];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

- (void)getData{
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetclerkdailyOperationsWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_model = [SSClerkOperationDailyModel mj_objectWithKeyValues:responseObject.data];
        [strongSelf.tableView reloadData];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        [self getData];
    }
    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSClerkOperationDailyMainModel mj_objectArrayWithKeyValuesArray:data]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return self.refresh.arrData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        SSClerkOperationDailyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkOperationDailyCell class]) forIndexPath:indexPath];
        NSInteger all = _model.dailyWorkReport.new_customer + _model.dailyWorkReport.potential_customer+_model.dailyWorkReport.Intention_customer+_model.dailyWorkReport.regular_customer;
        [cell setUiWithModel:@[@(_model.dailyWorkReport.new_customer),@(_model.dailyWorkReport.potential_customer),@(_model.dailyWorkReport.Intention_customer),@(_model.dailyWorkReport.regular_customer)] Xtitle:@[@"新客",@"潜在",@"意向",@"老客"] title:@"门店客户数" allcount:@(all).description color:@[@"#7C68FF",@"#728DFF",@"#E070FF",@"#FEB662"] compan:@"人"];
        return cell;
    }else if (indexPath.section == 1){
        SSClerkOperationDailyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkOperationDailyCell class]) forIndexPath:indexPath];
        CGFloat finish = (CGFloat)((CGFloat)_model.logCompletion.today_task_finish/(CGFloat)_model.logCompletion.today_task_total);
        int finushIndex = finish * 100;
        [cell setUiWithModel:@[@(_model.logCompletion.today_task_finish),@(_model.logCompletion.today_task_total-_model.logCompletion.today_task_finish)] Xtitle:@[@"已经完成",@"未完成"] title:@"日志完成度" allcount:[NSString stringWithFormat:@"%d%%",finushIndex] color:@[@"#7C68FF",@"#E070FF"] compan:@"个"];
        return cell;
    }else{
        SSClerkOperationDailyMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkOperationDailyMainCell class]) forIndexPath:indexPath];
        SSClerkOperationDailyMainModel *model = self.refresh.arrData[indexPath.row];
        [cell setUiWithModel:model];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return kSSClerkOperationDailyCellHeight;
    }else if (indexPath.section == 1){
        return kSSClerkOperationDailyCellHeight;
    }else{
        return kSSClerkOperationDailyMainCellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return [UIView new];
    }else if (section == 1){
        return [UIView new];
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 51)];
        UIView *viewline = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        viewline.backgroundColor = kSSf6f5fa;
        UILabel *lbl = [SSView lblWithFram:CGRectMake(15, 10, SCREEN_WIDTH-30, 40) textColor:[UIColor colorWithHexString:@"333333"] str:@"日志未完成" font:kMeFont(15)];
        UIView *viewlinetwo = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
        viewlinetwo.backgroundColor = kSSf6f5fa;
        [view addSubview:lbl];
        [view addSubview:viewline];
        [view addSubview:viewlinetwo];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.1;
    }else if (section == 1){
        return 0.1;
    }else{
        return 51;
    }
}


- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkOperationDailyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkOperationDailyCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkOperationDailyMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkOperationDailyMainCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonclerktodayClerkUnfinishTask)];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        _refresh.showFailView = NO;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
           
        }];
    }
    return _refresh;
}

@end
