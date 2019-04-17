//
//  SSClerkDiagnosisResultCustomerVC.m
//  SunSum
//
//  Created by hank on 2019/4/16.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkDiagnosisResultCustomerVC.h"
#import "SSClerkDiagnosisResultCustomerCell.h"

@interface SSClerkDiagnosisResultCustomerVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SSClerkDiagnosisResultCustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    self.view.backgroundColor =kSS171c30;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSClerkDiagnosisResultCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkDiagnosisResultCustomerCell class]) forIndexPath:indexPath];
    [cell setUiWithModel:@[@(1),@(2),@(3),@(4)] lastMonth:@[@(10),@(11),@(12),@(13)] Xtitle:@[@"新客户",@"潜在客户",@"意向客户",@"老客户"] model:nil];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSClerkDiagnosisResultCustomerCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight-249) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkDiagnosisResultCustomerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkDiagnosisResultCustomerCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =kSS171c30;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}
@end
