//
//  SSHomePageVC.m
//  SunSum
//
//  Created by hank on 2018/9/5.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSHomePageVC.h"
#import "SSHomePageHeaderView.h"
#import "SSHomeMiaoDongCell.h"
#import "SSBaoQiangCell.h"
#import "SSHomeMainCell.h"
#import "SSProductListVC.h"
#import "SSHomePageSaveModel.h"
#import "SSServiceDetailsVC.h"
#import "SSProductDetailsVC.h"
#import "SSAdModel.h"
#import "SSGoodModel.h"
#import "SSHomeGoodModel.h"
#import "SSActiveVC.h"
#import "SSServiceDetailsVC.h"
#import "SSProductSearchVC.h"
#import "SSFilterVC.h"

@interface SSHomePageVC ()<UITableViewDelegate,UITableViewDataSource>{
    SSAdModel *_productAdModel;
    SSAdModel *_serviceAdModel;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic,strong) SSHomePageHeaderView *headerView;
@property (nonatomic,strong) NSArray *arrMainProductModel;
@property (nonatomic,strong) NSArray *arrMainPrjoctModel;
@property (nonatomic,strong) NSArray *arrMainTopModel;
//@property (nonatomic,strong) NSString *productImg;
//@property (nonatomic,strong) NSString *serviceImg;
@property (nonatomic, strong) UIButton *btnRight;
@end

@implementation SSHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
//    _productAdModel = [SSAdModel new];
//    _serviceAdModel = [SSAdModel new];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNetWork)];
    [self.tableView.mj_header beginRefreshing];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnRight];
}

- (void)requestNetWork{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    kMeWEAKSELF
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postAdWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            if([responseObject.data isKindOfClass:[NSDictionary class]]){
                NSArray *banner_headArr = responseObject.data[@"banner_head"];
                NSArray *arr = [SSAdModel mj_objectArrayWithKeyValuesArray:banner_headArr];
                [SSHomePageSaveModel saveAdsModel:arr];
                [strongSelf.headerView setArrModel:arr];
                
                NSArray *banner_goodsArr = responseObject.data[@"banner_goods"];
                if([kMeUnArr(banner_goodsArr) count]){
                    NSDictionary *dic = banner_goodsArr[0];
                    strongSelf->_productAdModel = [SSAdModel mj_objectWithKeyValues:dic];
                }
                NSArray *banner_serviceArr = responseObject.data[@"banner_service"];
                if([kMeUnArr(banner_serviceArr) count]){
                    NSDictionary *dic = banner_serviceArr[0];
                    strongSelf->_serviceAdModel = [SSAdModel mj_objectWithKeyValues:dic];
                }
                dispatch_semaphore_signal(semaphore);
            }else{
                [strongSelf.headerView setArrModel:[SSHomePageSaveModel getAdsModel]];
                dispatch_semaphore_signal(semaphore);
            }
        } failure:^(id object) {
            kMeSTRONGSELF
            [strongSelf.headerView setArrModel:[SSHomePageSaveModel getAdsModel]];
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postGoodsListWithType:SSGoodsTypeNetHotStyle successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            NSArray *arr = [SSGoodModel mj_objectArrayWithKeyValuesArray:responseObject.data];
            strongSelf.arrMainTopModel = arr;
            [SSHomePageSaveModel saveHotModel:arr];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            kMeSTRONGSELF
            strongSelf.arrMainTopModel = [SSHomePageSaveModel getHotModel];
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
//    dispatch_group_async(group, queue, ^{
//        [SSPublicNetWorkTool postGoodsTypeWithArticleCategoryId:19 successBlock:^(ZLRequestResponse *responseObject) {
//            kMeSTRONGSELF
//            SSHomeGoodModel *model = [SSHomeGoodModel mj_objectWithKeyValues:responseObject.data];
////            strongSelf->_productImg = kMeUnNilStr(model.mask_img);
//            dispatch_semaphore_signal(semaphore);
//        } failure:^(id object) {
//            dispatch_semaphore_signal(semaphore);
//        }];
//    });
    
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postHomeRecommendWithsuccessBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            NSArray *arr = [SSGoodModel mj_objectArrayWithKeyValuesArray:responseObject.data];
            strongSelf.arrMainProductModel = arr;
            [SSHomePageSaveModel saveProductModel:arr];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            kMeSTRONGSELF
            strongSelf.arrMainProductModel = [SSHomePageSaveModel getProductModel];
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        [SSPublicNetWorkTool postGoodsTypeWithArticleCategoryId:20 successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            SSHomeGoodModel *model = [SSHomeGoodModel mj_objectWithKeyValues:responseObject.data];
//            strongSelf->_serviceImg = kMeUnNilStr(model.mask_img);
            NSArray *arr = model.goodsList;
            strongSelf.arrMainPrjoctModel = arr;
            [SSHomePageSaveModel saveServiceModel:arr];
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            kMeSTRONGSELF
            strongSelf.arrMainPrjoctModel = [SSHomePageSaveModel getServiceModel];
            dispatch_semaphore_signal(semaphore);
        }];

    });
    
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            kMeSTRONGSELF
            [strongSelf.tableView.mj_header endRefreshing];
            [strongSelf.tableView reloadData];
        });
    });
}

#pragma mark - Acction

