//
//  SSNewClerkManngerVC.m
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNewClerkManngerVC.h"
#import "SSClerkTaskCell.h"
#import "SSClerkLogCell.h"
#import "SSClerkSortCell.h"

@interface SSNewClerkManngerVC ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *_arrSelect;
    NSInteger _currentIndex;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SSNewClerkManngerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"员工管理";
    _currentIndex = 0;
    _arrSelect = @[@[@""],@[@"",@"",@""],@[]];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0){
        SSClerkTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkTaskCell class]) forIndexPath:indexPath];
        [cell setUIWithArr:@[@"",@"",@""]];
        return cell;
    }else if (indexPath.row == 1){
        SSClerkLogCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkLogCell class]) forIndexPath:indexPath];
        [cell setUIWithArr:@[@"",@"",@""]];
        return cell;
    }else{
        SSClerkSortCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkSortCell class]) forIndexPath:indexPath];
        NSArray *arr = _arrSelect[_currentIndex];
        kMeWEAKSELF
        [cell setUIWithArr:arr selectBlock:^(NSInteger index) {
            kMeSTRONGSELF
            strongSelf->_currentIndex = index;
            [strongSelf.tableView reloadData];
        } selectIndex:_currentIndex];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        return [SSClerkTaskCell getCellHeightWithArr:@[@"",@"",@""]];
    }else if (indexPath.row == 1){
        return [SSClerkLogCell getCellHeightWithArr:@[@"",@"",@""]];
    }else{
        NSArray *arr = _arrSelect[_currentIndex];
        return [SSClerkSortCell getCellHeightWithArr:arr];
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkTaskCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkTaskCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkLogCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkLogCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkSortCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkSortCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = kSSf6f5fa;
        _tableView.tableFooterView = view;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kSSf6f5fa;
    }
    return _tableView;
}

@end
