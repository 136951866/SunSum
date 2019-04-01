//
//  SSAppointmentDateMainCell.m
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSAppointmentDateMainCell.h"
#import "SSAppointmentDateCell.h"

@interface SSAppointmentDateMainCell  ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *_arrWeek;
    NSInteger _currentIndex;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SSAppointmentDateMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSomeThing];
    // Initialization code
}

- (void)initSomeThing{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAppointmentDateCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SSAppointmentDateCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _currentIndex = indexPath.row;
    kMeCallBlock(_selectBlock,_currentIndex);
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrWeek.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSAppointmentDateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSAppointmentDateCell class]) forIndexPath:indexPath];
    SSTimeModel *model = _arrWeek[indexPath.row];
    [cell setUIWithModel:model isSelect:_currentIndex==indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kSSAppointmentDateCellWidth, kSSAppointmentDateCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, k15Margin, 0, k15Margin);
}

- (void)setUIWithArr:(NSArray *)arr currentIndex:(NSInteger)index{
    _currentIndex = index;
    _arrWeek = arr;
    [self.collectionView reloadData];
}



@end
