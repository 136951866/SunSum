//
//  SSClerkTaskMoreVC.m
//  SunSum
//
//  Created by hank on 2019/4/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkTaskMoreVC.h"
#import "SSClerkTaskContentCell.h"
#import "SSNewClerkManngerModel.h"

@interface SSClerkTaskMoreVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSClerkTaskMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店员任务";
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
}

- (NSDictionary *)requestParameter{
    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSNewClerkManngerClerkTaskpercentModel mj_objectArrayWithKeyValuesArray:data]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSClerkTaskContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkTaskContentCell class]) forIndexPath:indexPath];
    SSNewClerkManngerClerkTaskpercentModel *model = self.refresh.arrData[indexPath.row];
    [cell setUIWIthModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSClerkTaskContentCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-90) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkTaskContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkTaskContentCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonclerkclerkTaskMore)];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor clearColor];
            failView.lblOfNodata.text = @"没有任务";
        }];
    }
    return _refresh;
}

@end
