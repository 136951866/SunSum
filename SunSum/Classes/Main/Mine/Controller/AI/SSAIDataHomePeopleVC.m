//
//  SSAIDataHomePeopleVC.m
//  SS时代
//
//  Created by hank on 2019/4/10.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAIDataHomePeopleVC.h"
#import "SSAIDataHomeTimeCell.h"
#import "SSAIDataHomeTimeModel.h"
#import "SSAIDataHomeActiveHomeView.h"
#import "SSAiCustomerDetailVC.h"

@interface SSAIDataHomePeopleVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
    SSAIDataHomeActiveHomeViewType _type;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool *refresh;
//@property (nonatomic , strong) SSAIDataHomeActiveHomeView *headerView;

@end

@implementation SSAIDataHomePeopleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _type = SSAIDataHomeActiveHomeViewAllType;
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
}

- (NSDictionary *)requestParameter{
    NSString *typeStr = @"";
    switch (_type) {
        case SSAIDataHomeActiveHomeViewAllType:
            typeStr = @"all";
            break;
        case SSAIDataHomeActiveHomeViewtodayType:
            typeStr = @"day";
            break;
        case SSAIDataHomeActiveHomeViewsevenAllType:
            typeStr = @"week";
            break;
        case SSAIDataHomeActiveHomeViewmonthType:
            typeStr = @"mouth";
            break;
        default:
            break;
    }
    
    return @{@"token":kMeUnNilStr(kCurrentUser.token),@"type":typeStr};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSAIDataHomeTimeModel mj_objectArrayWithKeyValuesArray:data]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSAIDataHomeTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAIDataHomeTimeCell class]) forIndexPath:indexPath];
    SSAIDataHomeTimeModel *model = self.refresh.arrData[indexPath.row];
    [cell setPeopleUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSAIDataHomeTimeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSAIDataHomeTimeModel *model = self.refresh.arrData[indexPath.row];
    SSAiCustomerDetailVC *vc = [[SSAiCustomerDetailVC alloc]initWithUserId:kMeUnNilStr(model.uid)];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kSSAIDataHomeActiveHomeViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SSAIDataHomeActiveHomeView *headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SSAIDataHomeActiveHomeView class])];
    [headview setUiWithType:_type];
    kMeWEAKSELF
    headview.selectBlock = ^(NSInteger index) {
        kMeSTRONGSELF
        strongSelf->_type = index;
        [strongSelf.refresh reload];
    };
    return headview;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAIDataHomeTimeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAIDataHomeTimeCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAIDataHomeActiveHomeView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SSAIDataHomeActiveHomeView class])];
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
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonairadarcommunication)];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        _refresh.showMaskView = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.frame = CGRectMake(failView.x, failView.y+kSSAIDataHomeActiveHomeViewHeight, failView.width, failView.height);
            failView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
            failView.lblOfNodata.text = @"没有用户";
        }];
    }
    return _refresh;
}

@end
