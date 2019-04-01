//
//  SSCoupleHomeMainGoodGoodsCell.m
//  SunSum
//
//  Created by hank on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCoupleHomeMainGoodGoodsCell.h"
#import "SSCoupleMailCell.h"
#import "SSCoupleModel.h"
#import "SSCoupleMailDetalVC.h"
#import "SSCoupleHomeVC.h"
#import "SSPinduoduoCoupleModel.h"

@interface SSCoupleHomeMainGoodGoodsCell ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *_arrModel;
    BOOL _isTbK;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SSCoupleHomeMainGoodGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _arrModel = @[];
    [self initSomeThing];
    // Initialization code
}

#pragma mark- CollectionView Delegate And DataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_selectBlock){
        kMeCallBlock(_selectBlock,indexPath.row);
        return;
    }
    if(_isTbK){
         SSCoupleModel *model = _arrModel[indexPath.row];
        SSCoupleMailDetalVC *vc = [[SSCoupleMailDetalVC alloc]initWithProductrId:model.num_iid couponId:kMeUnNilStr(model.coupon_id) couponurl:kMeUnNilStr(model.coupon_share_url)];
        SSCoupleHomeVC *homevc = [SSCommonTool getVCWithClassWtihClassName:[SSCoupleHomeVC class] targetResponderView:self];
        if(homevc){
            [homevc.navigationController pushViewController:vc animated:YES];
        }
    }else{
        SSPinduoduoCoupleModel *model = _arrModel[indexPath.row];
        SSCoupleMailDetalVC *vc = [[SSCoupleMailDetalVC alloc]initWithPinduoudoModel:model];
        SSCoupleHomeVC *homevc = [SSCommonTool getVCWithClassWtihClassName:[SSCoupleHomeVC class] targetResponderView:self];
        if(homevc){
            [homevc.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSCoupleMailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSCoupleMailCell class]) forIndexPath:indexPath];
    if(_isTbK){
        SSCoupleModel *model = _arrModel[indexPath.row];
        [cell setUIWithModel:model];
    }else{
        SSPinduoduoCoupleModel *model = _arrModel[indexPath.row];
        [cell setpinduoduoUIWithModel:model];
    }
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kSSCoupleMailCellWdith, kSSCoupleMailCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kSSMargin, 0, kSSMargin, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kSSMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kSSMargin;
}

- (void)initSomeThing{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.backgroundColor = kSSf5f4f4;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SSCoupleMailCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SSCoupleMailCell class])];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}

- (void)setUIWithArr:(NSArray*)arr{
    _isTbK = YES;
    _arrModel = kMeUnArr(arr);
    [_collectionView reloadData];
}

- (void)setPinduoduoUIWithArr:(NSArray*)arr{
    _isTbK = NO;
    _arrModel = kMeUnArr(arr);
    [_collectionView reloadData];
}

+ (CGFloat)getCellHeightWithArr:(NSArray*)arr{
    if(arr.count == 0){
        return 0;
    }
    NSInteger section = (arr.count/2)+((arr.count%2)==1?1:0);
    CGFloat height =  (section * (kSSCoupleMailCellHeight+kSSMargin))+kSSMargin;
    return height;
}
@end
