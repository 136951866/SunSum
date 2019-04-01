//
//  SSDistributionOrderContentVC.m
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSDistributionOrderContentVC.h"
#import "SSDistributionOrderCell.h"

@interface SSDistributionOrderContentVC ()<UITableViewDelegate, UITableViewDataSource>{
    SSDistrbutionOrderStyle _type;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrData;


@end

@implementation SSDistributionOrderContentVC

- (instancetype)initWithType:(SSDistrbutionOrderStyle)type{
    if(self = [super init]){
        _type = type;
        _arrData = @[@"",@"",@"",@"",@"",@"",@"",@""];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //SSStoreModel *storeModel = self.arrStore[section];
    return self.arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSDistributionOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSDistributionOrderCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:@"" Type:_type];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSDistributionOrderCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kCategoryViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSDistributionOrderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSDistributionOrderCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}


@end
