//
//  SSNoticeTypeVC.m
//  SunSum
//
//  Created by hank on 2018/11/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSNoticeTypeVC.h"
#import "SSFilterMainCell.h"
#import "SSFilterMainModel.h"
#import "SSNoticeVC.h"

@interface SSNoticeTypeVC ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *_arrDate;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SSNoticeTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知";
    self.view.backgroundColor = kSSfbfbfb;
    _arrDate = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)requestData{
    kMeWEAKSELF
    [SSPublicNetWorkTool getUserUnreadNoticeWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        if([responseObject.data isKindOfClass:[NSDictionary class]]){
            NSMutableArray *arrdate = [NSMutableArray array];
            NSArray *arrTitle = @[@"推荐消息",@"订单消息",@"版本消息"];
            NSArray *arrType = @[@(SSJpushNoticeType),@(SSJpushOrderType),@(SSJpushVersionUpdateType)];
            NSArray *arrUnread = @[responseObject.data[@"notice"],responseObject.data[@"order"],responseObject.data[@"versions"]];
            if(kCurrentUser.user_type == 3 && responseObject.data[@"ComeInStoreMessages"]){
                arrTitle = @[@"推荐消息",@"订单消息",@"版本消息",@"店铺访问"];
                arrUnread = @[responseObject.data[@"notice"],responseObject.data[@"order"],responseObject.data[@"versions"],responseObject.data[@"ComeInStoreMessages"]];
                arrType = @[@(SSJpushNoticeType),@(SSJpushOrderType),@(SSJpushVersionUpdateType),@(SSJpushIntoStoreType)];
            }
            if(kCurrentUser.user_type == 4 && responseObject.data[@"browseUser"]){
                arrTitle = @[@"推荐消息",@"订单消息",@"版本消息",@"店铺访问"];
                arrUnread = @[responseObject.data[@"notice"],responseObject.data[@"order"],responseObject.data[@"versions"],responseObject.data[@"browseUser"]];
                arrType = @[@(SSJpushNoticeType),@(SSJpushOrderType),@(SSJpushVersionUpdateType),@(SSJpushUnreadMessageType)];
            }
            
            strongSelf->_arrDate = [NSMutableArray array];
            for (NSInteger i =0; i<arrTitle.count; i++) {
                NSString *str = arrTitle[i];
                SSFilterMainModel *model = [SSFilterMainModel new];
                model.category_name = str;
                model.unRead = [arrUnread[i] integerValue];
                model.idField = [arrType[i] integerValue];
                [arrdate addObject:model];
            }
            strongSelf->_arrDate = arrdate;
            [strongSelf.tableView reloadData];
        }else{
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrDate.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSFilterMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSFilterMainCell class])];
    SSFilterMainModel *model =  _arrDate[indexPath.row];
    [cell setUnreadUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSSFilterMainCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
    view.backgroundColor = kSSfbfbfb;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSFilterMainModel *model =  _arrDate[indexPath.row];
//    SSNoticeVC *vc = [[SSNoticeVC alloc]initWithNoticeType:model.idField title:kMeUnNilStr(model.category_name)];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Setter And Getter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSFilterMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSFilterMainCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kSSfbfbfb;
    }
    return _tableView;
}


@end
