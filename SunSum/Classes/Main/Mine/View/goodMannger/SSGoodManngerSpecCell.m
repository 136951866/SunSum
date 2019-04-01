//
//  SSGoodManngerSpecCell.m
//  SunSum
//
//  Created by hank on 2019/3/28.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSGoodManngerSpecCell.h"
#import "SSGoodManngerGoodSpec.h"

const static CGFloat SSGoodManngerSpecCellHeight = 27;
const static CGFloat SSGoodManngerSpecCellMargin = 10;
const static CGFloat SSGoodManngerSpecCellPadding = 30;

#define kSSGoodManngerSpecCellWdith (SCREEN_WIDTH - 30)
#define kSSGoodManngerSpecCellTitleFont kMeFont(15)

@interface SSGoodManngerSpecCell(){
    NSMutableArray *_arrBtn;
    NSMutableArray *_arrModel;
}

@end

@implementation SSGoodManngerSpecCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _arrBtn = [NSMutableArray array];
}

- (void)setUIWihtArr:(NSArray *)arr{
    CGFloat allHeight = SSGoodManngerSpecCellMargin;
    _arrModel = [NSMutableArray arrayWithArray:arr];
    for (int i = 0; i < arr.count; i ++){
        SSGoodManngerGoodSpec *modelSpec = arr[i];
        static UIButton *recordbtn =nil;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = kSSGoodManngerSpecCellTitleFont;
        btn.titleLabel.textColor = kSS333333;
        NSString *name = kMeUnNilStr(modelSpec.spec_name);
        [btn setTitle:name forState:UIControlStateNormal];
        CGRect rect = [name boundingRectWithSize:CGSizeMake(kSSGoodManngerSpecCellWdith -(SSGoodManngerSpecCellMargin * 2), SSGoodManngerSpecCellHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kSSGoodManngerSpecCellTitleFont} context:nil];
        
        CGFloat BtnW = rect.size.width+SSGoodManngerSpecCellPadding;
        BtnW = BtnW>(kSSGoodManngerSpecCellWdith - (SSGoodManngerSpecCellMargin *2))?(kSSGoodManngerSpecCellWdith - (SSGoodManngerSpecCellMargin *2)):BtnW;
        
        CGFloat BtnH = SSGoodManngerSpecCellHeight;
        if (i == 0){
            btn.frame =CGRectMake(SSGoodManngerSpecCellMargin, allHeight, BtnW, BtnH);
        }else{
            //算出剩下的宽度
            CGFloat yuWidth = kSSGoodManngerSpecCellWdith - (SSGoodManngerSpecCellMargin*2) -recordbtn.frame.origin.x -recordbtn.frame.size.width;
            if (yuWidth >= BtnW) {
                //如果大于就放在同一行
                btn.frame =CGRectMake(recordbtn.frame.origin.x +recordbtn.frame.size.width + SSGoodManngerSpecCellMargin, recordbtn.frame.origin.y, BtnW, BtnH);
            }else{
                //如果不够就换行
                btn.frame =CGRectMake(SSGoodManngerSpecCellMargin, recordbtn.frame.origin.y+recordbtn.frame.size.height+SSGoodManngerSpecCellMargin, BtnW, BtnH);
            }
        }
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = kMeViewBaseTag+i;
        [btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.borderWidth = 0.5;
        btn.cornerRadius = SSGoodManngerSpecCellHeight/2;
        btn .clipsToBounds = YES;
        if(modelSpec.isSelect){
            btn.borderColor = kSSPink;
            [btn setTitleColor:kSS333333 forState:UIControlStateNormal];
        }else{
            btn.borderColor = kSS999999;
            [btn setTitleColor:kSS999999 forState:UIControlStateNormal];
        }
        [self addSubview:btn];
        [_arrBtn addObject:btn];
        recordbtn = btn;
    }
}

- (void)tapAction:(UIButton *)btn{
    NSInteger index = btn.tag - kMeViewBaseTag;
    SSGoodManngerGoodSpec *modelSpec = _arrModel[index];
    modelSpec.isSelect = !modelSpec.isSelect;
    if(modelSpec.isSelect){
        btn.borderColor = kSSPink;
        [btn setTitleColor:kSS333333 forState:UIControlStateNormal];
        kMeCallBlock(_addBlock,modelSpec);

    }else{
        btn.borderColor = kSS999999;
        [btn setTitleColor:kSS999999 forState:UIControlStateNormal];
        kMeCallBlock(_divBlock,modelSpec);
    }
//    NSMutableArray *arr = [NSMutableArray array];
//    [_arrModel enumerateObjectsUsingBlock:^(SSGoodManngerGoodSpec *model, NSUInteger idx, BOOL * _Nonnull stop) {
//        if(model.isSelect){
//            [arr addObject:model];
//        }
//    }];
}

+ (CGFloat)getCellHeightWithArr:(NSArray *)arr{
    CGFloat height = SSGoodManngerSpecCellMargin;
    if(kMeUnArr(arr).count){
        for (int i = 0; i < arr.count; i ++){
            SSGoodManngerGoodSpec *modelSpec = arr[i];
            static UIButton *recordbtn =nil;

            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString *name = kMeUnNilStr(modelSpec.spec_name);

        CGRect rect = [name boundingRectWithSize:CGSizeMake(kSSGoodManngerSpecCellWdith -(SSGoodManngerSpecCellMargin * 2), SSGoodManngerSpecCellHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kSSGoodManngerSpecCellTitleFont} context:nil];
            
            CGFloat BtnW = rect.size.width+SSGoodManngerSpecCellPadding;
            BtnW = BtnW>(kSSGoodManngerSpecCellWdith - (SSGoodManngerSpecCellMargin *2))?(kSSGoodManngerSpecCellWdith - (SSGoodManngerSpecCellMargin *2)):BtnW;
            
            CGFloat BtnH = SSGoodManngerSpecCellHeight;
            if (i == 0){
             btn.frame =CGRectMake(SSGoodManngerSpecCellMargin, height, BtnW, BtnH);
            }else{
                //算出剩下的宽度
                CGFloat yuWidth = kSSGoodManngerSpecCellWdith - (SSGoodManngerSpecCellMargin*2) -recordbtn.frame.origin.x -recordbtn.frame.size.width;
                if (yuWidth >= BtnW) {
                    //如果大于就放在同一行
                    btn.frame =CGRectMake(recordbtn.frame.origin.x +recordbtn.frame.size.width + SSGoodManngerSpecCellMargin, recordbtn.frame.origin.y, BtnW, BtnH);
                }else{
                    //如果不够就换行
                    btn.frame =CGRectMake(SSGoodManngerSpecCellMargin, recordbtn.frame.origin.y+recordbtn.frame.size.height+SSGoodManngerSpecCellMargin, BtnW, BtnH);
                }
            }
            height = CGRectGetMaxY(btn.frame)+SSGoodManngerSpecCellMargin;
            recordbtn = btn;
        }
    }
    return height;
}

@end
