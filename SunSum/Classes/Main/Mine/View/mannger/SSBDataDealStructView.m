//
//  SSBDataDealStructView.m
//  SunSum
//
//  Created by hank on 2019/2/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBDataDealStructView.h"
#import "SSBDataDealStructContentView.h"
#import "SSBDataDealModel.h"

@interface SSBDataDealStructView ()

@end

@implementation SSBDataDealStructView


- (void)setUIWithArr:(NSArray *)arrModel{
//    for (NSInteger i =0; i<arrModel.count; i++) {
//        SSBDataDealAchievementCatagery *model =arrModel[i];
//        NSInteger row = i/3;//行
//        NSInteger col = i%3;//列
//        CGFloat picX =  (kSSBDataDealStructContentViewWdith) * col;
//        CGFloat picY = kSSBDataDealStructContentViewHeight * row;
//        SSBDataDealStructContentView *view = [[SSBDataDealStructContentView alloc]initWithFrame:CGRectMake(picX, picY, kSSBDataDealStructContentViewWdith, kSSBDataDealStructContentViewHeight)];
//        view.lblCategory.text = kMeUnNilStr(model.category_name);
//        view.lblPercent.text = kMeUnNilStr(model.percent);
//        view.viewRightLine.hidden = (col==2);
//        [self addSubview:view];
//        if(col==0){
//            UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, picY, SCREEN_WIDTH-30, 1)];
//            topLineView.backgroundColor = [UIColor colorWithHexString:@"e1e1e1"];
//            [self addSubview:topLineView];
//        }
//    }
}

- (void)setGoodNUmUIWithArr:(NSArray *)arrModel{
//    for (NSInteger i =0; i<arrModel.count; i++) {
//        SSBDataDealGoodsNum *model =arrModel[i];
//        NSInteger row = i/3;//行
//        NSInteger col = i%3;//列
//        CGFloat picX =  (kSSBDataDealStructContentViewWdith) * col;
//        CGFloat picY = kSSBDataDealStructContentViewHeight * row;
//        SSBDataDealStructContentView *view = [[SSBDataDealStructContentView alloc]initWithFrame:CGRectMake(picX, picY, kSSBDataDealStructContentViewWdith, kSSBDataDealStructContentViewHeight)];
//        view.lblCategory.text = kMeUnNilStr(model.product_name);
//        view.lblPercent.text = kMeUnNilStr(model.count);
//        view.viewRightLine.hidden = (col==2);
//        [self addSubview:view];
//        if(col==0){
//            UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, picY, SCREEN_WIDTH-30, 1)];
//            topLineView.backgroundColor = [UIColor colorWithHexString:@"e1e1e1"];
//            [self addSubview:topLineView];
//        }
//    }
}



+ (CGFloat)getViewWithArr:(NSArray *)arr{
    if(arr.count == 0){
        return 0;
    }
    NSInteger section = (arr.count/3)+((arr.count%3)>0?1:0);
    CGFloat height =  section *kSSBDataDealStructContentViewHeight;
    return height;
}

@end
