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
#import "SSProductShoppingCartVC.h"

#import "SSCouponOrderVC.h"
#import "SSBStoreMannagerVC.h"
#import "SSMySelfExtractionOrderVC.h"
#import "SSBrandManngerVC.h"
#import "SSMoneyDetailedVC.h"
#import "SSMineNewShareVC.h"
#import "SSClerkManngerVC.h"
//#import "MEBDataDealVC.h"
#import "SSBdataVC.h"
#import "SSMyAppointmentVC.h"
#import "SSGetCaseMainSVC.h"
#import "SSWithdrawalVC.h"
#import "SSClerkStatisticsVC.h"
#import "SSDistributionOrderVC.h"
#import "SSDistributionMoneyVC.h"
#import "SSDistributionTeamVC.h"
#import "SSDistributionOrderMainVC.h"
#import "MENewMineCellHeaderView.h"
#import "MEBrandStoryVC.h"

@interface SSNewMineHomeCell()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *_arrModel;
    SSClientTypeStyle _type;
    NSString *_levStr;
    NSString *_title;
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
    [_collectionView  registerNib:[UINib nibWithNibName:NSStringFromClass([MENewMineCellHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([MENewMineCellHeaderView class])];
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
        case MeHomemeiodu:{
            //我的中心
            SSMyDistrbutionVC *dvc = [[SSMyDistrbutionVC alloc]initWithC];
            [homeVc.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case MeHomeyongjing:{
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
//        case MePAVistor:{
//            SSPAVistorVC *vc = [[SSPAVistorVC alloc]init];
//            [homeVc.navigationController pushViewController:vc animated:YES];
//        }
            
        case MeShopCartt:{
            SSProductShoppingCartVC *vc = [[SSProductShoppingCartVC alloc]init];
            [homeVc.navigationController pushViewController:vc animated:YES];
        }
            break;
        case MeHomeshangji:{
            SSMyMobileVC *mobile = [[SSMyMobileVC alloc]init];
            mobile.isSuper = YES;
            [homeVc.navigationController pushViewController:mobile animated:YES];
        }
            break;
        case MeHomeCorderall:{
            //C
            SSDistributionOrderMainVC *orderVC = [[SSDistributionOrderMainVC alloc]init];
            [homeVc.navigationController pushViewController:orderVC animated:YES];
        }
            
            break;
            //        case MEDistributionMoney:{
            //            //            MEDistributionMoneyVC *vc = [[MEDistributionMoneyVC alloc]initWithModel:@""];
            //            //            [self.navigationController pushViewController:vc animated:YES];
            //        }
            
            break;
        case MeHometuandui:{
            SSDistributionTeamVC *vc = [[SSDistributionTeamVC alloc]initWithType:_type];
            [homeVc.navigationController pushViewController:vc animated:YES];
        }
            break;
        case MeHomeorderall:{
            //C以上
            SSMoneyDetailedVC *vc = [[SSMoneyDetailedVC alloc]init];
            [homeVc.navigationController pushViewController:vc animated:YES];
        }
            break;
        case MeHometuigcode:{
            SSMineNewShareVC *vc = [[SSMineNewShareVC alloc]initWithLevel:_levStr];
            [homeVc.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case MeHomedianyuan:{
            SSClerkManngerVC *clerkVC = [[SSClerkManngerVC alloc]init];
            [homeVc.navigationController pushViewController:clerkVC animated:YES];
        }
            break;
            
        case MeHomeyuyue:{
            SSMyAppointmentVC *dvc = [[SSMyAppointmentVC alloc]initWithType:SSAppointmenyUseing userType:SSClientBTypeStyle];
            [homeVc.navigationController pushViewController:dvc animated:YES];
        }
            break;
            
        case MeHomedata:{
            SSBdataVC *vc = [[SSBdataVC alloc]init];
            [homeVc.navigationController pushViewController:vc animated:YES];
        }
            break;
        case Mehomeyongjitongji:{
            SSClerkStatisticsVC *vc = [[SSClerkStatisticsVC alloc]initWithType:SSClientTypeClerkStyle memberId:@""];
            [homeVc.navigationController pushViewController:vc animated:YES];
        }
            break;
        case MeHometixian:{
            SSGetCaseMainSVC *vc = [[SSGetCaseMainSVC alloc]initWithType:SSGetCaseAllStyle];
            [homeVc.navigationController pushViewController:vc animated:YES];
        }
            break;
        case MeHomejuanyngjing:{
            SSCouponOrderVC *couponVC = [[SSCouponOrderVC alloc]init];
            [homeVc.navigationController pushViewController:couponVC animated:YES];
        }
            break;
        case MeHomedianpu:{
            SSBStoreMannagerVC *storeVC = [[SSBStoreMannagerVC alloc]init];
            [homeVc.navigationController pushViewController:storeVC animated:YES];
        }
            break;
        case MeHomeziti:{
            SSMySelfExtractionOrderVC *orderVC = [[SSMySelfExtractionOrderVC alloc]init];
            [homeVc.navigationController pushViewController:orderVC animated:YES];
        }
            break;
        case MeHomepinpaigli:{
            SSBrandManngerVC *brandVC = [[SSBrandManngerVC alloc]init];
            [homeVc.navigationController pushViewController:brandVC animated:YES];
        }
            break;
        case MeBrandStory:{
            MEBrandStoryVC *brandVC = [[MEBrandStoryVC alloc]init];
            [homeVc.navigationController pushViewController:brandVC animated:YES];
        }
            break;
            
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH-30, kMENewMineCellHeaderViewHeight);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MENewMineCellHeaderView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([MENewMineCellHeaderView class]) forIndexPath:indexPath];
        reusableView.lblTitle.text = kMeUnNilStr(_title);
        return reusableView;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor clearColor];
        return footerView;
    }
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

- (void)setUIWithAtrr:(NSArray *)arr title:(NSString*)title{
    _arrModel = kMeUnArr(arr);
    _title = kMeUnNilStr(title);
    switch (kCurrentUser.user_type) {
        case 1:{
            _type = SSClientOneTypeStyle;
            _levStr = @"当前等级:售后中心";
        }
            break;
        case 2:{
            _type = SSClientTwoTypeStyle;
            _levStr = @"当前等级:营销中心";
        }
            break;
        case 4:{
            //C
            _type = SSClientCTypeStyle;
            _levStr = @"当前等级:普通会员";
            
        }
            break;
        case 3:{
            //B
            _type = SSClientBTypeStyle;
            _levStr = @"当前等级:体验中心";
            
        }
            break;
        case 5:{
            //clerk
            _type = SSClientTypeClerkStyle;
            _levStr = @"当前等级:店员";
            
        }
            break;
        default:{
            _type = SSClientTypeErrorStyle;
            _levStr = @"";
        }
            break;
    }
    [_collectionView reloadData];
}

+ (CGFloat)getHeightWithArr:(NSArray *)arr{
    if(arr.count == 0){
        return 0;
    }
    NSInteger section = (arr.count/3)+((arr.count%3)>0?1:0);
    CGFloat height =  (section * kSSNewMineHomeContentCellHeight)+25+15+37;
    return height;
}

@end