//- (void)searchProduct:(UIButton *)btn{
//    SSProductSearchVC *svc = [[SSProductSearchVC alloc]init];
//    [self.navigationController pushViewController:svc animated:NO];
//}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
//        SSHomeMiaoDongCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSHomeMiaoDongCell class]) forIndexPath:indexPath];
        return [UITableViewCell new];
    }else if(indexPath.row == 1){
        SSBaoQiangCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSBaoQiangCell class]) forIndexPath:indexPath];
        [cell setUIWithArr:self.arrMainTopModel];
        kMeWEAKSELF
        cell.indexBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            SSGoodModel *model = self.arrMainTopModel[index];
            SSProductDetailsVC *dvc = [[SSProductDetailsVC alloc]initWithId:model.product_id];
            [strongSelf.navigationController pushViewController:dvc animated:YES];
        };
        return cell;
    }else if(indexPath.row == 2){
        SSHomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSHomeMainCell class]) forIndexPath:indexPath];
        if(_productAdModel){
            kSDLoadImg(cell.imgMainPic, kMeUnNilStr(_productAdModel.ad_img));
        }
        [cell setUIWithArr:self.arrMainProductModel];
        kMeWEAKSELF
        cell.indexBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            SSGoodModel *model = self.arrMainProductModel[index];
            SSProductDetailsVC *dvc = [[SSProductDetailsVC alloc]initWithId:model.product_id];
            [strongSelf.navigationController pushViewController:dvc animated:YES];
        };
        cell.imgTouchBlock = ^{
            kMeSTRONGSELF
            if(strongSelf->_productAdModel){
                SSProductDetailsVC *dvc = [[SSProductDetailsVC alloc]initWithId:strongSelf->_productAdModel.product_id];
                [strongSelf.navigationController pushViewController:dvc animated:YES];
            }
        };
        return cell;
    }else if(indexPath.row == 3){
        SSHomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSHomeMainCell class]) forIndexPath:indexPath];
        if(_serviceAdModel){
             kSDLoadImg(cell.imgMainPic, kMeUnNilStr(_serviceAdModel.ad_img));
        }
        kMeWEAKSELF
        cell.indexBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            SSGoodModel *model = self.arrMainPrjoctModel[index];
            SSServiceDetailsVC *dvc = [[SSServiceDetailsVC alloc]initWithId:model.product_id];
            [strongSelf.navigationController pushViewController:dvc animated:YES];
        };
        cell.imgTouchBlock = ^{
            kMeSTRONGSELF
            if(strongSelf->_serviceAdModel){
                SSProductDetailsVC *dvc = [[SSProductDetailsVC alloc]initWithId:strongSelf->_serviceAdModel.product_id];
                [strongSelf.navigationController pushViewController:dvc animated:YES];
            }
        };
        [cell setServiceUIWithArr:self.arrMainPrjoctModel];
        return cell;
    }else{
        return [UITableViewCell new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 0.1;//SSHomeMiaoDongCellHeight;
    }else if(indexPath.row == 1){
        return  [SSBaoQiangCell getCellHeightWithArr:self.arrMainTopModel];
    }else if(indexPath.row == 2){
        return [SSHomeMainCell getCellHeightWithArrModel:self.arrMainProductModel];
    }else if(indexPath.row == 3){
        return [SSHomeMainCell getServiceCellHeightWithArrModel:self.arrMainPrjoctModel];
    }else{
        return 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 2:{
            SSProductListVC *productList = [[SSProductListVC alloc]initWithType:SSGoodsTypeNetCommendStyle];
            [self.navigationController pushViewController:productList animated:YES];
        }
            break;
        case 3:{
//            self.tabBarController.selectedIndex = 1;
            SSProductListVC *productList = [[SSProductListVC alloc]initWithType:SSGoodsTypeNetServiceStyle];
            [self.navigationController pushViewController:productList animated:YES];
//            kMeWEAKSELF
//            productList.finishBlock = ^{
//                kMeSTRONGSELF
//                strongSelf.tabBarController.selectedIndex = 1;
//            };
        }
            break;
        default:
            break;
    }

}


#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSHomeMiaoDongCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSHomeMiaoDongCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSBaoQiangCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSBaoQiangCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSHomeMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSHomeMainCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (SSHomePageHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[SSHomePageHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSSHomePageHeaderViewHeight)];
        kMeWEAKSELF
        _headerView.searchBlock = ^{
            kMeSTRONGSELF
            SSProductSearchVC *svc = [[SSProductSearchVC alloc]init];
            [strongSelf.navigationController pushViewController:svc animated:NO];
        };
        _headerView.filetBlock = ^{
            kMeSTRONGSELF
            SSFilterVC *svc = [[SSFilterVC alloc]init];
            [strongSelf.navigationController pushViewController:svc animated:YES];
        };
    }
    return _headerView;
}


//- (UIButton *)btnRight{
//    if(!_btnRight){
//        _btnRight= [UIButton buttonWithType:UIButtonTypeCustom];
//        _btnRight.frame = CGRectMake(-10, 0, 30, 25);
//        _btnRight.contentMode = UIViewContentModeRight;
//        [_btnRight setImage:[UIImage imageNamed:@"common_nav_btn_search"] forState:UIControlStateNormal];
//        [_btnRight addTarget:self action:@selector(searchProduct:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _btnRight;
//}



@end
