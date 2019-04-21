//
//  SSClerkTGetTaskListContentVC.m
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkTGetTaskListContentVC.h"
#import "kSSClerkPlanAchieveListCell.h"
#import "SSClerkPlanAchieveClerkModel.h"
#import "SSClerkTaskDetailVC.h"

@interface SSClerkTGetTaskListContentVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
    NSInteger _index;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSClerkTGetTaskListContentVC


- (instancetype)initWithType:(NSInteger)type{
    if(self = [super init]){
        _index = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

- (NSDictionary *)requestParameter{
    return @{@"token":kMeUnNilStr(kCurrentUser.token),@"status":@(_index)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSClerkPlanAchieveClerkModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kSSClerkPlanAchieveListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([kSSClerkPlanAchieveListCell class]) forIndexPath:indexPath];
    SSClerkPlanAchieveClerkModel *model = self.refresh.arrData[indexPath.row];
    [cell setUIWIthModel:model sort:indexPath.row+1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kkSSClerkPlanAchieveListCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSClerkPlanAchieveClerkModel *model = self.refresh.arrData[indexPath.row];
    SSClerkTaskDetailVC *vc = [[SSClerkTaskDetailVC alloc]initWithTaskId:@(model.idField).description];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([kSSClerkPlanAchieveListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([kSSClerkPlanAchieveListCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        UIView *ivew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        ivew.backgroundColor = kSSf6f5fa;
        _tableView.tableHeaderView = ivew;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonclerkTaskListByStatus)];
        _refresh.isDataInside = YES;
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有任务";
        }];
    }
    return _refresh;
}


@end

