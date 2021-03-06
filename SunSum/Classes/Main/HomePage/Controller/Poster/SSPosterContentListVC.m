//
//  SSPosterContentListVC.m
//  SunSum
//
//  Created by hank on 2018/11/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSPosterContentListVC.h"
#import "SSPosterContentListCell.h"
#import "SSPosterMoreListVC.h"
#import "SSPosterModel.h"

@interface SSPosterContentListVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) UIView         *headerView;

@end

@implementation SSPosterContentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.refresh addHeadRefreshView];
}

- (NSDictionary *)requestParameter{
    return @{};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSPosterModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSPosterContentListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSPosterContentListCell class]) forIndexPath:indexPath];
    //    kMeWEAKSELF
    SSPosterModel *model = self.refresh.arrData[indexPath.row];
    kMeWEAKSELF
    cell.moreBlock = ^{
        kMeSTRONGSELF
        SSPosterMoreListVC *vc = [[SSPosterMoreListVC alloc]initWithModel:model];
        [strongSelf.navigationController pushViewController:vc animated:YES];
    };
    [cell setUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSPosterModel *model = self.refresh.arrData[indexPath.row];
    return [SSPosterContentListCell getCellWithModel:model];
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSPosterContentListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSPosterContentListCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonGetPostersClass)];
//        _refresh.isDataInside = YES;
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有海报";
        }];
    }
    return _refresh;
}

- (UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 82)];
        _headerView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 10, SCREEN_WIDTH-24, 82-20)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-24-20, 16)];
        lbl.font = [UIFont systemFontOfSize:15];
        lbl.text = @"海报模版";
        UILabel *lbls = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+16+5, SCREEN_WIDTH-24-20, 16)];
        lbls.font = [UIFont systemFontOfSize:12];
        lbls.textColor = [UIColor colorWithHexString:@"5b5b5b"];
        lbls.text = @"及时跟踪,让问候海报成为你的独家神器";
        [view addSubview:lbl];
        [view addSubview:lbls];
        [_headerView addSubview:view];
    }
    return _headerView;
}

@end
