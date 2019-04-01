//
//  SSShoppingCartAttrModel.m
//  SunSum
//
//  Created by gao lei on 2018/9/18.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSShoppingCartAttrModel.h"
#import "SSGoodDetailModel.h"

@implementation SSShoppingCartAttrModel

- (instancetype)initWithGoodmodel:(SSGoodDetailModel *)model{
    if(self = [super init]){
        self.token = kMeUnNilStr(kCurrentUser.token);
        self.goodsId = model.product_id;
        self.goodsNum = model.buynum;
        self.type = 0;
//        self.userid = kCurrentUser.userId;
        NSMutableArray *arrSpc = [NSMutableArray array];
        [model.arrSelect enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {\
            NSInteger selectIndex = [obj integerValue];
            SSGoodDetailSpecModel *oldSectionModel = kMeUnArr(model.spec)[idx];
            SSGoodSpecModel *ospecModel = kMeUnArr(oldSectionModel.spec_value)[selectIndex];
            [arrSpc addObject:@(ospecModel.idField)];
        }];
        NSString *str = [arrSpc componentsJoinedByString:@","];
#warning -nowOnlyOne 目前一个
        self.specId = [str integerValue];
        self.store_id = 1;
    }
    return self;
}

@end
