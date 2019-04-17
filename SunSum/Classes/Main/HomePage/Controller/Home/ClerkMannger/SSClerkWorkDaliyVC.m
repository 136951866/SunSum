//
//  SSClerkWorkDaliyVC.m
//  SunSum
//
//  Created by hank on 2019/4/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkWorkDaliyVC.h"
#import "SSClerkWorkDaliyCell.h"

@interface SSClerkWorkDaliyVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SSClerkWorkDaliyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作日报";
    self.view.backgroundColor = kSSf6f5fa;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSClerkWorkDaliyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkWorkDaliyCell class]) forIndexPath:indexPath];
    [cell setUiWithModel:@[@(1),@(2),@(3),@(4)] Xtitle:@[@"新客户",@"潜在客户",@"意向客户",@"老客户"] title:@"" progress:@"100%"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSClerkWorkDaliyCellHeight;
}


- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkWorkDaliyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkWorkDaliyCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kSSf6f5fa;
    }
    return _tableView;
}





@end
