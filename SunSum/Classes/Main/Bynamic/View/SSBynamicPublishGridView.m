//
//  SSBynamicPublishGridView.m
//  SunSum
//
//  Created by hank on 2019/3/7.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBynamicPublishGridView.h"
#import "SSBynamicPublishGridModel.h"
#import "SSBynamicPublishGridContentView.h"


@interface SSBynamicPublishGridView (){
    NSArray *_arrModel;
    
}

@end

@implementation SSBynamicPublishGridView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setImageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setImageView];
    }
    return self;
}


- (void)setImageView{
    _arrImageView = [NSMutableArray array];
    for (NSInteger i=0; i<9; i++) {
        SSBynamicPublishGridContentView *img = [[SSBynamicPublishGridContentView alloc]init];
        img.userInteractionEnabled = YES;
        img.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [img addGestureRecognizer:tap];
        [_arrImageView addObject:img];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    UIImageView *view = (UIImageView *)tap.view;
    NSInteger index = view.tag;
    if(index>=0 && index<=8){
        SSBynamicPublishGridModel *model = _arrModel[index];
        model.selectIndex = index;
        kMeCallBlock(_selectBlock,model);
    }
}

- (void)setUIWithArr:(NSArray *)arr{
    for (UIImageView *img in self.subviews) {
        [img removeFromSuperview];
    }
    self.height = [SSBynamicPublishGridView getViewHeightWIth:arr];
    _arrModel = arr;
    CGFloat w = (SCREEN_WIDTH - (kSSBynamicPublishGridViewMagin *2) - (kSSBynamicPublishGridViewPadding *2))/3;
    kMeWEAKSELF
    for (NSInteger i = 0; i<arr.count; i++) {
        if(i>=9){
            break;
        }
        SSBynamicPublishGridModel *model = arr[i];
        SSBynamicPublishGridContentView *img = _arrImageView[i];
        img.block = ^{
            kMeSTRONGSELF
            kMeCallBlock(strongSelf.delBlock,i);
        };
        [img setUIWithModel:model];
        NSInteger row = i/3;//行
        NSInteger col = i%3;//列
        CGFloat picX = ((w + kSSBynamicPublishGridViewPadding) * col)+kSSBynamicPublishGridViewMagin;
        CGFloat picY =((w + kSSBynamicPublishGridViewPadding) * row) +kSSBynamicPublishGridViewPadding;
        img.frame = CGRectMake(picX, picY, w, w);
        [self addSubview:img];
    }
}

+ (CGFloat)getViewHeightWIth:(NSArray *)arr{
    CGFloat height = 0;
    CGFloat cellheight = (SCREEN_WIDTH - (kSSBynamicPublishGridViewMagin *2) - (kSSBynamicPublishGridViewPadding *2))/3;
    switch (kMeUnArr(arr).count) {
        case 0:
            height = 0;
        case 1:case 2:case 3:{
            height +=(cellheight+(kSSBynamicPublishGridViewPadding *2));
        }
            break;
        case 4:case 5:case 6:{
            height +=((cellheight*2)+(kSSBynamicPublishGridViewPadding *3));
        }
            break;
        default:{
            height +=((cellheight*3)+(kSSBynamicPublishGridViewPadding *4));
        }
            break;
    }
    return height;
}

@end
