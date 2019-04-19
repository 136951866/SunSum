//
//  SSCheckClerkLogVC.m
//  SunSum
//
//  Created by hank on 2019/4/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCheckClerkLogVC.h"
#import "SSCheckClerkLogCell.h"
#import "SSClerkTaskDetailModel.h"

@interface SSCheckClerkLogVC ()<UITableViewDelegate, UITableViewDataSource>{
    SSClerkTaskDetailModel *_model;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SSCheckClerkLogVC

- (instancetype)initWithModel:(SSClerkTaskDetailModel *)model{
    if(self = [super init]){
        _model  = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日志详情";
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSCheckClerkLogCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSCheckClerkLogCell class]) forIndexPath:indexPath];
    [cell setUiWIhtModle:_model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SSCheckClerkLogCell getCellHeightWithModel:_model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSCheckClerkLogCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSCheckClerkLogCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

@end
