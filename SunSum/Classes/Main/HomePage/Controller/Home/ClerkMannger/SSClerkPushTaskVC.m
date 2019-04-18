//
//  SSClerkPushTaskVC.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkPushTaskVC.h"
#import "SSClerkPushTaskCell.h"
#import "SSClerkClerkListVC.h"
#import "THDatePickerView.h"
#import "SSPushContentVC.h"
#import "SSClerkCreateClerkTaskModel.h"

const static CGFloat kBootomViewHeight = 90;

@interface SSClerkPushTaskVC ()<UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *btnSave;
@property (nonatomic, strong) SSClerkCreateClerkTaskModel *model;

@end

@implementation SSClerkPushTaskVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布任务";
    _model = [SSClerkCreateClerkTaskModel new];
    _model.token = kMeUnNilStr(kCurrentUser.token);
    _model.arrclerk_id = [NSArray array];
    [self.view addSubview:self.tableView];
    [self.view addSubview:[self getBottomView]];
}

- (void)saveAction:(UIButton *)btn{
    if(!kMeUnNilStr(_model.task_title).length){
        [SSShowViewTool showMessage:@"任务标题不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(_model.task_content).length){
        [SSShowViewTool showMessage:@"任务内容不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(_model.last_time).length){
        [SSShowViewTool showMessage:@"预计跟进时间不能为空" view:kMeCurrentWindow];
        return;
    }
    if(kMeUnArr(_model.arrclerk_id).count == 0){
        [SSShowViewTool showMessage:@"请选择电源" view:kMeCurrentWindow];
        return;
    }
    _model.clerk_id =[_model.arrclerk_id componentsJoinedByString:@","];
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetSSIPcommoncreateClerkTaskWithmodel:_model SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(id object) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSClerkPushTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkPushTaskCell class]) forIndexPath:indexPath];
    [cell setUIWIthModel:_model];
    kMeWEAKSELF
    cell.pushTitleBlcok = ^{
        kMeSTRONGSELF
        [strongSelf pushTatskTitle];
    };
    cell.pushContentBlcok = ^{
        kMeSTRONGSELF
        [strongSelf pushContent];
    };
    cell.pushTimeBlcok = ^{
        kMeSTRONGSELF
        [strongSelf pushTime];
    };
    cell.SelectClerkBlcok = ^{
        kMeSTRONGSELF
        [strongSelf selectClerk];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSClerkPushTaskCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)selectClerk{
    SSClerkClerkListVC *vc =[[SSClerkClerkListVC alloc]initWithArr:_model.arrclerk_id];
    kMeWEAKSELF
    vc.block = ^(NSArray *arr) {
        kMeSTRONGSELF
        strongSelf->_model.arrclerk_id = kMeUnArr(arr);
        [strongSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushTime{
    kMeWEAKSELF
    THDatePickerView *view = [[THDatePickerView alloc]initWithSelectDaye:^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_model.last_time = str;
        [strongSelf.tableView reloadData];
    }];
    [kMeCurrentWindow endEditing:YES];
    [kMeCurrentWindow addSubview:view];
}

- (void)pushContent{
    SSPushContentVC *vc =[[SSPushContentVC alloc]init];
    vc.content = _model.task_content;
    vc.title = @"发布任务内容";
    kMeWEAKSELF
    vc.textBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_model.task_content = kMeUnNilStr(str);
        [strongSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushTatskTitle{
    SSPushContentVC *vc =[[SSPushContentVC alloc]init];
    vc.content = _model.task_title;
    vc.title = @"发布任务标题";
    kMeWEAKSELF
    vc.textBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_model.task_title = kMeUnNilStr(str);
        [strongSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kBootomViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkPushTaskCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkPushTaskCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.backgroundColor =kSSf6f5fa;
    }
    return _tableView;
}

- (UIView *)getBottomView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kBootomViewHeight, SCREEN_WIDTH, kBootomViewHeight)];
    _btnSave = [SSView btnWithFrame:CGRectMake(15, (kBootomViewHeight-40)/2, SCREEN_WIDTH-30, 40) Img:nil title:@"确定发布" target:self Action:@selector(saveAction:)];
    _btnSave.cornerRadius = 20;
    _btnSave.clipsToBounds = YES;
    _btnSave.backgroundColor = kSSPink;
    [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnSave.titleLabel.font = kMeFont(15);
    [view addSubview:_btnSave];
    return view;
}

@end

