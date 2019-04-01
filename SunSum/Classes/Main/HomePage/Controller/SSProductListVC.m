//
//  SSProductListVC.m
//  SunSum
//
//  Created by hank on 2018/9/7.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSProductListVC.h"
#import "SSProductCell.h"
//#import "SSProductDetailsVC.h"
#import "SSThridProductDetailsVC.h"
#import "SSGoodModel.h"
#import "SSServiceDetailsVC.h"

#define kSSProductListHeaderViewHeight (115 * kMeFrameScaleY())

@interface SSProductListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,RefreshToolDelegate>{
    SSGoodsTypeNetStyle _type;
}

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) UIImageView         *imgMain;

@end

@implementation SSProductListVC

- (instancetype)initWithType:(SSGoodsTypeNetStyle)type{
    if(self = [super init]){
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品列表";
    [self.view addSubview:self.collectionView];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    if(_type == SSGoodsTypeNetCommendStyle){
        return @{@"pageSize":@(100),@"uid":kMeUnNilStr(kCurrentUser.uid)};
    }
    return @{@"type":@(_type),@"pageSize":@(100),@"uid":kMeUnNilStr(kCurrentUser.uid)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    NSArray *arr = [SSGoodModel mj_objectArrayWithKeyValuesArray:data];
    NSMutableArray *arrNeed = [SSGoodModel mj_objectArrayWithKeyValuesArray:data];
    for (NSInteger i=0; i<arr.count; i++) {
        SSGoodModel *model = arr[i];
        if(model.product_id == 74){
            [arrNeed removeObjectAtIndex:i];
            break;
        }
    }
    [self.refresh.arrData addObjectsFromArray:arrNeed];
}


#pragma mark- CollectionView Delegate And DataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_type == SSGoodsTypeNetServiceStyle){
        SSGoodModel *model = self.refresh.arrData [indexPath.row];
        SSServiceDetailsVC *details = [[SSServiceDetailsVC alloc]initWithId:model.product_id];
        [self.navigationController pushViewController:details animated:YES];
    }else{
        SSGoodModel *model = self.refresh.arrData [indexPath.row];
        SSThridProductDetailsVC *details = [[SSThridProductDetailsVC alloc]initWithId:model.product_id];
        [self.navigationController pushViewController:details animated:YES];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.refresh.arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSProductCell class]) forIndexPath:indexPath];
    SSGoodModel *model = self.refresh.arrData[indexPath.row];
    if(_type == SSGoodsTypeNetServiceStyle){
        [cell setServiceUIWithModel:model];
    }else{
        [cell setUIWithModel:model];
    }
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kSSProductCellWdith, kSSProductCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kSSMargin*2, kSSMargin*2, kSSMargin*2, kSSMargin*2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kSSMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kSSMargin;
}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if (kind == UICollectionElementKindSectionHeader){//处理头视图
//        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WMBannerView" forIndexPath:indexPath];
//        [headerView addSubview:self.imgMain];
//        return headerView;
//    }
//    else{
//        return nil;
//    }
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(SCREEN_WIDTH, kSSProductListHeaderViewHeight);
//}

#pragma mark - Getting And Setting

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SSProductCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SSProductCell class])];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"WMBannerView"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;

    }
    return _collectionView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.collectionView url:kGetApiWithUrl(SSIPcommonGoodsGetGoodsList)];
        _refresh.delegate = self;
        _refresh.numOfsize = @(100);
        kMeWEAKSELF
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            kMeSTRONGSELF
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = strongSelf->_type == SSGoodsTypeNetServiceStyle?@"没有服务":@"没有产品";
        }];
    }
    return _refresh;
}

- (UIImageView *)imgMain{
    if(!_imgMain){
        _imgMain = [[UIImageView alloc]init];
        _imgMain.frame = CGRectMake(0, 0, SCREEN_WIDTH, kSSProductListHeaderViewHeight);
        _imgMain.contentMode = UIViewContentModeScaleAspectFill;
        _imgMain.clipsToBounds = YES;
        [_imgMain sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:kImgPlaceholder];
    }
    return _imgMain;
}

@end
