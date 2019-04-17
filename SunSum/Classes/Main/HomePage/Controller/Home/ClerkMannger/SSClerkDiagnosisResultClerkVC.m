//
//  SSClerkDiagnosisResultClerkVC.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkDiagnosisResultClerkVC.h"
#import "SSClerkDiagnosisResultClerkCell.h"
#import "SSClerkDiagnosisResultClerkHeaderView.h"

@interface SSClerkDiagnosisResultClerkVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,strong) UIView *cview;
@property (nonatomic,strong) SSClerkDiagnosisResultClerkHeaderView *headerView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSClerkDiagnosisResultClerkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    self.view.backgroundColor =kSS171c30;
    [self.view addSubview:self.cview];
    [self.cview addSubview:self.headerView];
    [self.cview addSubview:self.tableView];
     [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

- (NSDictionary *)requestParameter{
    [self.refresh.arrData addObjectsFromArray:@[@"",@"",@"",@""]];
    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[NSObject mj_objectArrayWithKeyValuesArray:data]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSClerkDiagnosisResultClerkCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkDiagnosisResultClerkCell class]) forIndexPath:indexPath];
    NSObject *model = self.refresh.arrData[indexPath.row];
    [cell setUIWithModel:model sort:indexPath.row + 1];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSClerkDiagnosisResultClerkCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kSSClerkDiagnosisResultClerkHeaderViewHeight, SCREEN_WIDTH-30, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-249-15-kSSClerkDiagnosisResultClerkHeaderViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkDiagnosisResultClerkCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkDiagnosisResultClerkCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kSS262d47;
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(@"")];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        _refresh.showMaskView = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有员工";
        }];
    }
    return _refresh;
}

- (UIView *)cview{
    if(!_cview){
        _cview = [[UIView alloc]initWithFrame:CGRectMake(15,0, SCREEN_WIDTH-30, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-249-15)];
        _cview.backgroundColor = [UIColor colorWithHexString:@"262d47"];
        _cview.cornerRadius = 11;
        _cview.clipsToBounds = YES;
    }
    return _cview;
}

- (SSClerkDiagnosisResultClerkHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSClerkDiagnosisResultClerkHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH-30, kSSClerkDiagnosisResultClerkHeaderViewHeight);
        kMeWEAKSELF
        _headerView.indexBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            [strongSelf.refresh reload];
        };
    }
    return _headerView;
}

@end
