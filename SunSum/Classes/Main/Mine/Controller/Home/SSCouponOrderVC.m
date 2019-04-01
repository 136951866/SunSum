//
//  SSCouponOrderVC.m
//  SunSum
//
//  Created by hank on 2018/12/27.
//  Copyright © 2018 hank. All rights reserved.
//

#import "SSCouponOrderVC.h"
#import "SSCouponOrderCell.h"
#import "SSCouponOrderHeaderView.h"
#import "SSCouponMoneyModel.h"
#import "SSCouponDetailModel.h"
#import "SSCouponOrderSectionView.h"
#import "SSJDCouponMoneyModel.h"
#import "SSWithdrawalVC.h"

@interface SSCouponOrderVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    SSCouponDetailModel *_modeldatil;
    SSCouponOrderSectionViewType _type;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) SSCouponOrderHeaderView         *headerView;

@end

@implementation SSCouponOrderVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券明细";
    _type = SSCouponOrderSectionViewPinduoduoType;
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        [self requestNet];
    }
    return @{@"token":kMeUnNilStr(kCurrentUser.token)};
}

- (void)requestNet{
    kMeWEAKSELF
    [SSPublicNetWorkTool postGetPinduoduoBrokerageDetailBaseWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        if([responseObject.data isKindOfClass:[NSDictionary class]]){
            strongSelf->_modeldatil = [SSCouponDetailModel mj_objectWithKeyValues:responseObject.data];
            [strongSelf->_headerView setUIWithModel:strongSelf->_modeldatil];
        }
    } failure:^(id object) {
        
    }];
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    if(_type == SSCouponOrderSectionViewPinduoduoType){
        [self.refresh.arrData addObjectsFromArray:[SSCouponMoneyModel mj_objectArrayWithKeyValuesArray:data]];
    }else{
        [self.refresh.arrData addObjectsFromArray:[SSJDCouponMoneyModel mj_objectArrayWithKeyValuesArray:data]];
    }
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSCouponOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSCouponOrderCell class]) forIndexPath:indexPath];
    if(_type == SSCouponOrderSectionViewPinduoduoType){
         SSCouponMoneyModel *model = self.refresh.arrData[indexPath.row];
        [cell setUIWithModel:model];
    }else{
        SSJDCouponMoneyModel *model = self.refresh.arrData[indexPath.row];
        [cell setJDUIWithModel:model];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSSCouponOrderCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SSCouponOrderSectionView *headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SSCouponOrderSectionView class])];
    kMeWEAKSELF
    headview.type = _type;
    headview.selectBlock = ^(NSInteger index) {
        kMeSTRONGSELF
        if(index == SSCouponOrderSectionViewPinduoduoType){
            strongSelf->_refresh.url = kGetApiWithUrl(SSIPcommonduoduokeGetBrokerageDetailGoods);
        }else{
            strongSelf->_refresh.url = kGetApiWithUrl(SSIPcommongetCommissionGoodsDetail);
        }
        strongSelf->_type = index;
        [strongSelf.refresh reload];
    };
    return headview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kSSCouponOrderSectionViewHeight;
}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSCouponOrderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSCouponOrderCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSCouponOrderSectionView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SSCouponOrderSectionView class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = kSSededed;
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(SSIPcommonduoduokeGetBrokerageDetailGoods)];
        _refresh.delegate = self;
        _refresh.showMaskView = YES;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.top = failView.top+kSSCouponOrderSectionViewHeight;
            failView.backgroundColor = kSSededed;
            failView.lblOfNodata.text = @"没有订单";
        }];
    }
    return _refresh;
}

- (SSCouponOrderHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSCouponOrderHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH, kSSCouponOrderHeaderViewHeight);
        kMeWEAKSELF
        _headerView.block = ^{
            kMeSTRONGSELF
            SSWithdrawalVC *vc = [[SSWithdrawalVC alloc]initWithCouponMoney];
            vc.applySucessBlock = ^{
                kMeSTRONGSELF
                [strongSelf.refresh reload];
            };
            [strongSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _headerView;
}

@end
