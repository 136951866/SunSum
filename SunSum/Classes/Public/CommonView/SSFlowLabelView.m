//
//  SSFlowLabelView.m
//  SunSum
//
//  Created by hank on 2019/1/25.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSFlowLabelView.h"

const static CGFloat SSFlowLabelViewLabelHeight = 17;
const static CGFloat SSFlowLabelViewLabelMargin = 5;
const static CGFloat SSFlowLabelViewLabelPadding = 8;

#define kSSFlowLabelViewWdith (SCREEN_WIDTH - 100)

@interface SSFlowLabelView(){
    NSMutableArray *_arrLabel;
}

@end

@implementation SSFlowLabelView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        _arrLabel = [NSMutableArray array];
        self.flowLabelViewWdith = kSSFlowLabelViewWdith;
        self.flowLabelViewLabelHeight = SSFlowLabelViewLabelHeight;
    }
    return self;
}

+ (CGFloat)getSSFlowLabelViewHeightWithArr:(NSArray *)arr{
    CGFloat height = 0;
    if(kMeUnArr(arr).count){
        for (int i = 0; i < arr.count; i ++){
            NSString *name = arr[i];
            static UILabel *recordlabel =nil;
            
            UILabel *lbl = [[UILabel alloc]init];
            lbl.font = [UIFont systemFontOfSize:10];
 
            CGRect rect = [name boundingRectWithSize:CGSizeMake(kSSFlowLabelViewWdith -(SSFlowLabelViewLabelMargin * 2), SSFlowLabelViewLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:lbl.font} context:nil];
            
            CGFloat BtnW = rect.size.width+SSFlowLabelViewLabelPadding;
            BtnW = BtnW>(kSSFlowLabelViewWdith - (SSFlowLabelViewLabelMargin *2))?(kSSFlowLabelViewWdith - (SSFlowLabelViewLabelMargin *2)):BtnW;
            
            CGFloat BtnH = SSFlowLabelViewLabelHeight;
            if (i == 0){
                lbl.frame =CGRectMake(SSFlowLabelViewLabelMargin, 0, BtnW, BtnH);
            }else{
                //算出剩下的宽度
                CGFloat yuWidth = kSSFlowLabelViewWdith - (SSFlowLabelViewLabelMargin*2) -recordlabel.frame.origin.x -recordlabel.frame.size.width;
                if (yuWidth >= BtnW) {
                    //如果大于就放在同一行
                    lbl.frame =CGRectMake(recordlabel.frame.origin.x +recordlabel.frame.size.width + SSFlowLabelViewLabelMargin, recordlabel.frame.origin.y, BtnW, BtnH);
                }else{
                    //如果不够就换行
                    lbl.frame =CGRectMake(SSFlowLabelViewLabelMargin, recordlabel.frame.origin.y+recordlabel.frame.size.height+SSFlowLabelViewLabelMargin, BtnW, BtnH);
                }
            }
            height = CGRectGetMaxY(lbl.frame)+SSFlowLabelViewLabelMargin;
            recordlabel = lbl;
        }
    }
    return height;
}
- (void)reloaWithArr:(NSArray *)arr{
    CGFloat allHeight = 0;
    [_arrLabel enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    for (int i = 0; i < arr.count; i ++){
        NSString *name = arr[i];
        static UILabel *recordlabel =nil;
        
        UILabel *lbl = [[UILabel alloc]init];
        lbl.font = [UIFont systemFontOfSize:10];
        lbl.textColor = kSS333333;
        lbl.textColor = kSS333333;
        lbl.text = name;
        
        CGRect rect = [name boundingRectWithSize:CGSizeMake(kSSFlowLabelViewWdith -(SSFlowLabelViewLabelMargin * 2), SSFlowLabelViewLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:lbl.font} context:nil];
        
        CGFloat BtnW = rect.size.width+SSFlowLabelViewLabelPadding;
        BtnW = BtnW>(kSSFlowLabelViewWdith - (SSFlowLabelViewLabelMargin *2))?(kSSFlowLabelViewWdith - (SSFlowLabelViewLabelMargin *2)):BtnW;
        
        CGFloat BtnH = SSFlowLabelViewLabelHeight;
        if (i == 0){
            lbl.frame =CGRectMake(SSFlowLabelViewLabelMargin, allHeight, BtnW, BtnH);
        }else{
            //算出剩下的宽度
            CGFloat yuWidth = kSSFlowLabelViewWdith - (SSFlowLabelViewLabelMargin*2) -recordlabel.frame.origin.x -recordlabel.frame.size.width;
            if (yuWidth >= BtnW) {
                //如果大于就放在同一行
                lbl.frame =CGRectMake(recordlabel.frame.origin.x +recordlabel.frame.size.width + SSFlowLabelViewLabelMargin, recordlabel.frame.origin.y, BtnW, BtnH);
            }else{
                //如果不够就换行
                lbl.frame =CGRectMake(SSFlowLabelViewLabelMargin, recordlabel.frame.origin.y+recordlabel.frame.size.height+SSFlowLabelViewLabelMargin, BtnW, BtnH);
            }
        }
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.borderWidth = 0.5;
        lbl.borderColor = [UIColor colorWithHexString:@"dddddd"];
        [self addSubview:lbl];
        [_arrLabel addObject:lbl];
        self.frame = CGRectMake(self.x , self.y, kSSFlowLabelViewWdith ,CGRectGetMaxY(lbl.frame)+SSFlowLabelViewLabelMargin);
        recordlabel = lbl;
    }
}

+ (CGFloat)getCustomMEFlowLabelViewHeightWithArr:(NSArray *)arr wdith:(CGFloat)wdith LabelViewLabelHeight:(CGFloat)LabelViewLabelHeight font:(UIFont *)font{
    CGFloat height = 0;
    
    if(kMeUnArr(arr).count){
        for (int i = 0; i < arr.count; i ++){
            NSString *name = arr[i];
            static UILabel *recordlabel =nil;
            
            UILabel *lbl = [[UILabel alloc]init];
            lbl.font = font;
            
            CGRect rect = [name boundingRectWithSize:CGSizeMake(wdith -(SSFlowLabelViewLabelMargin * 2), LabelViewLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:lbl.font} context:nil];
            
            CGFloat BtnW = rect.size.width+SSFlowLabelViewLabelPadding;
            BtnW = BtnW>(wdith - (SSFlowLabelViewLabelMargin *2))?(wdith - (SSFlowLabelViewLabelMargin *2)):BtnW;
            
            CGFloat BtnH = LabelViewLabelHeight;
            if (i == 0){
                lbl.frame =CGRectMake(SSFlowLabelViewLabelMargin, 0, BtnW, BtnH);
            }else{
                //算出剩下的宽度
                CGFloat yuWidth = wdith - (SSFlowLabelViewLabelMargin*2) -recordlabel.frame.origin.x -recordlabel.frame.size.width;
                if (yuWidth >= BtnW) {
                    //如果大于就放在同一行
                    lbl.frame =CGRectMake(recordlabel.frame.origin.x +recordlabel.frame.size.width + SSFlowLabelViewLabelMargin, recordlabel.frame.origin.y, BtnW, BtnH);
                }else{
                    //如果不够就换行
                    lbl.frame =CGRectMake(SSFlowLabelViewLabelMargin, recordlabel.frame.origin.y+recordlabel.frame.size.height+SSFlowLabelViewLabelMargin, BtnW, BtnH);
                }
            }
            height = CGRectGetMaxY(lbl.frame)+SSFlowLabelViewLabelMargin;
            recordlabel = lbl;
        }
    }
    return height;
    
}
- (void)reloaCustomWithArr:(NSArray *)arr font:(UIFont *)font textColor:(UIColor *)textColor backGroundColor:(UIColor *)backGroundColor{
    [_arrLabel enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    CGFloat allHeight = 0;
    for (int i = 0; i < arr.count; i ++){
        NSString *name = arr[i];
        static UILabel *recordlabel =nil;
        
        UILabel *lbl = [[UILabel alloc]init];
        lbl.backgroundColor = backGroundColor;
        lbl.font = font;
        lbl.textColor = textColor;
        lbl.text = name;
        
        CGRect rect = [name boundingRectWithSize:CGSizeMake(self.flowLabelViewWdith -(SSFlowLabelViewLabelMargin * 2), self.flowLabelViewLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:lbl.font} context:nil];
        
        CGFloat BtnW = rect.size.width+SSFlowLabelViewLabelPadding;
        BtnW = BtnW>(self.flowLabelViewWdith - (SSFlowLabelViewLabelMargin *2))?(self.flowLabelViewWdith - (SSFlowLabelViewLabelMargin *2)):BtnW;
        
        CGFloat BtnH = self.flowLabelViewLabelHeight;
        if (i == 0){
            lbl.frame =CGRectMake(SSFlowLabelViewLabelMargin, allHeight, BtnW, BtnH);
        }else{
            //算出剩下的宽度
            CGFloat yuWidth = self.flowLabelViewWdith - (SSFlowLabelViewLabelMargin*2) -recordlabel.frame.origin.x -recordlabel.frame.size.width;
            if (yuWidth >= BtnW) {
                //如果大于就放在同一行
                lbl.frame =CGRectMake(recordlabel.frame.origin.x +recordlabel.frame.size.width + SSFlowLabelViewLabelMargin, recordlabel.frame.origin.y, BtnW, BtnH);
            }else{
                //如果不够就换行
                lbl.frame =CGRectMake(SSFlowLabelViewLabelMargin, recordlabel.frame.origin.y+recordlabel.frame.size.height+SSFlowLabelViewLabelMargin, BtnW, BtnH);
            }
        }
        lbl.textAlignment = NSTextAlignmentCenter;
        //        lbl.borderWidth = 0.5;
        //        lbl.borderColor = [UIColor colorWithHexString:@"dddddd"];
        [self addSubview:lbl];
        [_arrLabel addObject:lbl];
        self.frame = CGRectMake(self.x , self.y, self.flowLabelViewWdith ,CGRectGetMaxY(lbl.frame)+SSFlowLabelViewLabelMargin);
        recordlabel = lbl;
    }
}

@end
