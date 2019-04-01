//
//  SSBrandAbilityDataVC.m
//  SunSum
//
//  Created by hank on 2019/3/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBrandAbilityDataVC.h"
#import "SSBrandAbilityManngerVC.h"
#import "SSBrandAllDataCell.h"
#import "SSBrandTriangleCell.h"
#import "SSBrandAreasplineCell.h"
#import "SSBrandManngerAllModel.h"
#import "SSBrandPieCell.h"
#import "SSBrandAISortModel.h"

@interface SSBrandAbilityDataVC ()<UITableViewDelegate, UITableViewDataSource,JXCategoryViewDelegate>{
    NSInteger _currentType;
    SSBrandManngerAllModel *_model;
    SSBrandAISortModel *_sortModel;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation SSBrandAbilityDataVC

- (instancetype)initWithModel:(SSBrandAISortModel *)model{
    if(self = [super init]){
        _sortModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentType = 0;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headrefresh)];
    [self.tableView.mj_header beginRefreshing];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, kCategoryViewHeight)];
    //    self.categoryView.lineStyle = JXCategoryLineStyle_None;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = kSSPink;
    self.categoryView.indicators = @[lineView];
    
    self.categoryView.titles = @[@"全部",@"昨天",@"7天",@"30天"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = kSSPink;
    [self.view addSubview:self.categoryView];
    self.categoryView.defaultSelectedIndex = _currentType;
    _maskView = [[UIView alloc]initWithFrame:self.view.bounds];
    _maskView.hidden = YES;
    [self.view addSubview:_maskView];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    _currentType = index;
    kMeWEAKSELF
    [self.tableView.mj_header beginRefreshing];
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _maskView.hidden = NO;
    [SSPublicNetWorkTool postgetStoreDatAnalysisWithDate:@(_currentType+1).description storeId:_sortModel.store_id  SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_model = [SSBrandManngerAllModel mj_objectWithKeyValues:responseObject.data];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        //        [hud hideAnimated:YES];
        strongSelf->_maskView.hidden = YES;
    } failure:^(id object) {
        kMeSTRONGSELF
        strongSelf->_model = [SSBrandManngerAllModel new];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        //        [hud hideAnimated:YES];
        strongSelf->_maskView.hidden = YES;
    }];
}

- (void)headrefresh{
    kMeWEAKSELF
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _maskView.hidden = NO;
    
    [SSPublicNetWorkTool postgetStoreDatAnalysisWithDate:@(_currentType+1).description storeId:_sortModel.store_id SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_model = [SSBrandManngerAllModel mj_objectWithKeyValues:responseObject.data];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        //        [hud hideAnimated:YES];
        strongSelf->_maskView.hidden = YES;
        
    } failure:^(id object) {
        kMeSTRONGSELF
        strongSelf->_model = [SSBrandManngerAllModel new];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        //        [hud hideAnimated:YES];
        strongSelf->_maskView.hidden = YES;
        
    }];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        SSBrandAllDataCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSBrandAllDataCell class]) forIndexPath:indexPath];
        [cell setUIWithModel:_model];
        return cell;
    }else if (indexPath.row == 1){
        SSBrandTriangleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSBrandTriangleCell class]) forIndexPath:indexPath];
        [cell setUIWithModel:_model];
        return cell;
    }else if(indexPath.row == 2){
        SSBrandAreasplineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSBrandAreasplineCell class]) forIndexPath:indexPath];
        [cell setUiWithModel:kMeUnArr(_model.alive_member) title:@"近7日客户活跃度" subTitle:@"活跃度"];
        return cell;
    }else if(indexPath.row == 3){
        SSBrandPieCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSBrandPieCell class]) forIndexPath:indexPath];
        [cell setUiWithModel:kMeUnArr(_model.customer_interest)];
        return cell;
    }else if(indexPath.row == 4){
        SSBrandAreasplineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSBrandAreasplineCell class]) forIndexPath:indexPath];
        [cell setUiWithModel:kMeUnArr(_model.anew_member) title:@"近7日新增客户数"  subTitle:@"客户数"];
        return cell;
    }else{
        return [UITableViewCell new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        return kSSBrandAllDataCellHeight;
    }else if (indexPath.row == 1){
        return kSSBrandTriangleCellHeight;
    }else  if(indexPath.row == 2){
        return kSSBrandAreasplineCellHeight;
    }else  if(indexPath.row == 3){
        return kSSBrandPieCellHeight;
    }else  if(indexPath.row == 4){
        return kSSBrandAreasplineCellHeight;
    }else{
        return 0.1;
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kCategoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kSSBrandAbilityManngerVCHeight-kCategoryViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSBrandAllDataCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSBrandAllDataCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSBrandTriangleCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSBrandTriangleCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSBrandAreasplineCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSBrandAreasplineCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSBrandPieCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSBrandPieCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}



@end
