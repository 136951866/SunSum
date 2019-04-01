//
//  SSAppointmentTimeMainCell.m
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSAppointmentTimeMainCell.h"
#import "SSAppointmentTimeCell.h"

@interface SSAppointmentTimeMainCell  ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *_arrTime;
    NSInteger _currentIndex;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation SSAppointmentTimeMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSomeThing];
    // Initialization code
}

- (void)initSomeThing{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAppointmentTimeCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SSAppointmentTimeCell class])];
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
    return _arrTime.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSAppointmentTimeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSAppointmentTimeCell class]) forIndexPath:indexPath];
    SSTimeModel *model = _arrTime[indexPath.row];
    [cell setUIWithModel:model isSelect:_currentIndex==indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kSSAppointmentTimeCellWdith, kSSAppointmentTimeCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)setUIWithArr:(NSArray *)arr currentIndex:(NSInteger)index{
    _currentIndex = index;
    _arrTime = arr;
    [self.collectionView reloadData];
}

+ (CGFloat)getCellHeightWithArr:(NSArray *)arr{
    NSInteger section = arr.count/5 + (arr.count%5>0?1:0);
    return (section * kSSAppointmentTimeCellHeight) + 85;
}

@end
