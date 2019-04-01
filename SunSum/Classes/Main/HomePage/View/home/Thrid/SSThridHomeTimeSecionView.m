//
//  SSThridHomeTimeSecionView.m
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSThridHomeTimeSecionView.h"
#import "SSThridHomeTimeSecionContentCell.h"
#import "SSThridHomeRudeTimeModel.h"

@interface SSThridHomeTimeSecionView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger _selextIndex;
    kMeIndexBlock _selectBlocl;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrModel;

@end

@implementation SSThridHomeTimeSecionView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSomeThing];
    // Initialization code
}

- (void)initSomeThing{
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SSThridHomeTimeSecionContentCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SSThridHomeTimeSecionContentCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    _selextIndex =indexPath.row;
    [self.collectionView reloadData];
    kMeCallBlock(_selectBlocl,indexPath.row);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSThridHomeTimeSecionContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSThridHomeTimeSecionContentCell class]) forIndexPath:indexPath];
    SSThridHomeRudeTimeModel *model = self.arrModel[indexPath.row];
    [cell setUIWIthModel:model isSelect:indexPath.row==_selextIndex];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kSSThridHomeTimeSecionContentCellWdith, kSSThridHomeTimeSecionContentCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)setUIWithArr:(NSArray *)arrModel selectIndex:(NSInteger)selextIndex selectBlock:(kMeIndexBlock)selectBlock{
    _arrModel = arrModel;
    _selextIndex = selextIndex;
    _selectBlocl = selectBlock;
    [self.collectionView reloadData];
    [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathWithIndex:_selextIndex] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}
@end
