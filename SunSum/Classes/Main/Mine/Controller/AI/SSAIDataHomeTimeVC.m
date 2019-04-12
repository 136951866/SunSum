//
//  SSAIDataHomeTimeVC.m
//  SS时代
//
//  Created by hank on 2019/4/9.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAIDataHomeTimeVC.h"
#import "SSAIDataHomeTimeCell.h"
#import "SSAIDataHomeTimeModel.h"
#import "SSNavigationVC.h"
#import "SSAiCustomerDetailVC.h"

@interface SSAIDataHomeTimeVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSAIDataHomeTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    SSNavigationVC *nav = (SSNavigationVC *)self.navigationController;
//    nav.canDragBack = NO;
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    SSNavigationVC *nav = (SSNavigationVC *)self.navigationController;
//    nav.canDragBack = YES;;
//}

- (NSDictionary *)requestParameter{
    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSAIDataHomeTimeModel mj_objectArrayWithKeyValuesArray:data]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSAIDataHomeTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAIDataHomeTimeCell class]) forIndexPath:indexPath];
    SSAIDataHomeTimeModel *model = self.refresh.arrData[indexPath.row];
    [cell setUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSAIDataHomeTimeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSAIDataHomeTimeModel *model = self.refresh.arrData[indexPath.row];
    SSAiCustomerDetailVC *vc = [[SSAiCustomerDetailVC alloc]initWithUserId:kMeUnNilStr(model.uid)];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAIDataHomeTimeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAIDataHomeTimeCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =[UIColor colorWithHexString:@"f4f4f4"];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonairadartime)];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有用户";
        }];
    }
    return _refresh;
}

@end
