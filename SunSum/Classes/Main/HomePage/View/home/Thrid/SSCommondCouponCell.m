//
//  SSCommondCouponCell.m
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSCommondCouponCell.h"
#import "SSCommondCouponContentCell.h"
#import "SSPinduoduoCoupleModel.h"
#import "SSCoupleMailDetalVC.h"
#import "SSThridHomeVC.h"

const static CGFloat kMargin = 10;
@interface SSCommondCouponCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrModel;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cosnCollectionHeight;

@end

@implementation SSCommondCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSomeThing];
    // Initialization code
}

- (void)initSomeThing{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _cosnCollectionHeight.constant = 135 * kMeFrameScaleX();
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SSCommondCouponContentCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SSCommondCouponContentCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SSPinduoduoCoupleModel *model = self.arrModel[indexPath.row];
    SSCoupleMailDetalVC *vc = [[SSCoupleMailDetalVC alloc]initWithPinduoudoModel:model];
    SSThridHomeVC *homeVC = (SSThridHomeVC *)[SSCommonTool getVCWithClassWtihClassName:[SSThridHomeVC class] targetResponderView:self];
    if(homeVC){
        [homeVC.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSCommondCouponContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SSCommondCouponContentCell class]) forIndexPath:indexPath];
    SSPinduoduoCoupleModel *model = self.arrModel[indexPath.row];
    [cell setUIWithModel:model];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kSSCommondCouponContentCellWdith* kMeFrameScaleX(), kSSCommondCouponContentCellHeight* kMeFrameScaleX());
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, kMargin, 0, kMargin);
}


- (void)setUIWithArr:(NSArray *)arrModel imgUrl:(NSString *)imgUrl{
    kSDLoadImg(_imgPic, kMeUnNilStr(imgUrl));
    _arrModel = arrModel;
    [self.collectionView reloadData];
}

+ (CGFloat)getCellHeight{
    return 255 * kMeFrameScaleX();
}

@end
