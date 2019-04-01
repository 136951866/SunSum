//
//  SSNewStoreDetailsVC.m
//  SunSum
//
//  Created by hank on 2018/10/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSNewStoreDetailsVC.h"
#import "SSStoreDetailHeaderView.h"
#import "SSStoreDetailCell.h"
#import "SSStoreHomeIntroduceCell.h"
#import "SSServiceDetailsVC.h"
#import "SSStoreDetailModel.h"
#import "SSGoodModel.h"


@interface SSNewStoreDetailsVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    BOOL _isExpand;
    NSInteger _detailsId;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) SSStoreDetailHeaderView *headerView;
@property (nonatomic, strong) SSStoreDetailModel *model;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSNewStoreDetailsVC

- (instancetype)initWithId:(NSInteger)detailsId{
    if(self = [super init]){
        _detailsId = detailsId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"门店详情";
    [self initWithSomeThing];
}

- (void)initWithSomeThing{
    kMeWEAKSELF
    [SSPublicNetWorkTool postStroeDetailWithGoodsId:_detailsId successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        SSStoreDetailModel *model = [SSStoreDetailModel mj_objectWithKeyValues:responseObject.data];
        [strongSelf setUIWithModel:model];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    return @{@"type":@(SSGoodsTypeNetServiceStyle),@"pageSize":@(100),@"uid":kMeUnNilStr(kCurrentUser.uid)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSGoodModel mj_objectArrayWithKeyValuesArray:data]];
}


- (void)setUIWithModel:(SSStoreDetailModel *)model{
    _isExpand = NO;
    _model = model;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    [self.refresh addRefreshView];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else{
        return self.refresh.arrData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        SSStoreHomeIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSStoreHomeIntroduceCell class]) forIndexPath:indexPath];
        kMeWEAKSELF
        [cell setUIWithModel:_model isExpand:_isExpand ExpandBlock:^(BOOL isExpand) {
            kMeSTRONGSELF
            strongSelf->_isExpand = isExpand;
            [strongSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        return cell;
    }else{
        SSStoreDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSStoreDetailCell class]) forIndexPath:indexPath];
        SSGoodModel *model = self.refresh.arrData[indexPath.row];
        [cell setUIWithModel:model];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return [SSStoreHomeIntroduceCell getCellHeightWithModel:_model isExpand:_isExpand];
    }else{
        return kSSStoreDetailCellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section){
        SSGoodModel *model = self.refresh.arrData[indexPath.row];
        SSServiceDetailsVC *vc = [[SSServiceDetailsVC alloc]initWithId:model.product_id storeDetailModel:_model];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSStoreHomeIntroduceCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSStoreHomeIntroduceCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSStoreDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSStoreDetailCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (SSStoreDetailHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSStoreDetailHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [SSStoreDetailHeaderView getViewHeight:_model]);
        [_headerView setUIWithModel:_model];
    }
    return _headerView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonGoodsGetGoodsList)];
        _refresh.delegate = self;
        _refresh.numOfsize = @(100);
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有服务";
        }];
    }
    return _refresh;
}




@end
