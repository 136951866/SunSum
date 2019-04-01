//
//  BankTransferAccountsVC.m
//  SunSum
//
//  Created by hank on 2018/10/9.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "BankTransferAccountsVC.h"
#import "SSBankTransferAccountsCell.h"

@interface BankTransferAccountsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_price;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BankTransferAccountsVC

- (instancetype)initWithstrMoney:(NSString *)strMoney{
    if(self = [super init]){
        _price = strMoney;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行转账";
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSBankTransferAccountsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSBankTransferAccountsCell class]) forIndexPath:indexPath];
    cell.lblMoney.text = [NSString stringWithFormat:@"￥%@",_price];
    kMeWEAKSELF
    cell.tfAcoountBlock = ^{
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SSBankTransferAccountsCell getCellHeigh];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSBankTransferAccountsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSBankTransferAccountsCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

@end
