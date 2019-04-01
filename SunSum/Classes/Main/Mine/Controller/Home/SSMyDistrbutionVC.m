//
//  SSMyDistrbutionVC.m
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//
//
#import "SSMyDistrbutionVC.h"
#import "SSMyDistributionReusableView.h"
#import "SSDistrbutionCell.h"
#import "SSDistributionOrderVC.h"
#import "SSDistributionMoneyVC.h"
#import "SSDistributionTeamVC.h"
#import "SSDistributionOrderMainVC.h"
#import "SSDistributionCentreModel.h"
#import "SSMoneyDetailedVC.h"
#import "SSMineNewShareVC.h"
#import "SSClerkManngerVC.h"
//#import "SSBDataDealVC.h"
#import "SSBdataVC.h"
#import "SSMyAppointmentVC.h"
#import "SSGetCaseMainSVC.h"
#import "SSWithdrawalVC.h"
#import "SSClerkStatisticsVC.h"
//b端model
#import "SSadminDistributionModel.h"
#import "SSCouponOrderVC.h"
#import "SSBStoreMannagerVC.h"
#import "SSMySelfExtractionOrderVC.h"
#import "SSBrandManngerVC.h"
#import "SSGoodManngerVC.h"

@interface SSMyDistrbutionVC ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    //c端model
    SSDistributionCentreModel *_cModel;
    SSadminDistributionModel *_bModel;
    SSClientTypeStyle _type;
    NSString *_levStr;
}

@property (strong, nonatomic)  UICollectionView *collectionView;
@property (strong, nonatomic)  NSArray *arrData;
@property (strong, nonatomic)  NSArray *arrDataStr;
@end

@implementation SSMyDistrbutionVC

- (instancetype)initWithC{
    //我的中心入口
    if(self = [super init]){
        _type = SSClientCTypeStyle;
    }
    return self;
}

