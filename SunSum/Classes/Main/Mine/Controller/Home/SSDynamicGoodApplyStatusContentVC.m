//
//  SSDynamicGoodApplyStatusContentVC.m
//  SunSum
//
//  Created by hank on 2019/3/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSDynamicGoodApplyStatusContentVC.h"
#import "SSDynamicGoodApplyStatusCell.h"
#import "SSDynamicGoodApplyModel.h"
#import "SSDynamicGoodApplyVC.h"

@interface SSDynamicGoodApplyStatusContentVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
    SSDynamicGoodApplyStatusContentType _type;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSDynamicGoodApplyStatusContentVC

- (instancetype)initWithType:(SSDynamicGoodApplyStatusContentType)type{
    if(self = [super init]){
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
}

- (NSDictionary *)requestParameter{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"token"] = kMeUnNilStr(kCurrentUser.token);
    dic[@"status"] = @(_type).description;
    return dic;
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSDynamicGoodApplyModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSDynamicGoodApplyStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSDynamicGoodApplyStatusCell class]) forIndexPath:indexPath];
    SSDynamicGoodApplyModel *model = self.refresh.arrData[indexPath.row];
    [cell setUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSDynamicGoodApplyStatusCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSDynamicGoodApplyModel *model = self.refresh.arrData[indexPath.row];
    SSDynamicGoodApplyVC *vc = [[SSDynamicGoodApplyVC alloc]init];
    vc.parModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSDynamicGoodApplyStatusCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSDynamicGoodApplyStatusCell class])];
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
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommongXunweishiApplyList)];
        _refresh.isDataInside = YES;
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有申请记录";
        }];
    }
    return _refresh;
}

@end
