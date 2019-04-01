//
//  SSVisterDetailVC.m
//  SunSum
//
//  Created by hank on 2018/11/29.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSVisterDetailVC.h"
#import "SSVisterDetailCell.h"
#import "SSVistorUserModel.h"
#import "SSSpreadUserModel.h"

@interface SSVisterDetailVC ()<UITableViewDelegate, UITableViewDataSource>{
    SSVistorUserModel *_model;
    SSSpreadUserModel *_sModel;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SSVisterDetailVC

- (instancetype)initWithModel:(SSVistorUserModel *)model{
    if(self = [super init]){
        _model = model;
        _sModel = [SSSpreadUserModel new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"访问详情";
    kMeWEAKSELF
    [SSPublicNetWorkTool postVistorUserInfoWithuserId:@(_model.member_id).description successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        if([responseObject.data isKindOfClass:[NSDictionary class]]){
            strongSelf->_sModel=[SSSpreadUserModel mj_objectWithKeyValues:responseObject.data];
            [strongSelf.view addSubview:strongSelf.tableView];
            [strongSelf.tableView reloadData];
        }else{
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSVisterDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSVisterDetailCell class])];
    [cell setUIWithModle:_model dicUser:_sModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSVisterDetailCellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - Setter And Getter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSVisterDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSVisterDetailCell class])];
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
