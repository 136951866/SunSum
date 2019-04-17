//
//  SSClerkWorkStatisticsCustomerVistVC.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkWorkStatisticsCustomerVistVC.h"
#import "SSClerkWorkStatisticsCustomerVistCell.h"
#import "SSClerkWorkStatisticsCustomerVistHeaderView.h"
#import "SSPickerYearView.h"

const static CGFloat kSSClerkWorkStatisticsCustomerSelectHeight = 37;
const static CGFloat kSSClerkWorkStatisticsCustomerSelectBtnWdith = 70;

@interface SSClerkWorkStatisticsCustomerVistVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate,JXCategoryViewDelegate>{
    NSInteger _currentMonth;

}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) UIButton *btnSelectYear;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) SSClerkWorkStatisticsCustomerVistHeaderView *headerView;


@end

@implementation SSClerkWorkStatisticsCustomerVistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f5fa"];
    _currentMonth = 0;
    //1、初始化JXCategoryTitleView
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(kSSClerkWorkStatisticsCustomerSelectBtnWdith,0, SCREEN_WIDTH-kSSClerkWorkStatisticsCustomerSelectBtnWdith, kSSClerkWorkStatisticsCustomerSelectHeight)];
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

- (NSDictionary *)requestParameter{
    [self.refresh.arrData addObjectsFromArray:@[@"",@"",@""]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    return dic;
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[NSObject mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.refresh.arrData[indexPath.row];
    SSClerkWorkStatisticsCustomerVistCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkWorkStatisticsCustomerVistCell class]) forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSClerkWorkStatisticsCustomerVistCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)selectYearAction:(UIButton *)btn{
    kMeWEAKSELF
    SSPickerYearView *view = [[SSPickerYearView alloc]initWithSelectDaye:^(NSString *str) {
        kMeSTRONGSELF
        [strongSelf->_btnSelectYear setTitle:str forState:UIControlStateNormal];
    }];
    [kMeCurrentWindow endEditing:YES];
    [kMeCurrentWindow addSubview:view];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    
}

#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kSSClerkWorkStatisticsCustomerSelectHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kSSClerkWorkStatisticsCustomerSelectHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkWorkStatisticsCustomerVistCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkWorkStatisticsCustomerVistCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f6f5fa"];
    }
    return _tableView;
}

- (UIButton *)btnSelectYear{
    if(!_btnSelectYear){
        _btnSelectYear = [SSView btnWithFrame:CGRectMake(0, 0, kSSClerkWorkStatisticsCustomerSelectBtnWdith, kSSClerkWorkStatisticsCustomerSelectHeight) Img:nil title:@"2019年" target:self Action:@selector(selectYearAction:)];
        _btnSelectYear.titleLabel.font = kMeFont(11);
        [_btnSelectYear setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        _btnSelectYear.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btnSelectYear.backgroundColor = [UIColor whiteColor];
        [_btnSelectYear setImage:[UIImage imageNamed:@"selectdown"] forState:UIControlStateNormal];
        [_btnSelectYear setButtonImageTitleStyle:ButtonImageTitleStyleRight padding:0];
        
    }
    return _btnSelectYear;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(@"")];
        _refresh.isDataInside = YES;
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有数据";
        }];
    }
    return _refresh;
}

- (SSClerkWorkStatisticsCustomerVistHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSClerkWorkStatisticsCustomerVistHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH,kSSClerkWorkStatisticsCustomerVistHeaderViewHeight);
    }
    return _headerView;
}

@end
