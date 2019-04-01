//
//  SSProductDetalsBuyedCell.m
//  SunSum
//
//  Created by hank on 2018/9/8.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSProductDetalsBuyedCell.h"
#import "SSProductDetalsBuyedContentCell.h"
#import "SSGoodModel.h"
//#import "SSProductDetailsVC.h"
#import "SSThridProductDetailsVC.h"
#import "SSHomePageVC.h"
#import "SSServiceDetailsVC.h"
#import "SSMineExchangeDetailVC.h"

const static CGFloat kMargin = 15;

@interface SSProductDetalsBuyedCell ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    BOOL _isService;
    SSStoreDetailModel *_storeDetailModel;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrModel;

@end

@implementation SSProductDetalsBuyedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSomeThing];
    // Initialization code
}

- (void)initSomeThing{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SSProductDetalsBuyedContentCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SSProductDetalsBuyedContentCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_isService){
        SSServiceDetailsVC *dVC = [SSCommonTool getVCWithClassWtihClassName:[SSServiceDetailsVC class] targetResponderView:self];
        if(dVC){
            SSGoodModel *model = self.arrModel[indexPath.row];
            //有_storeDetailModel是门店进去的 nil是首页进去的
            if(_storeDetailModel){
                SSServiceDetailsVC *dvc = [[SSServiceDetailsVC alloc]initWithId:model.product_id storeDetailModel:_storeDetailModel];
                [dVC.navigationController pushViewController:dvc animated:YES];
            }else{
                SSServiceDetailsVC *dvc = [[SSServiceDetailsVC alloc]initWithId:model.product_id];
                [dVC.navigationController pushViewController:dvc animated:YES];
            }
        }
    }else{
        SSThridProductDetailsVC *dVC = [SSCommonTool getVCWithClassWtihClassName:[SSThridProductDetailsVC class] targetResponderView:self];
        if(dVC){
            SSGoodModel *model = self.arrModel[indexPath.row];
            SSThridProductDetailsVC *dvc = [[SSThridProductDetailsVC alloc]initWithId:model.product_id];
            [dVC.navigationController pushViewController:dvc animated:YES];
        }else{
            SSMineExchangeDetailVC *mvc = [SSCommonTool getVCWithClassWtihClassName:[SSMineExchangeDetailVC class] targetResponderView:self];
            if(mvc){
                SSGoodModel *model = self.arrModel[indexPath.row];
                SSThridProductDetailsVC *dvc = [[SSThridProductDetailsVC alloc]initWithId:model.product_id];
                [mvc.navigationController pushViewController:dvc animated:YES];
            }
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSProductDetalsBuyedContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSProductDetalsBuyedContentCell class]) forIndexPath:indexPath];
    if(_isService){
        SSGoodModel *model = self.arrModel[indexPath.row];
        [cell setUIServiceWithModel:model];
    }else{
        SSGoodModel *model = self.arrModel[indexPath.row];
        [cell setUIWithModel:model];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kSSProductDetalsBuyedContentCellWidth, kSSProductDetalsBuyedContentCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, kMargin, 2, kMargin);
}

- (void)setUIWithArr:(NSArray *)arrModel{
    _isService = NO;
    _arrModel = arrModel;
    [self.collectionView reloadData];
}

- (void)setServiceUIWithArr:(NSArray *)arrModel{
    _isService = YES;
    _arrModel = arrModel;
    [self.collectionView reloadData];
}

- (void)setServiceUIWithArr:(NSArray *)arrModel storeDetailModel:(SSStoreDetailModel *)storeDetailModel{
    _storeDetailModel = storeDetailModel;
    [self setServiceUIWithArr:arrModel];
}


@end
