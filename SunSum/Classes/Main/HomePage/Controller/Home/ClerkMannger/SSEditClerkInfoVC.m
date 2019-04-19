//
//  SSEditClerkInfoVC.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSEditClerkInfoVC.h"
#import "SSEditClerkInfoCell.h"
#import "SSClerkFinishTaskModel.h"

const static CGFloat kBootomHeight = 90;

@interface SSEditClerkInfoVC ()<UITableViewDelegate, UITableViewDataSource>{
    SSClerkEditLogType _type;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SSClerkFinishTaskModel *model;
@property (nonatomic, strong) SSEditClerkInfoCell *cell;
@property (nonatomic, strong) UIButton *btnSave;
@end

@implementation SSEditClerkInfoVC

- (instancetype)initWithServerModel:(SSClerkFinishTaskModel *)model{
    if(self = [super init]){
        _model = model;
        _type = SSClerkEditLogServerNumType;
    }
    return self;
}

- (instancetype)initWithMarkModel:(SSClerkFinishTaskModel *)model{
    if(self = [super init]){
        _model = model;
        _type = SSClerkEditLogmarkType;
    }
    return self;
}

- (instancetype)initWithNoticeModel:(SSClerkFinishTaskModel *)model{
    if(self = [super init]){
        _model = model;
        _type = SSClerkEditLogNoticeType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (_type) {
        case SSClerkEditLogmarkType:
            self.title = @"备注";
            break;
        case SSClerkEditLogNoticeType:
            self.title = @"注意事项";
            break;
        case SSClerkEditLogServerNumType:
            self.title = @"预约数量";
            break;
        default:
            break;
    }
    [self.view addSubview:self.tableView];
     [self.view addSubview:[self getBottomView]];
}

- (void)saveAction:(UIButton *)btn{
    kMeCallBlock(_finifhBlock,kMeUnNilStr(_cell.textView.textView.text));
    switch (_type) {
        case SSClerkEditLogmarkType:
            self.model.desc = kMeUnNilStr(_cell.textView.textView.text);
            break;
        case SSClerkEditLogNoticeType:
            self.model.matters_attention = kMeUnNilStr(_cell.textView.textView.text);
            break;
        case SSClerkEditLogServerNumType:
            self.model.reservation_num = kMeUnNilStr(_cell.textView.textView.text);
            break;
        default:
            break;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSEditClerkInfoCell class]) forIndexPath:indexPath];
    switch (_type) {
        case SSClerkEditLogmarkType:
            [_cell setMarkUIWithModel:_model];
            break;
        case SSClerkEditLogNoticeType:
            [_cell setNoticeUIWithModel:_model];
            break;
        case SSClerkEditLogServerNumType:
            [_cell setServerUIWithModel:_model];
            break;
        default:
            break;
    }
    return _cell;
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
