//
//  SSClerkWorkStatisticsServerLogVC.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkWorkStatisticsServerLogVC.h"
#import "SSClerkWorkStatisticsServerLogCell.h"
#import "SSClerkWorkStatisticsServerLogHeaderView.h"
#import "SSPickerYearView.h"
#import "SSClerkWorkStatisticsServerLogHeaderModel.h"
#import "SSClerkWorkStatisticsServerLogModel.h"

const static CGFloat kSSClerkWorkStatisticsServerSelectHeight = 37;
const static CGFloat kSSClerkWorkStatisticsServerSelectBtnWdith = 70;
@interface SSClerkWorkStatisticsServerLogVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate,JXCategoryViewDelegate>{
    NSInteger _currentMonth;
    NSString *_dateyear;
    NSString *_dateMonth;
    SSClerkWorkStatisticsServerLogHeaderModel *_model;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) SSClerkWorkStatisticsServerLogHeaderView *headerView;
@property (nonatomic, strong) UIButton *btnSelectYear;
@end

@implementation SSClerkWorkStatisticsServerLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f5fa"];
    _model = [SSClerkWorkStatisticsServerLogHeaderModel new];
    _currentMonth = [SSTimeTool getMonth] - 1;
    _dateyear = [NSString stringWithFormat:@"%ld", [SSTimeTool getYear]];
    _dateMonth= [NSString stringWithFormat:@"%02ld", [SSTimeTool getMonth]];
    self.title = @"工作统计";
    //1、初始化JXCategoryTitleView
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(kSSClerkWorkStatisticsServerSelectBtnWdith,kMeNavBarHeight, SCREEN_WIDTH-kSSClerkWorkStatisticsServerSelectBtnWdith, kSSClerkWorkStatisticsServerSelectHeight)];
    self.categoryView.indicators = @[];
    self.categoryView.titles = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    self.categoryView.delegate = self;
    self.categoryView.contentEdgeInsetLeft = 5;
    self.categoryView.titleColor = kSS999999;
    self.categoryView.titleFont = kMeFont(11);
    self.categoryView.titleSelectedColor = kSSblack;
    self.categoryView.defaultSelectedIndex = _currentMonth;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btnSelectYear];
    [self.view addSubview:self.categoryView];
   
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
}

- (void)getData{
    kMeWEAKSELF
    NSString *date = [NSString stringWithFormat:@"%@-%@",_dateyear,_dateMonth];
    [SSPublicNetWorkTool postgetSSIPcommonclerkserviceLogWithdate:date SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_model = [SSClerkWorkStatisticsServerLogHeaderModel mj_objectWithKeyValues:responseObject.data];
        [strongSelf.headerView setUiWIthModel:strongSelf->_model];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        [self getData];
    }
    NSString *date = [NSString stringWithFormat:@"%@-%@",_dateyear,_dateMonth];
    return @{@"token":kMeUnNilStr(kCurrentUser.token),@"date":kMeUnNilStr(date)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSClerkWorkStatisticsServerLogModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSClerkWorkStatisticsServerLogModel *model = self.refresh.arrData[indexPath.row];
    SSClerkWorkStatisticsServerLogCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkWorkStatisticsServerLogCell class]) forIndexPath:indexPath];
    [cell setUiWIthMOdel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSClerkWorkStatisticsServerLogCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)selectYearAction:(UIButton *)btn{
    kMeWEAKSELF
    SSPickerYearView *view = [[SSPickerYearView alloc]initWithSelectDaye:^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_dateyear = str;
        [strongSelf->_btnSelectYear setTitle:[str stringByAppendingString:@"年"]  forState:UIControlStateNormal];
        [strongSelf.refresh reload];
    }];
    [kMeCurrentWindow endEditing:YES];
    [kMeCurrentWindow addSubview:view];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    _currentMonth = index;
    _dateMonth= [NSString stringWithFormat:@"%02ld", _currentMonth+1];
    [self.refresh reload];
}

#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kSSClerkWorkStatisticsServerSelectHeight+kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kSSClerkWorkStatisticsServerSelectHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkWorkStatisticsServerLogCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkWorkStatisticsServerLogCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headerView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f6f5fa"];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonclerkclerkServiceLog)];
        _refresh.isDataInside = YES;
        _refresh.delegate = self;
        _refresh.showMaskView = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有数据";
        }];
    }
    return _refresh;
}

- (UIButton *)btnSelectYear{
    if(!_btnSelectYear){
        _btnSelectYear = [SSView btnWithFrame:CGRectMake(0, kMeNavBarHeight, kSSClerkWorkStatisticsServerSelectBtnWdith, kSSClerkWorkStatisticsServerSelectHeight) Img:nil title:@"2019年" target:self Action:@selector(selectYearAction:)];
        _btnSelectYear.titleLabel.font = kMeFont(11);
        [_btnSelectYear setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        _btnSelectYear.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btnSelectYear.backgroundColor = [UIColor whiteColor];
        [_btnSelectYear setImage:[UIImage imageNamed:@"selectdown"] forState:UIControlStateNormal];
        [_btnSelectYear setButtonImageTitleStyle:ButtonImageTitleStyleRight padding:0];
        
    }
    return _btnSelectYear;
}

- (SSClerkWorkStatisticsServerLogHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSClerkWorkStatisticsServerLogHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH,kSSClerkWorkStatisticsServerLogHeaderViewHeight);
    }
    return _headerView;
}

@end
