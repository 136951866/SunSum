//
//  SSGoodDetailModel.m
//  SunSum
//
//  Created by hank on 2018/9/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSGoodDetailModel.h"

@implementation SSGoodDetailCommentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"idField" : @"id",
             @"goodcomment" : @"comment",
             };
}
@end

@implementation SSGoodDetailSpecModel

SSModelObjectClassInArrayWithDic(@{@"spec_value" : [SSGoodSpecModel class]})

@end


@implementation SSGoodDetailModel

SSModelObjectClassInArrayWithDic((@{@"spec" : [SSGoodDetailSpecModel class],@"product_comment" : [SSGoodDetailCommentModel class]}))


- (NSMutableArray *)arrSelect{
    if(!_arrSelect){
        _arrSelect = [NSMutableArray array];
    }
    return _arrSelect;
}

- (NSString*)rudeTip{
    if(self.restrict_num!=0){
        return [NSString stringWithFormat:@"限时秒杀(每人限购%ld件,超出的部分按原价购买)",self.restrict_num];
    }else{
        return @"";
    }
}

- (NSInteger)value{
    if(kMeUnNilStr(self.equities).length){
        NSInteger num = ([self.equities integerValue])/20;
        if(num>=0 && num<=5){
           return num;
        }
        return 0;
    }else{
        return 0;
    }
}

@end


