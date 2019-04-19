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
#import "SSCLerkTaskHomeModel.h"
#import "SSClerkFinishTaskModel.h"

@interface SSEditClerkLogVC ()<UITableViewDelegate, UITableViewDataSource>{
//    SSCLerkTaskHomeModel *_model;
    SSClerkFinishTaskModel *_model;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) UIButton *btnSave;
@end

@implementation SSEditClerkLogVC

- (instancetype)initWithModel:(SSCLerkTaskHomeModel *)model{
    if(self = [super init]){
        _model = [SSClerkFinishTaskModel new];
        _model.header_pic = kMeUnNilStr(model.header_pic);
        _model.name = kMeUnNilStr(model.name);
        _model.task_content = kMeUnNilStr(model.task_content);
        _model.last_time = kMeUnNilStr(model.last_time);
        _model.token = kMeUnNilStr(kCurrentUser.token);
        _model.task_id = model.idField;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编写员工日志";
    [self.view addSubview:self.tableView];
    [self.view addSubview:[self getBottomView]];
}

- (void)saveAction:(UIButton *)btn{
    
    if(!kMeUnNilStr(_model.reservation_num).length){
        [SSShowViewTool showMessage:@"预约数量不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(_model.desc).length){
        [SSShowViewTool showMessage:@"备注不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(_model.matters_attention).length){
        [SSShowViewTool showMessage:@"注意事项不能为空" view:kMeCurrentWindow];
        return;
    }
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetSSIPfinishTaskWithmodel:_model SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        kMeCallBlock(strongSelf->_finishBlock);
        [strongSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(id object) {
        
    }];
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
        vc.finifhBlock = ^(NSString *str) {
            [strongSelf.tableView reloadData];
        };
        [strongSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.notichBlock = ^{
        kMeSTRONGSELF
        SSEditClerkInfoVC *vc = [[SSEditClerkInfoVC alloc]initWithNoticeModel:strongSelf->_model];
        vc.finifhBlock = ^(NSString *str) {
            [strongSelf.tableView reloadData];
        };
        [strongSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.serverBlock = ^{
        kMeSTRONGSELF
        SSEditClerkInfoVC *vc = [[SSEditClerkInfoVC alloc]initWithServerModel:strongSelf->_model];
        vc.finifhBlock = ^(NSString *str) {
            [strongSelf.tableView reloadData];
        };
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-90) style:UITableViewStylePlain];
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

- (UIView *)getBottomView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 90, SCREEN_WIDTH, 90)];
    _btnSave = [SSView btnWithFrame:CGRectMake(15, (90-40)/2, SCREEN_WIDTH-30, 40) Img:nil title:@"确定" target:self Action:@selector(saveAction:)];
    _btnSave.cornerRadius = 20;
    _btnSave.clipsToBounds = YES;
    _btnSave.backgroundColor = kSSPink;
    [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnSave.titleLabel.font = kMeFont(15);
    [view addSubview:_btnSave];
    return view;
}

@end

