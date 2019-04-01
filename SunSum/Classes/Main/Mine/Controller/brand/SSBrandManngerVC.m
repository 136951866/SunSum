//
//  SSBrandManngerVC.m
//  SunSum
//
//  Created by hank on 2019/3/8.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBrandManngerVC.h"
#import "SSBrandManngerAllContentVC.h"
#import "SSBrandAISortVC.h"
#import "SSBrandMangerSortVC.h"
#import "SSBrandManngerAllModel.h"

@interface SSBrandManngerVC ()<UIScrollViewDelegate>{
    // 0 all 1 sort 2ai
    NSInteger _selectIndex;
    UIButton *_selectBtn;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong , nonatomic) SSBrandManngerAllContentVC *allVC;
@property (strong , nonatomic) SSBrandMangerSortVC *sortVC;
@property (strong , nonatomic) SSBrandAISortVC *aiSortVC;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblStoreCount;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;
@property (weak, nonatomic) IBOutlet UIButton *btnAll;
@property (weak, nonatomic) IBOutlet UIButton *btnSort;
@property (weak, nonatomic) IBOutlet UIButton *btnAi;
@property (weak, nonatomic) IBOutlet UIView *viewForBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UIView *viewForCor;

@end

@implementation SSBrandManngerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"品牌管理";
    _lblStoreCount.text =@"账号数量:0";
    _lblName.text = kMeUnNilStr(kCurrentUser.name);
    kSDLoadImg(_imgPic, kMeUnNilStr(kCurrentUser.header_pic));
    _selectBtn = _btnAll;
    _selectIndex = 0;
    _consTopMargin.constant = kMeNavBarHeight;
    _scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT-kMeNavBarHeight-kSSBrandManngerVCHeaderHeight);
    _scrollview.pagingEnabled = YES;
    [_scrollview addSubview:self.allVC.view];
    [_scrollview addSubview:self.sortVC.view];
    [_scrollview addSubview:self.aiSortVC.view];
    
    
    [_btnAll setBackgroundImage:[SSCommonTool createImageWithColor:kSSPink] forState:UIControlStateSelected];
    [_btnSort setBackgroundImage:[SSCommonTool createImageWithColor:kSSPink] forState:UIControlStateSelected];
    [_btnAi setBackgroundImage:[SSCommonTool createImageWithColor:kSSPink] forState:UIControlStateSelected];
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-15, 0, SCREEN_WIDTH+30, 89) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(60, 60)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = _viewForCor.bounds;
//    maskLayer.path = maskPath.CGPath;
//    _viewForCor.layer.mask = maskLayer;
}

- (IBAction)tapSelectAction:(UIButton *)sender {
    [self selectBtnWithBtn:sender];
}

- (void)selectBtnWithBtn:(UIButton *)btn{
    if(_selectBtn == btn){
        return;
    }
    _selectBtn.selected = NO;
    btn.selected = YES;
    _selectBtn = btn;
    _selectIndex = btn.tag-kMeViewBaseTag;
    [self.scrollview setContentOffset:CGPointMake(_selectIndex*SCREEN_WIDTH, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float sub = scrollView.contentOffset.x/SCREEN_WIDTH;
    UIButton * btn = (UIButton * )[_viewForBtn viewWithTag:kMeViewBaseTag+sub];
    if(btn && _selectBtn != btn){
        _selectBtn.selected = NO;
        btn.selected = YES;
        _selectBtn = btn;
        _selectIndex = btn.tag-kMeViewBaseTag;
    }
}

- (SSBrandManngerAllContentVC *)allVC{
    if(!_allVC){
        _allVC = [[SSBrandManngerAllContentVC alloc]init];
        _allVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _allVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kSSBrandManngerVCHeaderHeight);
        kMeWEAKSELF
        _allVC.modelBlock = ^(SSBrandMemberInfo *model) {
            kMeSTRONGSELF
            strongSelf.lblStoreCount.text = [NSString stringWithFormat:@"账号数量:%@",kMeUnNilStr(model.store_count)];
            strongSelf.lblName.text = kMeUnNilStr(model.store_name);
            kSDLoadImg(strongSelf.imgPic, kMeUnNilStr(model.header_pic));
        };
        [self addChildViewController:_allVC];
    }
    return _allVC;
}

- (SSBrandMangerSortVC *)sortVC{
    if(!_sortVC){
        _sortVC = [[SSBrandMangerSortVC alloc]init];
        _sortVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _sortVC.view.frame = CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kSSBrandManngerVCHeaderHeight);
        [self addChildViewController:_sortVC];
    }
    return _sortVC;
}

- (SSBrandAISortVC *)aiSortVC{
    if(!_aiSortVC){
        _aiSortVC = [[SSBrandAISortVC alloc]init];
        _aiSortVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _aiSortVC.view.frame = CGRectMake(SCREEN_WIDTH*2,0, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kSSBrandManngerVCHeaderHeight);
        [self addChildViewController:_aiSortVC];
    }
    return _aiSortVC;
}

@end
