//
//  SSAICustomerHomeContentVC.m
//  SS时代
//
//  Created by hank on 2019/4/10.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAICustomerHomeContentVC.h"
#import "SSAICustomerHomeCell.h"
#import "SSAICustomerHomeModel.h"
#import "SSAICustomerHomeHeaderSearchView.h"
#import "SSAiCustomerDetailVC.h"

@interface SSAICustomerHomeContentVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
    SSAICustomerHomeContentVCType _type;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;

@end

@implementation SSAICustomerHomeContentVC

- (instancetype)initWithType:(SSAICustomerHomeContentVCType)type{
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

- (NSDictionary *)requestParameter{
    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSAICustomerHomeModel mj_objectArrayWithKeyValuesArray:data]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSAICustomerHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAICustomerHomeCell class]) forIndexPath:indexPath];
    SSAICustomerHomeModel *model = self.refresh.arrData[indexPath.row];
    [cell setUiWithAddModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSAICustomerHomeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSAICustomerHomeModel *model = self.refresh.arrData[indexPath.row];
    SSAiCustomerDetailVC *vc = [[SSAiCustomerDetailVC alloc]initWithUserId:kMeUnNilStr(model.uid)];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return k10Margin;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, k10Margin)];
    view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    return view;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kMeTabBarHeight-kSSAICustomerHomeHeaderSearchViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAICustomerHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAICustomerHomeCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =[UIColor colorWithHexString:@"f4f4f4"];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        NSString *staApi = @"";
        switch (_type) {
            case SSAICustomerHomeContentVCAddType:
                staApi = kGetApiWithUrl(SSIPcommonaigetjoinTime);
                break;
            case SSAICustomerHomeContentVCFollowType:
                staApi = kGetApiWithUrl(SSIPcommonaigetupdateFollow);
                break;
            case SSAICustomerHomeContentVCActiveType:
                staApi = kGetApiWithUrl(SSIPcommonaigetactive);
                break;
            default:
                break;
        }
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:staApi];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有客户";
            failView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        }];
    }
    return _refresh;
}

@end

