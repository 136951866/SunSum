//
//  SSInteralExchangVC.m
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSInteralExchangVC.h"
#import "SSMineExchangeCell.h"
#import "SSMineExchangeDetailVC.h"
#import "SSGoodModel.h"

const static CGFloat kImgMainHeight = 114;

@interface SSInteralExchangVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) UIImageView *imgMain;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSInteralExchangVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"美豆兑换";
//    _arrData = @[@"",@"",@"",@"",@"",@"",@"",@""];
//    kSDLoadImg(self.imgMain , @"");
//    self.tableView.tableHeaderView = self.imgMain;
    [self.view addSubview:self.tableView];
//    [self.tableView reloadData];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

- (NSDictionary *)requestParameter{
    return @{@"type":@"4"};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSGoodModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //SSStoreModel *storeModel = self.arrStore[section];
    return self.refresh.arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSGoodModel *model = self.refresh.arrData[indexPath.row];
    SSMineExchangeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSMineExchangeCell class]) forIndexPath:indexPath];
    kMeWEAKSELF
    [cell setUIWithModel:model ExchangeBlock:^{
        kMeSTRONGSELF
        SSMineExchangeDetailVC *detailVC = [[SSMineExchangeDetailVC alloc]initWithId:model.product_id];
        [strongSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSMineExchangeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSGoodModel *model = self.refresh.arrData[indexPath.row];
    SSMineExchangeDetailVC *detailVC = [[SSMineExchangeDetailVC alloc]initWithId:model.product_id];
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMineExchangeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSMineExchangeCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (UIImageView *)imgMain{
    if(!_imgMain){
        _imgMain = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kImgMainHeight)];
        _imgMain.contentMode = UIViewContentModeScaleAspectFill;
        _imgMain.clipsToBounds = YES;
    }
    return _imgMain;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonFindManyGoods)];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有地址";
        }];
    }
    return _refresh;
}


@end
