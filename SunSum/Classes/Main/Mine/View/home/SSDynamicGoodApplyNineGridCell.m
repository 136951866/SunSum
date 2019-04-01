//
//  SSDynamicGoodApplyNineGridCell.m
//  SunSum
//
//  Created by hank on 2019/3/25.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSDynamicGoodApplyNineGridCell.h"
#import "SSBynamicPublishGridContentView.h"
#import "SSBynamicPublishGridModel.h"

@interface SSDynamicGoodApplyNineGridCell (){
    BOOL _isShow;
}

@property (nonatomic, strong) NSMutableArray *arrImageModel;

@end

@implementation SSDynamicGoodApplyNineGridCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
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
        if(_isShow){
//            NSString *model = _arrImageModel[index];
            kMeCallBlock(_selectIndexBlock,index);
        }else{
            SSBynamicPublishGridModel *model = _arrImageModel[index];
            model.selectIndex = index;
            kMeCallBlock(_selectBlock,model);
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithUrlArr:(NSMutableArray *)arrModel{
    _arrImageModel = arrModel;
    _isShow = YES;
    CGFloat w = (SCREEN_WIDTH - (kSSGridViewMagin *2) - (kSSGridViewPadding *2))/3;
    for (NSInteger i = 0; i<arrModel.count; i++) {
        if(i>=9){
            break;
        }
        NSString *model = arrModel[i];
        SSBynamicPublishGridContentView *img = _arrImageView[i];
        [img setUIWIthUrl:model];
        NSInteger row = i/3;//行
        NSInteger col = i%3;//列
        CGFloat picX = ((w + kSSGridViewPadding) * col)+kSSGridViewMagin;
        CGFloat picY =((w + kSSGridViewPadding) * row) +kSSGridViewPadding +48;
        img.frame = CGRectMake(picX, picY, w, w);
        [self addSubview:img];
    }
}

- (void)setUIWithArr:(NSMutableArray *)arrModel{
    for (UIImageView *img in _arrImageView) {
        [img removeFromSuperview];
    }
    _isShow = NO;

    _arrImageModel = arrModel;
    CGFloat w = (SCREEN_WIDTH - (kSSGridViewMagin *2) - (kSSGridViewPadding *2))/3;
    kMeWEAKSELF
    for (NSInteger i = 0; i<arrModel.count; i++) {
        if(i>=9){
            break;
        }
        SSBynamicPublishGridModel *model = arrModel[i];
        SSBynamicPublishGridContentView *img = _arrImageView[i];
        img.block = ^{
            kMeSTRONGSELF
            kMeCallBlock(strongSelf.delBlock,i);
        };
        [img setUIWithModel:model];
        NSInteger row = i/3;//行
        NSInteger col = i%3;//列
        CGFloat picX = ((w + kSSGridViewPadding) * col)+kSSGridViewMagin;
        CGFloat picY =((w + kSSGridViewPadding) * row) +kSSGridViewPadding +48;
        img.frame = CGRectMake(picX, picY, w, w);
        [self addSubview:img];
    }
}

+ (CGFloat)getCellHeightWithArr:(NSMutableArray *)arrModel{
    CGFloat height = 58;
    CGFloat cellheight = (SCREEN_WIDTH - (kSSGridViewMagin *2) - (kSSGridViewPadding *2))/3;
    switch (kMeUnArr(arrModel).count) {
        case 0:
            height = 48;
        case 1:case 2:case 3:{
            height +=(cellheight+(kSSGridViewPadding *2));
        }
            break;
        case 4:case 5:case 6:{
            height +=((cellheight*2)+(kSSGridViewPadding *3));
        }
            break;
        default:{
            height +=((cellheight*3)+(kSSGridViewPadding *4));
        }
            break;
    }
    return height;
}
@end
