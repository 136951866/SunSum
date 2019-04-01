//
//  SSStoreSearchVC.m
//  SunSum
//
//  Created by hank on 2018/11/9.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSStoreSearchVC.h"
#import "SSSearchHistoryView.h"
#import "SSStoreModel.h"
#import "SSNewStoreHomeCell.h"
#import "SSNewStoreDetailsVC.h"
#import "SSSearchHistoryModel.h"

@interface SSStoreSearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,RefreshToolDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong , nonatomic) ZLRefreshTool *refresh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;
@property (strong , nonatomic) SSSearchHistoryView *historyView;

@end

@implementation SSStoreSearchVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSomeThing];
    // Do any additional setup after loading the view from its nib.
}


- (void)initSomeThing {
    self.navBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"fbfbfb"];
    _consTopMargin.constant = kMeStatusBarHeight;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSNewStoreHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSNewStoreHomeCell class])];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.alwaysBounceVertical = YES;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.refresh.delegate = self;
    if([SSSearchHistoryView hasHStoreIstory]){
        [self.historyView reloaStoredData];
        self.tableView.tableHeaderView = self.historyView;
    }
    [self.tfSearch becomeFirstResponder];
}
#pragma mark - Action

- (IBAction)cancelAction:(UIButton *)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    return @{@"select":kMeUnNilStr(_tfSearch.text)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSStoreModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSStoreModel *model = self.refresh.arrData[indexPath.row];
    SSNewStoreHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSNewStoreHomeCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:model WithKey:_tfSearch.text];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSStoreModel *model = self.refresh.arrData[indexPath.row];
    return [SSNewStoreHomeCell getCellHeightWithmodel:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSStoreModel *model = self.refresh.arrData[indexPath.row];
    SSNewStoreDetailsVC *vc = [[SSNewStoreDetailsVC alloc]initWithId:model.store_id];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITextViewDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(!kMeUnNilStr(textField.text).length){
        kMeAlter(@"", @"请输入搜索关键字");
        return NO;
    }
    [self.view endEditing:YES];
    
    NSArray *arr = [SSSearchHistoryModel arrSearchStoreHistory];
    NSMutableArray *arrMutable = [NSMutableArray arrayWithArray:arr];
    [arrMutable insertObject:kMeUnNilStr(textField.text) atIndex:0];
    if(arrMutable.count >3){
        [arrMutable removeLastObject];
    }
    [SSSearchHistoryModel saveSearchStoreHistory:arrMutable];
    CGFloat vHeight = [SSSearchHistoryView getStoreViewHeight];
    self.historyView.height = vHeight;
    [self.historyView reloaStoredData];
    self.tableView.tableHeaderView = self.historyView;
    [self.refresh reload];
    return YES;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonStoreSelectStore)];
        _refresh.isDataInside = YES;
        _refresh.showFailView = NO;
        [_refresh addRefreshView];
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.lblOfNodata.text = @"未搜索到您需要的门店";
        }];
    }
    return _refresh;
}

-(SSSearchHistoryView *)historyView{
    if(!_historyView){
        CGFloat vHeight = [SSSearchHistoryView getStoreViewHeight];
        _historyView = [[SSSearchHistoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, vHeight)];
        kMeWEAKSELF
        _historyView.delBlock = ^{
            kMeSTRONGSELF
            [SSSearchHistoryModel saveSearchStoreHistory:@[]];
            strongSelf.tableView.tableHeaderView = [UIView new];
            strongSelf.historyView =nil;
        };
        _historyView.selectBlock = ^(NSString *str) {
            kMeSTRONGSELF
            strongSelf->_tfSearch.text = str;
            [strongSelf.view endEditing:YES];
            [strongSelf.refresh reload];
        };
    }
    return _historyView;
}
@end
