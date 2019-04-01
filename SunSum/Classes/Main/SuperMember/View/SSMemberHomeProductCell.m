//
//  SSMemberHomeProductCell.m
//  SunSum
//
//  Created by hank on 2018/10/16.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMemberHomeProductCell.h"
#import "SSProductCell.h"
#import "SSGoodModel.h"
#import "SSSuperMemberHomeModel.h"
#import "SSProductDetailsVC.h"
#import "SSMemberHomeVC.h"

@interface SSMemberHomeProductCell ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *_arrModel;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImageHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SSMemberHomeProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSomeThing];
    _arrModel = [NSArray array];
    // Initialization code
}

- (void)initSomeThing{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SSProductCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SSProductCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SSMemberHomeVC *homeVC = (SSMemberHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSMemberHomeVC class] targetResponderView:self];
    if(homeVC){
        SSGoodModel *model = _arrModel [indexPath.row];
        SSProductDetailsVC *details = [[SSProductDetailsVC alloc]initWithId:model.product_id];
        [homeVC.navigationController pushViewController:details animated:YES];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSProductCell class]) forIndexPath:indexPath];
    SSGoodModel *model = _arrModel[indexPath.row];
    [cell setUIWithModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat selfW = SCREEN_WIDTH - (k15Margin *4);
    CGFloat w =  (selfW-k15Margin*2)/2;
    return CGSizeMake(w, kSSProductCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

// 单元的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

// 每个小单元的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)setUiWithModel:(SSSuperMemberHomeModel *)model{
    CGFloat w = SCREEN_WIDTH - (k15Margin *4);
    _consImageHeight.constant =((w * 240)/690);
    _arrModel = kMeUnArr(model.member_buy);
    [_collectionView reloadData];
}

+ (CGFloat)getCellHeightWithModel:(SSSuperMemberHomeModel *)model{
    CGFloat height = 30;
    CGFloat w = SCREEN_WIDTH - (k15Margin *4);
    height+=((w * 240)/690);
    NSArray *arr = kMeUnArr(model.member_buy);;
    NSInteger section = (arr.count/2)+((arr.count%2)==1?1:0);
    height+= (section * kSSProductCellHeight);
    return height;
}

@end
