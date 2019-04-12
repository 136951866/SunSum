//
//  SSAIDataHomeActiveVC.m
//  SS时代
//
//  Created by hank on 2019/4/10.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAIDataHomeActiveVC.h"
#import "SSAIDataHomeActiveHomeView.h"
#import "SSAIDataHomeActiveHomeCell.h"
#import "SSAIDataHomeActiveModel.h"

@interface SSAIDataHomeActiveVC ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *_arrData;
    NSArray *_arrDataStr;
    SSAIDataHomeActiveHomeViewType _type;
    SSAIDataHomeActiveModel *_model;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool *refresh;

@end

@implementation SSAIDataHomeActiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _type = SSAIDataHomeActiveHomeViewAllType;
    _model = [SSAIDataHomeActiveModel new];
    _arrData = @[@[@(SSAIDataHomeActiveHomeCellcheckStoreType),@(SSAIDataHomeActiveHomeCellshareStoreType)],@[@(SSAIDataHomeActiveHomeCellcheckpintuanType),@(SSAIDataHomeActiveHomeCellcheckServerType)]];
    _arrDataStr = @[@[@(0),@(0)],@[@(0),@(0)]];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self.tableView.mj_header beginRefreshing];
//    [self.refresh addRefreshView];
}

- (void)getData{
    kMeWEAKSELF
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    [SSPublicNetWorkTool postgetMemberBehaviorWithtype:@(_type).description SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_model = [SSAIDataHomeActiveModel mj_objectWithKeyValues:responseObject.data];
        strongSelf->_arrDataStr = @[@[@(strongSelf->_model.look_store),@(strongSelf->_model.share_store)],@[@(strongSelf->_model.look_group_buy_activity),@(strongSelf->_model.look_services)]];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        [HUD hideAnimated:YES];
    } failure:^(id object) {
        kMeSTRONGSELF
        strongSelf->_arrDataStr = @[@[@(0),@(0)],@[@(0),@(0)]];
        [strongSelf.tableView reloadData];
        [HUD hideAnimated:YES];
        [strongSelf.tableView.mj_header endRefreshing];
    }];
}

//- (NSDictionary *)requestParameter{
//    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
//}
//
//- (void)handleResponse:(id)data{
//    if(![data isKindOfClass:[NSArray class]]){
//        return;
//    }
//    [self.refresh.arrData addObjectsFromArray:[SSAIDataHomeTimeModel mj_objectArrayWithKeyValuesArray:data]];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = _arrData[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSAIDataHomeActiveHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAIDataHomeActiveHomeCell class]) forIndexPath:indexPath];
    SSAIDataHomeActiveHomeCellType type = [_arrData[indexPath.section][indexPath.row] integerValue];
    NSInteger count =  [_arrDataStr[indexPath.section][indexPath.row] integerValue];
    [cell setUIWithType:type count:count];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSAIDataHomeActiveHomeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    SSAIDataHomeTimeModel *model = self.refresh.arrData[indexPath.row];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return kSSAIDataHomeActiveHomeViewHeight+k10Margin;
    }else{
        return k10Margin;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 0){
        SSAIDataHomeActiveHomeView *headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SSAIDataHomeActiveHomeView class])];
        [headview setUiWithType:_type];
        kMeWEAKSELF
        headview.selectBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            strongSelf->_type = index;
            [strongSelf getData];
        };
        return headview;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, k10Margin)];
        view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        return view;
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAIDataHomeActiveHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAIDataHomeActiveHomeCell class])];
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


@end
