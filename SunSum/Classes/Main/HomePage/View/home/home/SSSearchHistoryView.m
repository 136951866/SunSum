//
//  SSSearchHistoryView.m
//  SunSum
//
//  Created by hank on 2018/10/31.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSSearchHistoryView.h"
#import "SSSearchHistoryModel.h"

const static CGFloat kSSSearchHistoryViewMagin = 7;
const static CGFloat kSSSearchHistoryViewTitleHeight = 22;
const static CGFloat kSSSearchHistoryViewSelectHeight = 30;

const static CGFloat KTapTag = 1000;

@interface SSSearchHistoryView(){
    NSMutableArray *_arrBtn;
}

@property (nonatomic, strong) UILabel *lblTite;
@property (nonatomic, strong) UIImageView *imgDel;
@property (nonatomic, strong) UIButton *btnDel;

@end

@implementation SSSearchHistoryView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _arrBtn = [NSMutableArray array];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.lblTite];
    [self addSubview:self.imgDel];
    [self addSubview:self.btnDel];
}
- (void)reloaStoredData{
    [_arrBtn enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [_arrBtn removeAllObjects];
    NSArray *arrHistory = [SSSearchHistoryModel arrSearchStoreHistory];
    CGFloat allHeight = (kSSSearchHistoryViewMagin *2) +kSSSearchHistoryViewTitleHeight;
    for (int i = 0; i < arrHistory.count; i ++){
        NSString *name = arrHistory[i];
        static UIButton *recordBtn =nil;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        CGRect rect = [name boundingRectWithSize:CGSizeMake(self.frame.size.width -(kSSSearchHistoryViewMagin * 2), kSSSearchHistoryViewSelectHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
        CGFloat BtnW = rect.size.width>80?(rect.size.width+30):80;
        BtnW = BtnW>(SCREEN_WIDTH - (kSSSearchHistoryViewMagin *2))?(SCREEN_WIDTH - (kSSSearchHistoryViewMagin *2)):BtnW;
        CGFloat BtnH = kSSSearchHistoryViewSelectHeight;
        if (i == 0){
            btn.frame =CGRectMake(kSSSearchHistoryViewMagin, allHeight, BtnW, BtnH);
        }else{
            //算出剩下的宽度
            CGFloat yuWidth = self.frame.size.width - (kSSSearchHistoryViewMagin*2) -recordBtn.frame.origin.x -recordBtn.frame.size.width;
            if (yuWidth >= BtnW) {
                //如果大于就放在同一行
                btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + kSSSearchHistoryViewMagin, recordBtn.frame.origin.y, BtnW, BtnH);
            }else{
                //如果不够就换行
                btn.frame =CGRectMake(kSSSearchHistoryViewMagin, recordBtn.frame.origin.y+recordBtn.frame.size.height+kSSSearchHistoryViewMagin, BtnW, BtnH);
            }
        }
        btn.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [btn setTitle:name forState:UIControlStateNormal];
        [btn setTitleColor:kSSblack forState:UIControlStateNormal];
        [self addSubview:btn];
        [_arrBtn addObject:btn];
        NSLog(@"btn.frame.origin.y  %f", btn.frame.origin.y);
        self.frame = CGRectMake(self.x , self.y, [UIScreen mainScreen].bounds.size.width ,CGRectGetMaxY(btn.frame)+kSSSearchHistoryViewMagin);
        recordBtn = btn;
        btn.tag = KTapTag + i;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)reloadData{
    [_arrBtn enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [_arrBtn removeAllObjects];
    NSArray *arrHistory = [SSSearchHistoryModel arrSearchHistory];
    CGFloat allHeight = (kSSSearchHistoryViewMagin *2) +kSSSearchHistoryViewTitleHeight;
    for (int i = 0; i < arrHistory.count; i ++){
        NSString *name = arrHistory[i];
        static UIButton *recordBtn =nil;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        CGRect rect = [name boundingRectWithSize:CGSizeMake(self.frame.size.width -(kSSSearchHistoryViewMagin * 2), kSSSearchHistoryViewSelectHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
        CGFloat BtnW = rect.size.width>80?(rect.size.width+30):80;
        BtnW = BtnW>(SCREEN_WIDTH - (kSSSearchHistoryViewMagin *2))?(SCREEN_WIDTH - (kSSSearchHistoryViewMagin *2)):BtnW;
        CGFloat BtnH = kSSSearchHistoryViewSelectHeight;
        if (i == 0){
            btn.frame =CGRectMake(kSSSearchHistoryViewMagin, allHeight, BtnW, BtnH);
        }else{
            //算出剩下的宽度
            CGFloat yuWidth = self.frame.size.width - (kSSSearchHistoryViewMagin*2) -recordBtn.frame.origin.x -recordBtn.frame.size.width;
            if (yuWidth >= BtnW) {
                //如果大于就放在同一行
                btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + kSSSearchHistoryViewMagin, recordBtn.frame.origin.y, BtnW, BtnH);
            }else{
                //如果不够就换行
                btn.frame =CGRectMake(kSSSearchHistoryViewMagin, recordBtn.frame.origin.y+recordBtn.frame.size.height+kSSSearchHistoryViewMagin, BtnW, BtnH);
            }
        }
        btn.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [btn setTitle:name forState:UIControlStateNormal];
        [btn setTitleColor:kSSblack forState:UIControlStateNormal];
        [self addSubview:btn];
        [_arrBtn addObject:btn];
        NSLog(@"btn.frame.origin.y  %f", btn.frame.origin.y);
        self.frame = CGRectMake(self.x , self.y, [UIScreen mainScreen].bounds.size.width ,CGRectGetMaxY(btn.frame)+kSSSearchHistoryViewMagin);
        recordBtn = btn;
        btn.tag = KTapTag + i;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)BtnClick:(UIButton *)sender{
    kMeCallBlock(self.selectBlock,sender.titleLabel.text);
}

- (void)handleTapAction:(UITapGestureRecognizer *)tap{
    if(![tap.view isKindOfClass:[UILabel class]]){
        return;
    }
    UILabel *lblSelect = (UILabel *)tap.view;
    kMeCallBlock(self.selectBlock,lblSelect.text);
}

- (void)delAction:(UIButton *)btn{
    SSAlertView *aler = [[SSAlertView alloc] initWithTitle:@"" message:@"确定删除历史记录?"];
    kMeWEAKSELF
    [aler addButtonWithTitle:@"确定" block:^{
        kMeSTRONGSELF
        kMeCallBlock(strongSelf->_delBlock);
    }];
    [aler addButtonWithTitle:@"取消"];
    [aler show];
}

- (UILabel *)lblTite{
    if(!_lblTite){
        _lblTite = [SSView lblWithFram:CGRectMake(kSSSearchHistoryViewMagin, kSSSearchHistoryViewMagin, 58, kSSSearchHistoryViewTitleHeight) textColor:kSSblack str:@"最近搜索" font:[UIFont systemFontOfSize:14]];
    }
    return _lblTite;
}

- (UIImageView *)imgDel{
    if(!_imgDel){
        _imgDel = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 10, 15, 16)];
        _imgDel.image = kMeGetAssetImage(@"icon-mmbw");
    }
    return _imgDel;
}

- (UIButton *)btnDel{
    if(!_btnDel){
        _btnDel = [SSView btnWithFrame:CGRectMake(SCREEN_WIDTH - 100, 0, 100, 30) Img:nil title:@""];
        [_btnDel addTarget:self action:@selector(delAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDel;
}

+ (BOOL)hasHStoreIstory{
    NSArray *arrHistory = [SSSearchHistoryModel arrSearchStoreHistory];
    return [arrHistory count];
}

+ (CGFloat)getStoreViewHeight{
    NSArray *arrHistory = [SSSearchHistoryModel arrSearchStoreHistory];
    CGFloat allHeight = (kSSSearchHistoryViewMagin *2) +kSSSearchHistoryViewTitleHeight;
    
    for (int i = 0; i < arrHistory.count; i ++){
        NSString *name = arrHistory[i];
        static UIButton *recordBtn =nil;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        CGRect rect = [name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -(kSSSearchHistoryViewMagin * 2), kSSSearchHistoryViewSelectHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
        CGFloat BtnW = rect.size.width>80?(rect.size.width+30):80;
        BtnW = BtnW>(SCREEN_WIDTH - (kSSSearchHistoryViewMagin *2))?(SCREEN_WIDTH - (kSSSearchHistoryViewMagin *2)):BtnW;
        CGFloat BtnH = kSSSearchHistoryViewSelectHeight;//rect.size.height + 10;
        if (i == 0){
            btn.frame =CGRectMake(kSSSearchHistoryViewMagin, allHeight, BtnW, BtnH);
        }else{
            CGFloat yuWidth = SCREEN_WIDTH - (kSSSearchHistoryViewMagin*2) -recordBtn.frame.origin.x -recordBtn.frame.size.width;
            if (yuWidth >= BtnW) {
                btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + kSSSearchHistoryViewMagin, recordBtn.frame.origin.y, BtnW, BtnH);
            }else{
                btn.frame =CGRectMake(kSSSearchHistoryViewMagin, recordBtn.frame.origin.y+recordBtn.frame.size.height+kSSSearchHistoryViewMagin, BtnW, BtnH);
            }
            
        }
        allHeight = CGRectGetMaxY(btn.frame)+kSSSearchHistoryViewMagin;
        recordBtn = btn;
    }
    return allHeight;
}

+ (BOOL)hasHIstory{
    NSArray *arrHistory = [SSSearchHistoryModel arrSearchHistory];
    return [arrHistory count];
}

+ (CGFloat)getViewHeight{
    NSArray *arrHistory = [SSSearchHistoryModel arrSearchHistory];
    CGFloat allHeight = (kSSSearchHistoryViewMagin *2) +kSSSearchHistoryViewTitleHeight;
    
    for (int i = 0; i < arrHistory.count; i ++){
        NSString *name = arrHistory[i];
        static UIButton *recordBtn =nil;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        CGRect rect = [name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -(kSSSearchHistoryViewMagin * 2), kSSSearchHistoryViewSelectHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
        CGFloat BtnW = rect.size.width>80?(rect.size.width+30):80;
        BtnW = BtnW>(SCREEN_WIDTH - (kSSSearchHistoryViewMagin *2))?(SCREEN_WIDTH - (kSSSearchHistoryViewMagin *2)):BtnW;
        CGFloat BtnH = kSSSearchHistoryViewSelectHeight;//rect.size.height + 10;
        if (i == 0){
            btn.frame =CGRectMake(kSSSearchHistoryViewMagin, allHeight, BtnW, BtnH);
        }else{
            CGFloat yuWidth = SCREEN_WIDTH - (kSSSearchHistoryViewMagin*2) -recordBtn.frame.origin.x -recordBtn.frame.size.width;
            if (yuWidth >= BtnW) {
                btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + kSSSearchHistoryViewMagin, recordBtn.frame.origin.y, BtnW, BtnH);
            }else{
                btn.frame =CGRectMake(kSSSearchHistoryViewMagin, recordBtn.frame.origin.y+recordBtn.frame.size.height+kSSSearchHistoryViewMagin, BtnW, BtnH);
            }
            
        }
        allHeight = CGRectGetMaxY(btn.frame)+kSSSearchHistoryViewMagin;
        recordBtn = btn;
    }
    return allHeight;
}

@end
