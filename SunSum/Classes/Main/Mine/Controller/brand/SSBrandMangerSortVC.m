//
//  SSBrandMangerSortVC.m
//  SunSum
//
//  Created by hank on 2019/3/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBrandMangerSortVC.h"
#import "SSBrandManngerVC.h"
#import "SSBrandAiCell.h"
#import "YBPopupMenu.h"
#import "SSBrandAISortModel.h"

const static CGFloat kselectViewHeight = 57;

@interface SSBrandMangerSortVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate,JXCategoryViewDelegate>{
    NSInteger _currentType;
    UIButton *_currntBtn;
    //1.按客户数 2.按互动数 3.按成交率
    NSString *_type;
    //1.客户总数 2.昨日新增客户
    NSString *_date;
    NSArray *_arrTitle;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIView *selectView;

@property (nonatomic, strong)  UIButton *btnAll;
@property (nonatomic, strong)  UIButton *btnSort;
@property (nonatomic, strong)  UIView *lineView;

@end

@implementation SSBrandMangerSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _type = @"1";
    _date = @"1";
    _arrTitle = @[@"客户",@"互动",@"成交率"];
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, kCategoryViewHeight)];
    //    self.categoryView.lineStyle = JXCategoryLineStyle_None;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = kSSPink;
    lineView.indicatorLineWidth = 32 * kMeFrameScaleX();
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.indicators = @[lineView];
    
    self.categoryView.titles = @[@"按客户数",@"按互动数",@"按成交率"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = kSSPink;
    [self.view addSubview:self.categoryView];
    self.categoryView.defaultSelectedIndex = _currentType;
    [self.view addSubview:self.selectView];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    NSDictionary *dic = @{@"token":kMeUnNilStr(kCurrentUser.token),@"type":kMeUnNilStr(_type),@"date":kMeUnNilStr(_date)};
    return dic;
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSBrandAISortModel mj_objectArrayWithKeyValuesArray:data]];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    NSString *title = _arrTitle[index];
    if(index == 2){
        [_btnAll setTitle:@"总成交率" forState:UIControlStateNormal];
        [_btnSort setTitle:@"昨日新增成交率" forState:UIControlStateNormal];
    }else{
        [_btnAll setTitle:[NSString stringWithFormat:@"%@总数",title] forState:UIControlStateNormal];
        [_btnSort setTitle:[NSString stringWithFormat:@"昨日新增%@",title] forState:UIControlStateNormal];
    }

    _type = @(index+1).description;
    [self.refresh reload];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSBrandAiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSBrandAiCell class]) forIndexPath:indexPath];
    SSBrandAISortModel *model = self.refresh.arrData[indexPath.row];
    [cell setSortUIWithModel:model sortNum:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSBrandAiCellHeight;
}

#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kCategoryViewHeight+kselectViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kSSBrandManngerVCHeaderHeight-kCategoryViewHeight-kselectViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSBrandAiCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSBrandAiCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    }
    return _tableView;
}

- (UIView *)selectView{
    if(!_selectView){
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, kCategoryViewHeight, SCREEN_WIDTH, kselectViewHeight)];
        _btnAll = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAll.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, kselectViewHeight);
        [_btnAll addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btnAll setTitle:@"客户总数" forState:UIControlStateNormal];
        _btnAll.titleLabel.font = kMeFont(13);
        [_btnAll setTitleColor:kSSblack forState:UIControlStateNormal];

        _btnAll.tag = kMeViewBaseTag;
        [_selectView addSubview:_btnAll];
        _currntBtn = _btnAll;
        
        _btnSort = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSort.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, kselectViewHeight);
        [_btnSort setTitle:@"昨日新增客户" forState:UIControlStateNormal];
        [_btnSort setTitleColor:kSSblack forState:UIControlStateNormal];
        [_btnSort addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnSort.titleLabel.font = kMeFont(13);
        _btnSort.tag = kMeViewBaseTag+1;
        [_selectView addSubview:_btnSort];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kselectViewHeight-12, 32, 2)];
        _lineView.backgroundColor = kSSPink;
        _lineView.centerX = _btnAll.centerX;
        [_selectView addSubview:_lineView];
    }
    return _selectView;
}

- (void)selectAction:(UIButton *)btn{
    if(_currntBtn == btn ){
        return;
    }
    _currntBtn = btn;
    _lineView.centerX = _currntBtn.centerX;
    NSInteger index = btn.tag - kMeViewBaseTag;
    _date = @(index+1).description;
    [self.refresh reload];
}



- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommongCustomerRankingList)];
        _refresh.isDataInside = YES;
        _refresh.delegate = self;
        _refresh.showMaskView = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有店铺";
        }];
    }
    return _refresh;
}


@end
