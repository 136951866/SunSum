//
//  SSClerkTaskDetailVC.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkTaskDetailVC.h"
#import "SSClerkTaskDetailCell.h"
#import "SSClerkTaskDetailModel.h"
#import "SSCheckClerkLogVC.h"

@interface SSClerkTaskDetailVC ()<UITableViewDelegate, UITableViewDataSource>{
    NSString *_taskId;
    SSClerkTaskDetailModel *_model;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SSClerkTaskDetailVC

- (instancetype)initWithTaskId:(NSString *)taskId{
    if(self = [super init]){
        _taskId = taskId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务详情";
    _model = [SSClerkTaskDetailModel new];
    self.view.backgroundColor =  [UIColor colorWithHexString:@"FAFAFC"];
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetclerktaskDetailWithTaskId:_taskId SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_model = [SSClerkTaskDetailModel mj_objectWithKeyValues:responseObject.data];
        [strongSelf.view addSubview:strongSelf.tableView];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSClerkTaskDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkTaskDetailCell class]) forIndexPath:indexPath];
    [cell setUIWIthModel:_model];
    kMeWEAKSELF
    cell.checkLogBlock = ^{
        kMeSTRONGSELF
        SSCheckClerkLogVC *vc = [[SSCheckClerkLogVC alloc]initWithModel:strongSelf->_model];
        [strongSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SSClerkTaskDetailCell getCellHeightWithModel:_model];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkTaskDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkTaskDetailCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =  [UIColor colorWithHexString:@"FAFAFC"];;
    }
    return _tableView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
