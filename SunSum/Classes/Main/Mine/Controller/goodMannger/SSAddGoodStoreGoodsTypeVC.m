//
//  SSAddGoodStoreGoodsTypeVC.m
//  SunSum
//
//  Created by hank on 2019/3/28.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAddGoodStoreGoodsTypeVC.h"
#import "SSAddGoodStoreGoodsTypeCell.h"
#import "SSAddGoodStoreGoodsType.h"

@interface SSAddGoodStoreGoodsTypeVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
   
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSAddGoodStoreGoodsTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品分类";
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    
}


- (NSDictionary *)requestParameter{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"token"] = kMeUnNilStr(kCurrentUser.token);
    return dic;
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSAddGoodStoreGoodsType mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSAddGoodStoreGoodsTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAddGoodStoreGoodsTypeCell class]) forIndexPath:indexPath];
    SSAddGoodStoreGoodsType *model = self.refresh.arrData[indexPath.row];
    cell.lblTitle.text = kMeUnNilStr(model.category_name);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSAddGoodStoreGoodsTypeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSAddGoodStoreGoodsType *model = self.refresh.arrData[indexPath.row];
    kMeCallBlock(_blcok,model);
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAddGoodStoreGoodsTypeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAddGoodStoreGoodsTypeCell class])];
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
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPGoodsGetCategory)];
        _refresh.numOfsize = @(100);
//        _refresh.isDataInside = YES;
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
            failView.lblOfNodata.text = @"没有分类";
        }];
    }
    return _refresh;
}
@end
