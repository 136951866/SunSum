//
//  SSNewClerkMineHomeVC.m
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNewClerkMineHomeVC.h"
#import "SSNewClerkMineHomeCell.h"
#import "SSMineSetVC.h"
#import "SSPosterListVC.h"
#import "SSArticelVC.h"
#import "SSVisiterHomeVC.h"
#import "SSClerkTGetTaskListVC.h"
#import "SSRCConversationListVC.h"

@interface SSNewClerkMineHomeVC ()<UITableViewDelegate,UITableViewDataSource,SSNewClerkMineHomeCellDelegate>
@property (nonatomic, strong) UITableView           *tableView;
@end

@implementation SSNewClerkMineHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self.view addSubview:self.tableView];
    if([SSUserInfoModel isLogin]){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUnMeaasge) name:kUnMessage object:nil];
    }
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getUnMeaasge];
}

- (void)getUnMeaasge{
    if([SSUserInfoModel isLogin]&& self.tableView){
        kMeWEAKSELF
        dispatch_async(dispatch_get_main_queue(), ^{
            kMeSTRONGSELF
            [strongSelf.tableView reloadData];
        });
    }
}

- (void) toSetVC{
    SSMineSetVC *setVC = [[SSMineSetVC alloc]init];
    setVC.exitBlock = ^{
        [SSWxLoginVC toLoginVC];
    };
    [self.navigationController pushViewController:setVC animated:YES];
}
- (void) toTaskVC{
    SSClerkTGetTaskListVC *mobile = [[SSClerkTGetTaskListVC alloc]init];
    [self.navigationController pushViewController:mobile animated:YES];
}
- (void) toposterVC{
    SSPosterListVC *mobile = [[SSPosterListVC alloc]init];
    [self.navigationController pushViewController:mobile animated:YES];
}
- (void) toArticelkVC{
    SSArticelVC *mobile = [[SSArticelVC alloc]init];
    [self.navigationController pushViewController:mobile animated:YES];
}
- (void) toDataVC{
    SSVisiterHomeVC *mobile = [[SSVisiterHomeVC alloc]init];
    [self.navigationController pushViewController:mobile animated:YES];
}
- (void) toChatVC{
    SSRCConversationListVC *cvc = [[SSRCConversationListVC alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSNewClerkMineHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSNewClerkMineHomeCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    [cell reloadUI];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSSNewClerkMineHomeCellHeight;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeTabBarHeight-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSNewClerkMineHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSNewClerkMineHomeCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =  [UIColor colorWithHexString:@"fafafa"];
    }
    return _tableView;
}

@end
