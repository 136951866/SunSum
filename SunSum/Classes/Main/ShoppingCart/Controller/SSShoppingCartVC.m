//
//  SSShoppingCartVC.m
//  SunSum
//
//  Created by hank on 2018/9/8.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSShoppingCartVC.h"
#import "SSShoppingCartModel.h"
#import "SSShopppingCartBottomView.h"
#import "SSShoppingCartCell.h"
#import "SSShoppingCartGoodsVC.h"


@interface SSShoppingCartVC ()<JXCategoryViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) SSShopppingCartBottomView *bottomView;
/**
 选中的数组
 */
@property (nonatomic, strong) NSMutableArray *arrSelect;
//@property (nonatomic, strong) NSMutableArray<SSGoodsModel *> *arrStore;//商品
//@property (nonatomic, strong) NSMutableArray<SSGoodsModel *> *arrService;//服务
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) SSShoppingCartGoodsVC *goodVC;
@property (nonatomic, strong) SSShoppingCartGoodsVC *serviceVC;



@end

@implementation SSShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bottomView];
//    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(kSSShopppingCartBottomViewHeight));
//        make.width.equalTo(@(self.view.width));
//        make.top.equalTo(@(self.view.bottom-kSSShopppingCartBottomViewHeight-kMeTabBarHeight));
//    }];
//
//    for (int i =0; i<20; i++) {
//        SSGoodsModel *goods = [SSGoodsModel new];
//        goods.realPrice = @(i*5+1).description;
//        goods.count = @"1";
//        goods.isSelect = NO;
//        goods.goodsName = [NSString stringWithFormat:@"%@,%ld",@"test",i];
//        goods.shopName = @"超级会员3.0折尊享";
//        [self.arrStore addObject:goods];
//    }
//
//    //
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kMeNavBarHeight+44, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-44-kMeTabBarHeight-kSSShopppingCartBottomViewHeight)];
//    self.scrollView.delegate = self;
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2,  SCREEN_HEIGHT-kMeNavBarHeight-44-kMeTabBarHeight-kSSShopppingCartBottomViewHeight);
//    self.scrollView.bounces = NO;
////    [self.scrollView setDelaysContentTouches:NO];
////    [self.scrollView setCanCancelContentTouches:NO];
//    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    [self.scrollView addSubview:self.goodVC.view];
//    [self.scrollView addSubview:self.serviceVC.view];
//    [self.view addSubview:self.scrollView];
//
//    //1、初始化JXCategoryTitleView
//    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, 44)];
//    self.categoryView.titles = @[@"商品",@"服务"];
//    self.categoryView.delegate = self;
//    self.categoryView.titleSelectedColor = kSSPink;
//    self.categoryView.contentScrollView = self.scrollView;
//    [self.view addSubview:self.categoryView];
}

//- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
//    NSLog(@"%ld",index);
//}
//
//
////-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
////    return YES;
////}
//
//- (void)clickAllSelectBottomView:(SSShopppingCartBottomView *)bottomView {
//    kMeWEAKSELF
//    bottomView.AllClickBlock = ^(BOOL isClick) {
//        kMeSTRONGSELF
//        for (SSGoodsModel *goodsModel in strongSelf.arrSelect) {
//            goodsModel.isSelect = NO;
//        }
//        [strongSelf.arrSelect removeAllObjects];
//        if (isClick) {//选中
//            NSLog(@"全选");
//            for (SSGoodsModel *goodsModel in strongSelf.arrStore) {
//                goodsModel.isSelect = YES;
//                [strongSelf.arrSelect addObject:goodsModel];
//            }
//        } else {//取消选中
//            NSLog(@"取消全选");
//            for (SSGoodsModel *goodsModel in strongSelf.arrStore) {
//                goodsModel.isSelect = NO;
//            }
//        }
//        [self.goodVC reloadData];
//        [strongSelf countPrice];
//    };
//    
//    bottomView.AccountBlock = ^{
//        kMeSTRONGSELF
//        NSLog(@"acount");
//    };
//    
//    bottomView.DelBlock = ^{
//        kMeSTRONGSELF
//        if(strongSelf.arrSelect.count == 0){
//            kMeAlter(@"提示", @"请先选择");
//        }else{
//            SSAlertView *aler = [[SSAlertView alloc] initWithTitle:@"" message:@"确定删除?"];
//            [aler addButtonWithTitle:@"确定" block:^{
//                
//                [strongSelf delGoosAction];
//            }];
//            [aler addButtonWithTitle:@"取消"];
//            [aler show];
//        }
//    };
//}
//
//- (void)delGoosAction{
//    for (SSGoodsModel *goodsModel in self.arrSelect) {
//        [self.arrStore removeObject:goodsModel];
//    }
//    [self.arrSelect removeAllObjects];
//    [self judgeIsAllSelect];
//    [self countPrice];
//    [self.goodVC reloadData];
//}
//
///**
// 是否全选
// */
//- (void)judgeIsAllSelect {
//    NSInteger count = self.arrStore.count;
//    //先遍历购物车商品, 得到购物车有多少商品
//    //如果购物车总商品数量 等于 选中的商品数量, 即表示全选了
//    if (count == self.arrSelect.count) {
//        self.bottomView.isClick = YES;
//    } else {
//        self.bottomView.isClick = NO;
//    }
//}
//
///**
// 计算价格
// */
//- (void)countPrice {
//    double totlePrice = 0.0;
//    for (SSGoodsModel *goodsModel in self.arrSelect) {
//        double price = [goodsModel.realPrice doubleValue];
//        totlePrice += price * [goodsModel.count integerValue];
//    }
//    
//    _bottomView.allPriceLabel.text = [NSString stringWithFormat:@"合计 ￥%.2f", totlePrice];
//}
//
//#pragma mark - Set And Get
//
//- (NSMutableArray *)arrSelect {
//    if (!_arrSelect) {
//        _arrSelect = [NSMutableArray new];
//    }
//    return _arrSelect;
//}
//
//- (NSMutableArray *)arrStore {
//    if (!_arrStore) {
//        _arrStore = [NSMutableArray new];
//    }
//    return _arrStore;
//}
//- (NSMutableArray *)arrService {
//    if (!_arrService) {
//        _arrService = [NSMutableArray new];
//    }
//    return _arrService;
//}
//
//- (SSShopppingCartBottomView *)bottomView{
//    if(!_bottomView){
//        _bottomView = [[[NSBundle mainBundle]loadNibNamed:@"SSShopppingCartBottomView" owner:nil options:nil] lastObject];
//        [self clickAllSelectBottomView:_bottomView];
//    }
//    return _bottomView;
//}
//
//- (SSShoppingCartGoodsVC *)goodVC{
//    if(!_goodVC){
//        _goodVC = [[SSShoppingCartGoodsVC alloc]init];
//        _goodVC.arrStore = self.arrStore;
//        _goodVC.arrSelect = self.arrSelect;
//        _goodVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        kMeWEAKSELF
//        _goodVC.judgeIsAllSelectBlock = ^{
//            kMeSTRONGSELF
//            [strongSelf judgeIsAllSelect];
//        };
//        _goodVC.countPriceBlock = ^{
//            kMeSTRONGSELF
//             [strongSelf countPrice];
//        };
//        [self addChildViewController:_goodVC];
//    }
//    return _goodVC;
//}
//
//- (SSShoppingCartGoodsVC *)serviceVC{
//    if(!_serviceVC){
//        _serviceVC = [[SSShoppingCartGoodsVC alloc]init];
//        _serviceVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        _serviceVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-44-kMeTabBarHeight-kSSShopppingCartBottomViewHeight);
//        [self addChildViewController:_serviceVC];
//    }
//    return _serviceVC;
//}

@end
