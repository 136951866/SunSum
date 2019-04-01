//
//  SSShoppingCartGoodsVC.h
//  SunSum
//
//  Created by hank on 2018/9/8.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@class SSGoodsModel;
@class SSShopppingCartBottomView;
@interface SSShoppingCartGoodsVC : SSBaseVC

//@property (nonatomic, strong) NSMutableArray<SSGoodsModel *> *arrStore;//商品
/**
 选中的数组
 */
@property (nonatomic, strong) NSMutableArray *arrSelect;
- (void)reloadData;
@property (nonatomic, copy) kMeBasicBlock countPriceBlock;
@property (nonatomic, copy) kMeBasicBlock judgeIsAllSelectBlock;

@end
