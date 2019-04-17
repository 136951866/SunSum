//
//  SSEditClerkInfoVC.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSEditClerkInfoVC.h"
#import "SSEditClerkInfoCell.h"

const static CGFloat kBootomHeight = 90;

@interface SSEditClerkInfoVC ()<UITableViewDelegate, UITableViewDataSource>{
    BOOL _isMark;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSObject *model;
@property (nonatomic, strong) UIButton *btnSave;
@end

@implementation SSEditClerkInfoVC


- (instancetype)initWithMarkModel:(id)model{
    if(self = [super init]){
        _model = model;
        _isMark = YES;
    }
    return self;
}

- (instancetype)initWithNoticeModel:(id)model{
    if(self = [super init]){
        _model = model;
        _isMark = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _isMark?@"备注":@"注意事项";
    [self.view addSubview:self.tableView];
     [self.view addSubview:[self getBottomView]];
}

- (void)saveAction:(UIButton *)btn{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSEditClerkInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSEditClerkInfoCell class]) forIndexPath:indexPath];
    if(_isMark){
        [cell setMarkUIWithModel:self.model];
    }else{
        [cell setNoticeUIWithModel:self.model];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSEditClerkLogCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kBootomHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSEditClerkInfoCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSEditClerkInfoCell class])];
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

- (UIView *)getBottomView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kBootomHeight, SCREEN_WIDTH, kBootomHeight)];
    _btnSave = [SSView btnWithFrame:CGRectMake(15, (kBootomHeight-40)/2, SCREEN_WIDTH-30, 40) Img:nil title:@"保存" target:self Action:@selector(saveAction:)];
    _btnSave.cornerRadius = 20;
    _btnSave.clipsToBounds = YES;
    _btnSave.backgroundColor = kSSPink;
    [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnSave.titleLabel.font = kMeFont(15);
    [view addSubview:_btnSave];
    return view;
}

@end