- (instancetype)init{
    if(self = [super init]){
        switch (kCurrentUser.user_type) {
            case 1:{
                _type = SSClientOneTypeStyle;
            }
                break;
            case 2:{
                _type = SSClientTwoTypeStyle;
            }
                break;
            case 4:{
                //C
                _type = SSClientCTypeStyle;
            }
                break;
            case 3:{
                //B
                _type = SSClientBTypeStyle;
            }
                break;
            case 5:{
                //clerk
                _type = SSClientTypeClerkStyle;
            }
                break;
            default:{
                _type = SSClientTypeErrorStyle;
            }
                break;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _type==SSClientCTypeStyle?@"我的中心":@"管理中心";
    _levStr = @"";
    _arrData = @[];
    _arrDataStr = @[];
    _bModel = [SSadminDistributionModel new];
    _cModel = [SSDistributionCentreModel new];
    [self.view addSubview:self.collectionView];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.collectionView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)loadData{
    _levStr = @"";
    kMeWEAKSELF
    
    if(_type == SSClientBTypeStyle){
        [SSPublicNetWorkTool getAdminDistributionWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_bModel = [SSadminDistributionModel mj_objectWithKeyValues:responseObject.data];
            //订单总额
            CGFloat allMoney = strongSelf->_bModel.use_money + strongSelf->_bModel.ratio_money;
            strongSelf->_arrData = @[@(SSMyMoney),@(SSMyTeam),@(SSMyLeave),@(SSMySuperior),@(SSMyCode),@(SSMyClerk),@(SSMyAppintMannger),@(SSMyDataDeal),@(SSMyCash),@(SSMyCouponMoney),@(SSMyStoreMannager),@(SSMySelfExtractionOrder),@(SSGoodMannager)];
            strongSelf->_arrDataStr = @[[NSString stringWithFormat:@"%.2f",allMoney],[NSString stringWithFormat:@"%@",@(strongSelf->_bModel.admin_team)],[NSString stringWithFormat:@"%@",kMeUnNilStr(strongSelf->_bModel.level)],[NSString stringWithFormat:@"%@",kMeUnNilStr(strongSelf->_bModel.superior)],@"",@"",@"",@"",@"",@"",@"",@""];
//            [self.view addSubview:self.collectionView];
            strongSelf->_levStr = [NSString stringWithFormat:@"当前等级:%@",kMeUnNilStr(strongSelf->_bModel.level)];
            [strongSelf.collectionView reloadData];
            [strongSelf.collectionView.mj_header endRefreshing];
        } failure:^(id object) {
            kMeSTRONGSELF
             [strongSelf.collectionView.mj_header endRefreshing];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }];
    }else if(_type == SSClientOneTypeStyle){
        [SSPublicNetWorkTool getAdminDistributionWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_bModel = [SSadminDistributionModel mj_objectWithKeyValues:responseObject.data];
            //订单总额
            CGFloat allMoney = strongSelf->_bModel.use_money + strongSelf->_bModel.ratio_money;
            strongSelf->_arrData = @[@(SSMyMoney),@(SSMyTeam),@(SSMyLeave),@(SSMySuperior),@(SSMyCode),@(SSMyDataDeal),@(SSMyCash),@(SSMyCouponMoney)];
            strongSelf->_arrDataStr = @[[NSString stringWithFormat:@"%.2f",allMoney],[NSString stringWithFormat:@"%@",@(strongSelf->_bModel.admin_team)],[NSString stringWithFormat:@"%@",kMeUnNilStr(strongSelf->_bModel.level)],[NSString stringWithFormat:@"%@",kMeUnNilStr(strongSelf->_bModel.superior)],@"",@"",@"",@""];
            //            [self.view addSubview:self.collectionView];
            strongSelf->_levStr = [NSString stringWithFormat:@"当前等级:%@",kMeUnNilStr(strongSelf->_bModel.level)];
            [strongSelf.collectionView reloadData];
            [strongSelf.collectionView.mj_header endRefreshing];
        } failure:^(id object) {
            kMeSTRONGSELF
            [strongSelf.collectionView.mj_header endRefreshing];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }];
    }else if(_type == SSClientTwoTypeStyle){
        [SSPublicNetWorkTool getAdminDistributionWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_bModel = [SSadminDistributionModel mj_objectWithKeyValues:responseObject.data];
            //订单总额
            CGFloat allMoney = strongSelf->_bModel.use_money + strongSelf->_bModel.ratio_money;
            strongSelf->_arrData = @[@(SSMyMoney),@(SSMyTeam),@(SSMyLeave),@(SSMySuperior),@(SSMyCode),@(SSMyDataDeal),@(SSMyCash),@(SSMyCouponMoney),@(SSBrandMannager)];
            strongSelf->_arrDataStr = @[[NSString stringWithFormat:@"%.2f",allMoney],[NSString stringWithFormat:@"%@",@(strongSelf->_bModel.admin_team)],[NSString stringWithFormat:@"%@",kMeUnNilStr(strongSelf->_bModel.level)],[NSString stringWithFormat:@"%@",kMeUnNilStr(strongSelf->_bModel.superior)],@"",@"",@"",@"",@""];
            //            [self.view addSubview:self.collectionView];
            strongSelf->_levStr = [NSString stringWithFormat:@"当前等级:%@",kMeUnNilStr(strongSelf->_bModel.level)];
            [strongSelf.collectionView reloadData];
            [strongSelf.collectionView.mj_header endRefreshing];
        } failure:^(id object) {
            kMeSTRONGSELF
            [strongSelf.collectionView.mj_header endRefreshing];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }];
    }else if(_type == SSClientTypeClerkStyle){
        [SSPublicNetWorkTool getAdminDistributionWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_bModel = [SSadminDistributionModel mj_objectWithKeyValues:responseObject.data];
            //订单总额
            CGFloat allMoney = strongSelf->_bModel.use_money + strongSelf->_bModel.ratio_money;
            strongSelf->_arrData = @[@(SSMyMoney),@(SSMyAppintMannger),@(SSMyLeave),@(SSMyBelongStore),@(SSMyCode),@(SSMyCash),@(SSMyMoneyDeal),@(SSMyCouponMoney)];
            strongSelf->_arrDataStr = @[[NSString stringWithFormat:@"%.2f",allMoney],@"",[NSString stringWithFormat:@"%@",kMeUnNilStr(strongSelf->_bModel.level)],[NSString stringWithFormat:@"%@",kMeUnNilStr(strongSelf->_bModel.superior)],@"",@"",@"",@""];
            //            [self.view addSubview:self.collectionView];
            strongSelf->_levStr = [NSString stringWithFormat:@"当前等级:%@",kMeUnNilStr(strongSelf->_bModel.level)];
            [strongSelf.collectionView reloadData];
            [strongSelf.collectionView.mj_header endRefreshing];
        } failure:^(id object) {
            kMeSTRONGSELF
            [strongSelf.collectionView.mj_header endRefreshing];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }];
    }else if(_type == SSClientCTypeStyle){
        [SSPublicNetWorkTool getUserDistributionWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            strongSelf->_cModel = [SSDistributionCentreModel mj_objectWithKeyValues:responseObject.data];
            CGFloat allBean = strongSelf->_cModel.wait_integral +  strongSelf->_cModel.integral;
            strongSelf.arrData = @[@(SSDistributionMoney),@(SSDistributionOrder),@(SSMyTeam),@(SSMyCode),@(SSMyCouponMoney)];
            strongSelf.arrDataStr = @[[NSString stringWithFormat:@"%@",@(allBean)],[NSString stringWithFormat:@"%@单",@(strongSelf->_cModel.count_order)],[NSString stringWithFormat:@"%@人",@(strongSelf->_cModel.count_user)],@"",@""];
//            [strongSelf.view addSubview:self.collectionView];
            [strongSelf.collectionView reloadData];
             [strongSelf.collectionView.mj_header endRefreshing];
        } failure:^(id object) {
            kMeSTRONGSELF
             [strongSelf.collectionView.mj_header endRefreshing];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        [SSShowViewTool showMessage:@"数据错误,请重新登录" view:self.view];
        [self.collectionView.mj_header endRefreshing];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark- CollectionView Delegate And DataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SSDistrbutionCellStyle type = [self.arrData[indexPath.row] integerValue];
    switch (type) {
        case SSDistributionOrder:{
            SSDistributionOrderMainVC *orderVC = [[SSDistributionOrderMainVC alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
        }
            
            break;
        case SSDistributionMoney:{
//            SSDistributionMoneyVC *vc = [[SSDistributionMoneyVC alloc]initWithModel:@""];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case SSMyTeam:{
            SSDistributionTeamVC *vc = [[SSDistributionTeamVC alloc]initWithType:_type];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SSMyMoney:{
            SSMoneyDetailedVC *vc = [[SSMoneyDetailedVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SSMyCode:{
            SSMineNewShareVC *vc = [[SSMineNewShareVC alloc]initWithLevel:_levStr];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case SSMyClerk:{
            SSClerkManngerVC *clerkVC = [[SSClerkManngerVC alloc]init];
            [self.navigationController pushViewController:clerkVC animated:YES];
        }
            break;
            
        case SSMyAppintMannger:{
            SSMyAppointmentVC *dvc = [[SSMyAppointmentVC alloc]initWithType:SSAppointmenyUseing userType:SSClientBTypeStyle];
            [self.navigationController pushViewController:dvc animated:YES];
        }
            break;
            
        case SSMyDataDeal:{
            SSBdataVC *vc = [[SSBdataVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SSMyMoneyDeal:{
            SSClerkStatisticsVC *vc = [[SSClerkStatisticsVC alloc]initWithType:SSClientTypeClerkStyle memberId:@""];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SSMyCash:{
            SSGetCaseMainSVC *vc = [[SSGetCaseMainSVC alloc]initWithType:SSGetCaseAllStyle];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SSMyCouponMoney:{
            SSCouponOrderVC *couponVC = [[SSCouponOrderVC alloc]init];
            [self.navigationController pushViewController:couponVC animated:YES];
        }
            break;
        case SSMyStoreMannager:{
            SSBStoreMannagerVC *storeVC = [[SSBStoreMannagerVC alloc]init];
            [self.navigationController pushViewController:storeVC animated:YES];
        }
            break;
        case SSMySelfExtractionOrder:{
            SSMySelfExtractionOrderVC *orderVC = [[SSMySelfExtractionOrderVC alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
        }
            break;
        case SSBrandMannager:{
            SSBrandManngerVC *brandVC = [[SSBrandManngerVC alloc]init];
            [self.navigationController pushViewController:brandVC animated:YES];
        }
            break;
        case SSGoodMannager:{
            SSGoodManngerVC *brandVC = [[SSGoodManngerVC alloc]init];
            [self.navigationController pushViewController:brandVC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSDistrbutionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSDistrbutionCell class]) forIndexPath:indexPath];
    SSDistrbutionCellStyle type = [self.arrData[indexPath.row] integerValue];
    NSString *typeStr = self.arrDataStr[indexPath.row];
    [cell setUIWithtype:type subtitle:typeStr];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kSSDistrbutionCellWdith, kSSDistrbutionCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kSSDistrbutionCellMargin, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kSSDistrbutionCellMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kSSDistrbutionCellMargin;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){//处理头视图
        SSMyDistributionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SSMyDistributionReusableView class]) forIndexPath:indexPath];
        if(_type == SSClientBTypeStyle){
            [headerView setUIBWithModel:_bModel];
            kMeWEAKSELF
            headerView.costBlock = ^{
                kMeSTRONGSELF
                SSWithdrawalVC *vc = [[SSWithdrawalVC alloc]init];
                vc.applySucessBlock = ^{
                    kMeSTRONGSELF
                    [strongSelf.collectionView.mj_header beginRefreshing];
                };
                [strongSelf.navigationController pushViewController:vc animated:YES];
            };
        }else if(_type == SSClientOneTypeStyle){
            [headerView setUIBWithModel:_bModel];
            kMeWEAKSELF
            headerView.costBlock = ^{
                kMeSTRONGSELF
                SSWithdrawalVC *vc = [[SSWithdrawalVC alloc]init];
                vc.applySucessBlock = ^{
                    kMeSTRONGSELF
                    [strongSelf.collectionView.mj_header beginRefreshing];
                };
                [strongSelf.navigationController pushViewController:vc animated:YES];
            };
        }else if(_type == SSClientTwoTypeStyle){
            [headerView setUIBWithModel:_bModel];
            kMeWEAKSELF
            headerView.costBlock = ^{
                kMeSTRONGSELF
                SSWithdrawalVC *vc = [[SSWithdrawalVC alloc]init];
                vc.applySucessBlock = ^{
                    kMeSTRONGSELF
                    [strongSelf.collectionView.mj_header beginRefreshing];
                };
                [strongSelf.navigationController pushViewController:vc animated:YES];
            };
        }else if(_type == SSClientTypeClerkStyle){
            [headerView setUIBWithModel:_bModel];
            kMeWEAKSELF
            headerView.costBlock = ^{
                kMeSTRONGSELF
                SSWithdrawalVC *vc = [[SSWithdrawalVC alloc]init];
                vc.applySucessBlock = ^{
                    kMeSTRONGSELF
                    [strongSelf.collectionView.mj_header beginRefreshing];
                };
                [strongSelf.navigationController pushViewController:vc animated:YES];
            };
        }else if(_type == SSClientCTypeStyle){
            [headerView setUIWithModel:_cModel];
        }
        return headerView;
    }
    else{
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, kSSMyDistributionHeaderViewHeight);
}

#pragma mark - Getting And Setting

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SSDistrbutionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SSDistrbutionCell class])];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMyDistributionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SSMyDistributionReusableView class])];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = kSSHexColor(@"eeeeee");
    }
    return _collectionView;
}

@end
