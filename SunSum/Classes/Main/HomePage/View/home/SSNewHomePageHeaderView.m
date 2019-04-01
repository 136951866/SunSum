//
//  SSNewHomePageHeaderView.m
//  SunSum
//
//  Created by hank on 2018/11/5.
//  Copyright © 2018年 hank. All rights reserved.
//  

#import "SSNewHomePageHeaderView.h"
#import "SSAdModel.h"
#import "SSMidelButton.h"
#import "SSProductSearchVC.h"
#import "SSNewHomePage.h"
#import "SSFilterVC.h"
//#import "SSNoticeVC.h"
#import "SSNoticeTypeVC.h"
#import "SSRCConversationListVC.h"

@interface SSNewHomePageHeaderView ()<JXCategoryViewDelegate>{
    NSArray *_arrModel;
    UIButton *_oldBtn;
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

//@property (weak, nonatomic) IBOutlet JXCategoryTitleView *categoryView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@end
@implementation SSNewHomePageHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
//    self.categoryView.lineStyle = JXCategoryLineStyle_None;
//    self.categoryView.titles = @[@"推荐",@"活动",@"产品",@"服务"];
//    self.categoryView.delegate = self;
//    self.categoryView.titleSelectedColor = kSSPink;
    [_arrBtn enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = kMeViewBaseTag + idx;

    }];
    _oldBtn = _arrBtn[0];
    _oldBtn.selected = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchAction:)];
    _searchView.userInteractionEnabled = YES;
    [_searchView addGestureRecognizer:ges];
//    [_btnBack setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
}

- (void)returnCommon{
    _oldBtn.selected = NO;
    _oldBtn = _arrBtn[0];
     _lineView.centerX = _oldBtn.centerX;
    _oldBtn.selected = YES;
//    self.categoryView.defaultSelectedIndex = 0;
//    [self.categoryView reloadDatas];
//    [self.categoryView selectItemWithIndex:0];
//    [self.categoryView reloadDatas];
}

//- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
//    kMeCallBlock(_selectMemuBlock,index);
//    NSLog(@"%@",@(index));
//}

- (IBAction)selectAction:(UIButton *)sender {
    _oldBtn.selected = NO;
    sender.selected = YES;
    _oldBtn = sender;
    NSInteger tag = sender.tag-kMeViewBaseTag;
    _lineView.centerX = sender.centerX;
    kMeCallBlock(_selectMemuBlock,tag);
}


- (void)searchAction:(UITapGestureRecognizer *)ges{
    SSNewHomePage *home = (SSNewHomePage *)[SSCommonTool getVCWithClassWtihClassName:[SSNewHomePage class] targetResponderView:self];
    if(home){
        SSProductSearchVC *svc = [[SSProductSearchVC alloc]init];
        [home.navigationController pushViewController:svc animated:NO];
    }

}

- (IBAction)messageAction:(UIButton *)sender {
    SSNewHomePage *home = (SSNewHomePage *)[SSCommonTool getVCWithClassWtihClassName:[SSNewHomePage class] targetResponderView:self];
    if(home){
        [home.navigationController popViewControllerAnimated:YES];
    }
//    if([SSUserInfoModel isLogin]){
//        [self toChat];
//    }else{
//        kMeWEAKSELF
//        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
//            kMeSTRONGSELF
//            [strongSelf toChat];
//        } failHandler:nil];
//    }
}

- (void)toChat{
    SSNewHomePage *home = (SSNewHomePage *)[SSCommonTool getVCWithClassWtihClassName:[SSNewHomePage class] targetResponderView:self];
    if([kCurrentUser.mobile isEqualToString:AppstorePhone]){
        SSRCConversationListVC *svc = [[SSRCConversationListVC alloc]init];
        [home.navigationController pushViewController:svc animated:YES];
    }else{
        if(home){
            SSNoticeTypeVC *svc = [[SSNoticeTypeVC alloc]init];
            [home.navigationController pushViewController:svc animated:YES];
        }
    }
}

- (IBAction)filterAction:(SSMidelBigImageButton *)sender {
    SSNewHomePage *home = (SSNewHomePage *)[SSCommonTool getVCWithClassWtihClassName:[SSNewHomePage class] targetResponderView:self];
    if(home){
        SSFilterVC *svc = [[SSFilterVC alloc]init];
        [home.navigationController pushViewController:svc animated:YES];
    }

}


@end
