//
//  SSClerkClerkListVC.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkClerkListVC.h"
#import "SSClerkClerkListCell.h"
#import "SSClerkModel.h"

@interface SSClerkClerkListVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
    NSMutableArray *_arrClerId;
//    NSMutableArray *_arrClerK;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) UIButton *btnSave;

@end

@implementation SSClerkClerkListVC

- (instancetype)initWithArr:(NSArray *)arrClerId{
    if(self = [super init]){
//        _arrClerK = [NSMutableArray array];
        _arrClerId = [NSMutableArray arrayWithArray:arrClerId];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店员列表";
    [self.view addSubview:self.tableView];
    [self.view addSubview:[self getBottomView]];
    [self.refresh addRefreshView];
}

- (void)saveAction:(UIButton *)btn{
//    __block NSMutableArray *arrId = [NSMutableArray array];
//    [_arrClerK enumerateObjectsUsingBlock:^(SSClerkModel *nobj, NSUInteger idx, BOOL * _Nonnull nstop) {
//        [arrId addObject:kMeUnNilStr(nobj.member_id)];
//    }];
    kMeCallBlock(_block,_arrClerId);
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSDictionary *)requestParameter{
    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSClerkModel mj_objectArrayWithKeyValuesArray:data]];
    kMeWEAKSELF
    [_arrClerId enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        kMeSTRONGSELF
        [strongSelf.refresh.arrData enumerateObjectsUsingBlock:^(SSClerkModel *nobj, NSUInteger idx, BOOL * _Nonnull nstop) {
            if([obj isEqualToString:nobj.member_id]){
                nobj.isSelect = YES;
//                [strongSelf->_arrClerK addObject:nobj];
                *nstop = YES;
            }
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSClerkClerkListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSClerkClerkListCell class]) forIndexPath:indexPath];
    SSClerkModel *model = self.refresh.arrData[indexPath.row];
    [cell setUIWIthModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSClerkClerkListCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSClerkModel *model = self.refresh.arrData[indexPath.row];
    model.isSelect = !model.isSelect;
    if(model.isSelect){
//        [_arrClerK addObject:model];
//        for (NSInteger i = 0; i<_arrClerId.count; i++) {
//            NSString *strId = _arrClerId[i];
//            if([model.member_id isEqualToString:strId]){
                [_arrClerId addObject:model.member_id];
//                break;
//            }
//        }
    }else{
//        [_arrClerK removeObject:model];
        for (NSInteger i = 0; i<_arrClerId.count; i++) {
            NSString *strId = _arrClerId[i];
            if([model.member_id isEqualToString:strId]){
                [_arrClerId removeObjectAtIndex:i];
                break;
            }
        }
    }
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-90) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSClerkClerkListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSClerkClerkListCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonMyClerk)];
        _refresh.delegate = self;
        _refresh.isGet = YES;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有店员";
        }];
    }
    return _refresh;
}

- (UIView *)getBottomView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 90, SCREEN_WIDTH, 90)];
    _btnSave = [SSView btnWithFrame:CGRectMake(15, (90-40)/2, SCREEN_WIDTH-30, 40) Img:nil title:@"保存" target:self Action:@selector(saveAction:)];
    _btnSave.cornerRadius = 20;
    _btnSave.clipsToBounds = YES;
    _btnSave.backgroundColor = kSSPink;
    [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnSave.titleLabel.font = kMeFont(15);
    [view addSubview:_btnSave];
    return view;
}


@end

