//
//  SSGiftVC.m
//  SunSum
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSGiftVC.h"
#import "SSGiftMainCell.h"
#import "SSGiftHeaderView.h"
#import "SSGiftFooterView.h"
#import "SSGiftMainNilCell.h"
#import "SSAdModel.h"
#import "SSShoppingCartModel.h"
#import "SSProductGitfListVC.h"
#import "SSMakeOrderVC.h"
#import "SSShopCartMakeOrderVC.h"

@interface SSGiftVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSArray *_arrDv;
    NSString *_allPrice;
    NSString *_strMessage;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SSGiftHeaderView         *headerView;
@property (nonatomic, strong) SSGiftFooterView         *footerView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@end

@implementation SSGiftVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"许愿屋";
    _allPrice = @"¥0";
    _strMessage = @"";
    _arrDv = [NSArray array];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNetWork)];
//    [self.tableView.mj_header beginRefreshing];
    [self.refresh addHeadRefreshView];
    kShopCartReload
    // Do any additional setup after loading the view.
}

- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        [self requestNetWork];
    }
    return @{@"token":kMeUnNilStr(kCurrentUser.token),
             @"product_type":@(6),
             };
}

- (void)countPrice{
    double totlePrice = 0.0;
    for (SSShoppingCartModel *goodsModel in self.refresh.arrData) {
        double price = [goodsModel.money doubleValue];
        totlePrice += price * goodsModel.goods_num ;
    }
    NSString *price= [NSString stringWithFormat:@"￥%.2f", totlePrice];
    _allPrice = price;
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSShoppingCartModel mj_objectArrayWithKeyValuesArray:data]];
    [self countPrice];
    kMeWEAKSELF
    [self.footerView setUIWithModel:_allPrice say:_strMessage contentBlock:^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_strMessage = str;
    }];
    self.tableView.tableFooterView = self.footerView;
    [self.tableView reloadData];
}

- (void)requestNetWork{
    kMeWEAKSELF
    [SSPublicNetWorkTool postAgetGiftBannerWithsuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_arrDv = [SSAdModel mj_objectArrayWithKeyValuesArray:responseObject.data];
        [strongSelf.headerView setUiWithModel:strongSelf->_arrDv];
        strongSelf.tableView.tableHeaderView = strongSelf.headerView;
        strongSelf.tableView.tableHeaderView.backgroundColor = kSSPink;
        [strongSelf.tableView reloadData];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
        
    }];
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    kMeWEAKSELF
//    dispatch_group_async(group, queue, ^{
//
//    });
//    dispatch_group_async(group, queue, ^{
//        dispatch_semaphore_signal(semaphore);
//    });
//    dispatch_group_notify(group, queue, ^{
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//        });
//    });

}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.refresh.arrData.count == 0){
        SSGiftMainNilCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSGiftMainNilCell class]) forIndexPath:indexPath];
        return cell;
    }
    SSGiftMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSGiftMainCell class]) forIndexPath:indexPath];
    kMeWEAKSELF
    cell.allPriceBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_allPrice = str;
        [self.footerView setUIWithModel:strongSelf->_allPrice  say:strongSelf->_strMessage contentBlock:^(NSString *str) {
            kMeSTRONGSELF
            strongSelf->_strMessage = str;
        }];
        self.tableView.tableFooterView = self.footerView;
        [self.tableView reloadData];
    };
    [cell setUIWithModel:self.refresh.arrData block:^{
        kMeSTRONGSELF
        SSProductGitfListVC *vc = [[SSProductGitfListVC alloc]init];
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.refresh.arrData.count == 0){
        return kSSGiftMainNilCellHeight;
    }
    return [SSGiftMainCell getCellHeightWithModel:self.refresh.arrData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.refresh.arrData.count == 0){
        SSProductGitfListVC *vc = [[SSProductGitfListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSGiftMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSGiftMainCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSGiftMainNilCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSGiftMainNilCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = self.footerView;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableHeaderView.backgroundColor = kSSPink;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (SSGiftHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSGiftHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH, [SSGiftHeaderView getViewHeight]);
        _headerView.backgroundColor = kSSPink;
    }
    return _headerView;
}

- (SSGiftFooterView *)footerView{
    if(!_footerView){
        _footerView = [[[NSBundle mainBundle]loadNibNamed:@"SSGiftFooterView" owner:nil options:nil] lastObject];
        _footerView.frame =CGRectMake(0, 0, SCREEN_WIDTH, kSSGiftFooterViewHeight);
        kMeWEAKSELF
        _footerView.toAcount = ^{
            kMeSTRONGSELF
            if(strongSelf.refresh.arrData.count == 0){
                [SSShowViewTool showMessage:@"请选择礼物" view:strongSelf.view];
            }else{
                SSShopCartMakeOrderVC *ovc = [[SSShopCartMakeOrderVC alloc]initWithIsinteral:NO WithArrChartGood:strongSelf.refresh.arrData];
                ovc.isGift = YES;
                ovc.giftMessage = kMeUnNilStr(strongSelf->_strMessage);
                ovc.PayFinishBlock = ^{
                    kMeSTRONGSELF
                    [strongSelf.refresh reload];
                };
                [strongSelf.navigationController pushViewController:ovc animated:YES];
            }
        };
    }
    return _footerView;
}


- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonCartCartGoodsList)];
        _refresh.delegate = self;
        _refresh.showFailView = NO;
    }
    return _refresh;
}

@end
