//
//  SSPosterContentListCell.m
//  SunSum
//
//  Created by hank on 2018/11/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSPosterContentListCell.h"
#import "SSPosterContentListContentCell.h"
#import "SSPosterModel.h"
#import "SSCreatePosterVC.h"
#import "SSPosterContentListVC.h"

@interface SSPosterContentListCell ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    SSPosterModel *_model;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;


@property (nonatomic, strong) NSArray *arrModel;
@end

@implementation SSPosterContentListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSomeThing];
}

- (void)initSomeThing{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SSPosterContentListContentCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SSPosterContentListContentCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

- (IBAction)moreAction:(UIButton *)sender {
    kMeCallBlock(_moreBlock);
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SSPosterChildrenModel *model = _model.children[indexPath.row];
    SSCreatePosterVC *vc = [[SSCreatePosterVC alloc]initWithModel:model];
    SSPosterContentListVC *homeVC = [SSCommonTool getVCWithClassWtihClassName:[SSPosterContentListVC class] targetResponderView:self];
    if(homeVC){
        [homeVC.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model.children.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSPosterContentListContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSPosterContentListContentCell class]) forIndexPath:indexPath];
    SSPosterChildrenModel *model = _model.children[indexPath.row];
    [cell setUIWithModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kSSPosterContentListContentCellWdith,kSSPosterContentListContentCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return k10Margin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return k10Margin;
}

- (void)setUIWithModel:(SSPosterModel *)model{
    if(kMeUnArr(model.children).count == 0){
        self.collectionView.hidden = YES;
    }else{
        self.collectionView.hidden = NO;
    }
    _model = model;
    _lblTitle.text = kMeUnNilStr(model.classify_name);
    _lblSubTitle.text = kMeUnNilStr(model.desc);
    [self.collectionView reloadData];
}

+ (CGFloat)getCellWithModel:(SSPosterModel *)model{
    CGFloat height = kSSPosterContentListCellHeight;
    if(kMeUnArr(model.children).count == 0){
        height -=177;
    }
    return height;
}

@end
