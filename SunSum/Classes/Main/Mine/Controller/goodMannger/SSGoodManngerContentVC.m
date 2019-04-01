//
//  SSGoodManngerContentVC.m
//  SunSum
//
//  Created by hank on 2019/3/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSGoodManngerContentVC.h"
#import "SSGoodManngerCell.h"
#import "SSGoodManngerModel.h"
#import "SSAddGoodVC.h"

@interface SSGoodManngerContentVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
    NSInteger _type;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSGoodManngerContentVC

- (instancetype)initWithType:(NSInteger)type{
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
    dic[@"state"] = @(_type).description;
    return dic;
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    if(self.refresh.pageIndex == 1){
        kMeCallBlock(_finishBlock,self.refresh.response);
    }
    [self.refresh.arrData addObjectsFromArray:[SSGoodManngerModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSGoodManngerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSGoodManngerCell class]) forIndexPath:indexPath];
    SSGoodManngerModel *model = self.refresh.arrData[indexPath.row];
    [cell setUiWithModel:model];
    cell.delBlock = ^{
        SSAlertView *aler = [[SSAlertView alloc] initWithTitle:@"" message:@"确定删除商品?"];
        kMeWEAKSELF
        [aler addButtonWithTitle:@"确定" block:^{
            [SSPublicNetWorkTool postgetDelStoreGoodsWithProduct_id:kMeUnNilStr(model.product_id) SuccessBlock:^(ZLRequestResponse *responseObject) {
                kMeSTRONGSELF
                [strongSelf.refresh reload];
            } failure:^(id object) {
                
            }];
        }];
        [aler addButtonWithTitle:@"取消"];
        [aler show];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSGoodManngerCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSGoodManngerModel *model = self.refresh.arrData[indexPath.row];
    SSAddGoodVC *vc = [[SSAddGoodVC alloc]initWithProductId:kMeUnNilStr(model.product_id)];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)reloadNetData{
    [self.refresh reload];
}

#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kSSGoodManngerContentVCBootomHeigt) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSGoodManngerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSGoodManngerCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];;
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommongGoodsGetStoreGoods)];
        _refresh.isDataInside = YES;
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
            failView.lblOfNodata.text = @"没有商品";
        }];
    }
    return _refresh;
}

@end
