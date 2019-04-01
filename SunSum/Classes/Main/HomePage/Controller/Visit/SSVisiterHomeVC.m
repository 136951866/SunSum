//
//  SSVisiterHomeVC.m
//  SunSum
//
//  Created by hank on 2018/11/28.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSVisiterHomeVC.h"
#import "SSVisitHomeHeaderView.h"
#import "SSVisterTodySectionView.h"
#import "SSVisterTodyCell.h"
#import "SSVisterSectionView.h"
#import "SSVistorVisterCell.h"
#import "SSVistorPathVC.h"
#import "SSVistorCountModel.h"
#import "SSVistorUserModel.h"

@interface SSVisiterHomeVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
    MyEnumkSSVisterSectionViewType _type;
}

@property (nonatomic , strong) SSVisitHomeHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic , strong) UIView *viewForNav;
@property (nonatomic , strong) SSVisterTodyCell *vCell;
@property (nonatomic , strong) SSVistorCountModel *countModel;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSVisiterHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    self.view.backgroundColor = kSSPink;
    _type = MyEnumkSSVisterSectionViewAllType;
    [self.view addSubview:self.viewForNav];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNetWork)];
//    [self.tableView.mj_header beginRefreshing];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        [self requestNetWork];
    }
    switch (_type) {
        case MyEnumkSSVisterSectionViewAllType:{
            return @{@"token":kMeUnNilStr(kCurrentUser.token)};
        }
        break;
        case MyEnumkSSVisterSectionViewHopeType:{
            return @{@"token":kMeUnNilStr(kCurrentUser.token),@"is_intention":@"2"};
        }
            break;
        case MyEnumkSSVisterSectionViewVisterType:{
            return @{@"token":kMeUnNilStr(kCurrentUser.token),@"is_intention":@"1"};
        }
            break;
        default:
            return @{};
            break;
    }
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSVistorUserModel mj_objectArrayWithKeyValuesArray:data]];
}

- (void)requestNetWork{
//    self.refresh.pageIndex = 1;
//    [self.refresh.arrData removeAllObjects];
    kMeWEAKSELF
    [SSPublicNetWorkTool postGetAccessWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf.countModel = [SSVistorCountModel mj_objectWithKeyValues:responseObject.data];
        [strongSelf.headerView setUIWithModel:strongSelf.countModel];
        [strongSelf.tableView reloadData];
//        [strongSelf.tableView.mj_header endRefreshing];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)pop:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!section){
        return 1;
    }
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        if(!_vCell){
            _vCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSVisterTodyCell class]) forIndexPath:indexPath];
        }
        NSInteger count = [self.countModel.article_count integerValue];
        NSInteger countposter = [self.countModel.poster_count integerValue];
        NSNumber *countNum = [NSNumber numberWithInteger:count];
        NSNumber *countposterNum = [NSNumber numberWithInteger:countposter];
        [_vCell setUiWithModel:countNum posterCount:countposterNum];
        return _vCell;
    }
    SSVistorUserModel *model = self.refresh.arrData[indexPath.row];
    SSVistorVisterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSVistorVisterCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:model];
    kMeWEAKSELF
    cell.setIntenBlock = ^{
        kMeSTRONGSELF
        [strongSelf.refresh reload];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return kSSVisterTodyCellwHeight;
    }
    return kSSVistorVisterCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(!section){
       return kSSVisterTodySectionViewHeight;
    }
    return kSSVisterSectionViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(!section){
        SSVisterTodySectionView *headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SSVisterTodySectionView class])];
        return headview;
    }else{
        SSVisterSectionView *headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SSVisterSectionView class])];
        kMeWEAKSELF
        [headview setTypeWithType:_type block:^(NSInteger index) {
            kMeSTRONGSELF
            strongSelf->_type = index;
            [strongSelf.refresh reload];
        }];
        return headview;
    }
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSVisterTodyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSVisterTodyCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSVisterTodySectionView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SSVisterTodySectionView class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSVisterSectionView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SSVisterSectionView class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSVistorVisterCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSVistorVisterCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}


- (SSVisitHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSVisitHomeHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [SSVisitHomeHeaderView getViewHeight]);
    }
    return _headerView;
}

- (UIView *)viewForNav{
    if(!_viewForNav){
        _viewForNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kMeNavBarHeight)];
        _viewForNav.backgroundColor = kSSPink;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kMeStatusBarHeight, 50, kMeNavBarHeight-kMeStatusBarHeight);
        [btn setImage:[UIImage imageNamed:@"icon-rrqcdatuud"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
        [_viewForNav addSubview:btn];
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(btn.right + 14, kMeStatusBarHeight, SCREEN_WIDTH-128, kMeNavBarHeight-kMeStatusBarHeight)];
        lbl.text = @"访问";
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont systemFontOfSize:20];
        lbl.textColor = [UIColor whiteColor];
        [_viewForNav addSubview:lbl];
    }
    return _viewForNav;
}

- (SSVistorCountModel *)countModel{
    if(!_countModel){
        _countModel = [SSVistorCountModel new];
    }
    return _countModel;
}


- (ZLRefreshTool *)refresh{
    if(!_refresh){
        if(!_refresh){
            _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonGetAccessUser)];
            _refresh.delegate = self;
            _refresh.showFailView = NO;
            _refresh.isDataInside = YES;
        }
        return _refresh;
    }
    return _refresh;
}


@end
