//
//  SSGetCaseMainVC.m
//  SunSum
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSGetCaseMainVC.h"
#import "SSGetCaseMainCell.h"
#import "SSGetCaseContentVC.h"
#import "SSGetCaseMainModel.h"

@interface SSGetCaseMainVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    SSGetCaseStyle _type;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;


@end

@implementation SSGetCaseMainVC

- (instancetype)initWithType:(SSGetCaseStyle)type{
    if(self = [super init]){
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"token"] = kMeUnNilStr(kCurrentUser.token);
    switch (_type) {
        case SSGetCaseAllStyle:{
            
        }
            break;
        case SSGetCaseingStyle:
        {
            dic[@"state"] = @"1";
        }
            break;
        case SSGetCaseedStyle:
        {
            dic[@"state"] = @"2";
        }
            break;
        case SSGetCasenotStyle:
        {
            dic[@"state"] = @"-1";
        }
            break;
        case SSGetCasePayEdStyle:
        {
            dic[@"state"] = @"3";
        }
            break;
        default:
            break;
    }
    return dic;
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSGetCaseMainModel mj_objectArrayWithKeyValuesArray:data]];
}


#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSGetCaseMainModel *model = self.refresh.arrData[indexPath.row];
    SSGetCaseMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSGetCaseMainCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSGetCaseMainModel *model = self.refresh.arrData[indexPath.row];
    return [SSGetCaseMainCell getCellHeightWithModel:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSGetCaseMainModel *model = self.refresh.arrData[indexPath.row];
    SSGetCaseContentVC *vc = [[SSGetCaseContentVC alloc]initWithMoney_check_sn:kMeUnNilStr(model.order_sn)];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSGetCaseMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSGetCaseMainCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        view.backgroundColor = [UIColor colorWithHexString:@"f1f2f6"];
        _tableView.tableFooterView = view;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f1f2f6"];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommondestoonFinanceCashListh)];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有提现";
        }];
    }
    return _refresh;
}
@end
