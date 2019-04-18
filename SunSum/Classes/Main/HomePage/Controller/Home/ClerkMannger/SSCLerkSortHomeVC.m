//
//  SSCLerkSortHomeVC.m
//  SunSum
//
//  Created by hank on 2019/4/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCLerkSortHomeVC.h"
#import "SSCLerkSortHomeCell.h"
#import "SPullDownMenuView.h"
#import "SSNewClerkManngerModel.h"

const static CGFloat kmenuHeight = 44;

@interface SSCLerkSortHomeVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate,SPullDownMenuViewDelegate>
{
    NSInteger _order_type;
    NSInteger _order_date_type;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) SPullDownMenuView *menu;
@property (nonatomic, strong) UILabel *lblAllCOunt;

@end

@implementation SSCLerkSortHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"员工排名";
    _order_type = 1;
    _order_date_type = 1;
    [self.view addSubview:self.menu];
    [self.view addSubview:self.tableView];
    [self.view addSubview:[self getBottomView]];
    [self.refresh addRefreshView];
}

- (NSDictionary *)requestParameter{
    return @{@"token":kMeUnNilStr(kCurrentUser.token),@"order_type":@(_order_type),@"order_date_type":@(_order_date_type)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    _lblAllCOunt.text = @(self.refresh.allRows).description;
    [self.refresh.arrData addObjectsFromArray:[SSNewClerkManngerDataContentModel mj_objectArrayWithKeyValuesArray:data]];
}


- (void)pullDownMenuView:(SPullDownMenuView *)menu didSelectedIndex:(NSIndexPath *)indexPath{
    NSLog(@"%@---%@",@(indexPath.section),@(indexPath.row));
    if(indexPath.row == 0){
        _order_type = indexPath.section +1;
        NSLog(@"%@",@(_order_type));
    }else{
        _order_date_type = indexPath.section +1;
        NSLog(@"%@",@(_order_date_type));
    }
    [self.refresh reload];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSCLerkSortHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSCLerkSortHomeCell class]) forIndexPath:indexPath];
    SSNewClerkManngerDataContentModel *model = self.refresh.arrData[indexPath.row];
    [cell setUIWithModel:model sort:indexPath.row + 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSCLerkSortHomeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight+kmenuHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kmenuHeight-kmenuHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSCLerkSortHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSCLerkSortHomeCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonclerkclerkOrderCount)];
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

- (SPullDownMenuView *)menu{
    if(!_menu){
        NSArray *arr = @[@[@"分享数", @"沟通数", @"客户数"], @[@"本月",@"上月",@"昨天",@"今天"]];
        _menu = [[SPullDownMenuView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, kmenuHeight) withTitle:arr withSelectColor:kSSPink];
        _menu.delegate = self;
    }
    return _menu;
}

-(UIView *)getBottomView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kmenuHeight, SCREEN_WIDTH, kmenuHeight)];
    UILabel *lbl = [SSView lblWithFram:CGRectMake(15, 0, 40, kmenuHeight) textColor:[UIColor colorWithHexString:@"169DFF"] str:@"总计" font:kMeFont(13)];
    [view addSubview:lbl];
    _lblAllCOunt = [SSView lblWithFram:CGRectMake(lbl.right + 15, 0, SCREEN_WIDTH - 85, kmenuHeight) textColor:[UIColor colorWithHexString:@"169DFF"] str:@"0" font:kMeFont(13) align:NSTextAlignmentCenter];
    [view addSubview:_lblAllCOunt];
    return view;
}

@end

