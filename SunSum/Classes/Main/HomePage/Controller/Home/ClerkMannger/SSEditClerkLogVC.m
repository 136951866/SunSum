//
//  SSEditClerkLogVC.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSEditClerkLogVC.h"
#import "SSEditClerkLogCell.h"
#import "SSEditClerkInfoVC.h"

@interface SSEditClerkLogVC ()<UITableViewDelegate, UITableViewDataSource>{
 
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) NSObject *model;
@end

@implementation SSEditClerkLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编写员工日志";
    _model = [NSObject new];
    [self.view addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSEditClerkLogCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSEditClerkLogCell class]) forIndexPath:indexPath];
    [cell setUIWIthModel:_model];
    kMeWEAKSELF
    cell.markBlock = ^{
        kMeSTRONGSELF
        SSEditClerkInfoVC *vc = [[SSEditClerkInfoVC alloc]initWithMarkModel:strongSelf->_model];
        [strongSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.notichBlock = ^{
        kMeSTRONGSELF
        SSEditClerkInfoVC *vc = [[SSEditClerkInfoVC alloc]initWithNoticeModel:strongSelf->_model];
        [strongSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SSEditClerkLogCell getCellHeightWithModel:_model];;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSEditClerkLogCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSEditClerkLogCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =kSSf6f5fa;
    }
    return _tableView;
}

@end

