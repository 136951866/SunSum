//
//  SSNewMineHomeCell.m
//  SunSum
//
//  Created by hank on 2019/1/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNewMineHomeCell.h"
#import "SSNewMineHomeContentCell.h"
#import "SSMyDistrbutionVC.h"
#import "SSMyAppointmentVC.h"
#import "SSInteralExchangVC.h"
#import "SSLoginVC.h"
#import "SSAddTelView.h"
#import "SSRCConversationListVC.h"
#import "AppDelegate.h"
#import "SSMineCustomerPhone.h"
#import "SSExpireTipView.h"
#import "SSSelectAddressVC.h"
#import "SSMyMobileVC.h"
#import "SSProductListVC.h"
#import "MeMyActityMineVC.h"
#import "SSNewMineHomeVC.h"
#import "SSPosterListVC.h"
#import "SSArticelVC.h"
#import "SSVisiterHomeVC.h"
#import "SSCouponOrderVC.h"

#import "SSStoreApplyVC.h"
#import "SSStoreApplyModel.h"
#import "SSStoreApplyStatusVC.h"
#import "SSDynamicGoodApplyVC.h"
#import "SSPAVistorVC.h"

@interface SSNewMineHomeCell()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *_arrModel;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SSNewMineHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    self.backgroundColor = [UIColor colorWithHexString:@"fafafa"];
    _arrModel = @[];
    [self initSomeThing];
}

- (void)initSomeThing{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SSNewMineHomeContentCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SSNewMineHomeContentCell class])];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}

#pragma mark- CollectionView Delegate And DataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SSNewMineHomeVC *homeVc = [SSCommonTool getVCWithClassWtihClassName:[SSNewMineHomeVC class] targetResponderView:self];
    if(!homeVc){
        return;
    }
    SSMineHomeCellStyle type = [_arrModel[indexPath.row] intValue];
    switch (type) {
        case MeMyDistribution:{
            //我的中心
            SSMyDistrbutionVC *dvc = [[SSMyDistrbutionVC alloc]initWithC];
            [homeVc.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeMyCentraManagertment:{
            //管理中心
            SSMyDistrbutionVC *dvc = [[SSMyDistrbutionVC alloc]init];
            [homeVc.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeMyAppointment:{
            SSMyAppointmentVC *dvc = [[SSMyAppointmentVC alloc]initWithType:SSAppointmenyUseing];
            [homeVc.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeMyExchange:{
            SSInteralExchangVC *dvc = [[SSInteralExchangVC alloc]init];
            [homeVc.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeMyCustomer:{
            SSRCConversationListVC *cvc = [[SSRCConversationListVC alloc]init];
            [homeVc.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case MeMyCustomerPhone:{
            SSMineCustomerPhone *cvc = [[SSMineCustomerPhone alloc]init];
            [homeVc.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case MeMyAddress:{
            SSSelectAddressVC *address = [[SSSelectAddressVC alloc]init];
            [homeVc.navigationController pushViewController:address animated:YES];
        }
            break;
        case MeMyMobile:{
            SSMyMobileVC *mobile = [[SSMyMobileVC alloc]init];
            [homeVc.navigationController pushViewController:mobile animated:YES];
        }
            break;
        case MeMyActity:{
            MeMyActityMineVC *mobile = [[MeMyActityMineVC alloc]init];
            [homeVc.navigationController pushViewController:mobile animated:YES];
        }
            break;
        case MemyData:{
            SSVisiterHomeVC *mobile = [[SSVisiterHomeVC alloc]init];
            [homeVc.navigationController pushViewController:mobile animated:YES];
        }
            break;
        case MeMyPoster:{
            SSPosterListVC *mobile = [[SSPosterListVC alloc]init];
            [homeVc.navigationController pushViewController:mobile animated:YES];
        }
            break;
        case MeMyArticel:{
            SSArticelVC *mobile = [[SSArticelVC alloc]init];
            [homeVc.navigationController pushViewController:mobile animated:YES];
        }
            break;
        case MeStoreApply:{
            [SSPublicNetWorkTool postGetMemberStoreInfoWithsuccessBlock:^(ZLRequestResponse *responseObject) {
                if(![responseObject.data isKindOfClass:[NSDictionary class]] || responseObject.data==nil){
                    SSStoreApplyVC *vc = [[SSStoreApplyVC alloc]init];
                    [homeVc.navigationController pushViewController:vc animated:YES];
                }else{
                    SSStoreApplyModel *model = [SSStoreApplyModel mj_objectWithKeyValues:responseObject.data];
                    SSStoreApplyStatusVC *vc = [[SSStoreApplyStatusVC alloc]init];
                    vc.model = model;
                    [homeVc.navigationController pushViewController:vc animated:YES];
                }
            } failure:^(id object) {
                
            }];
        }
            break;
        case MeDynalApply:{
            SSDynamicGoodApplyVC *vc = [[SSDynamicGoodApplyVC alloc]init];
            [homeVc.navigationController pushViewController:vc animated:YES];
        }
            break;
        case MePAVistor:{
            SSPAVistorVC *vc = [[SSPAVistorVC alloc]init];
            [homeVc.navigationController pushViewController:vc animated:YES];
        }
        default:
            break;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSNewMineHomeContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSNewMineHomeContentCell class]) forIndexPath:indexPath];
    SSMineHomeCellStyle type = [_arrModel[indexPath.row] intValue];
    [cell setUIWithType:type];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 25);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kSSNewMineHomeContentCellWdith, kSSNewMineHomeContentCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)setUIWithAtrr:(NSArray *)arr{
    _arrModel = kMeUnArr(arr);
    [_collectionView reloadData];
}

+ (CGFloat)getHeightWithArr:(NSArray *)arr{
    if(arr.count == 0){
        return 0;
    }
    NSInteger section = (arr.count/3)+((arr.count%3)>0?1:0);
    CGFloat height =  (section * kSSNewMineHomeContentCellHeight)+25+15;
    return height;
}

@end
