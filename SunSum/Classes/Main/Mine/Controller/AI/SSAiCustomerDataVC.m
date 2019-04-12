//
//  SSAiCustomerDataVC.m
//  SS时代
//
//  Created by hank on 2019/4/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAiCustomerDataVC.h"
#import "SSAiCustomerDataView.h"
#import "SSAiCustomerDataModel.h"

@interface SSAiCustomerDataVC ()<UIScrollViewDelegate>{
    NSString *_userId;
}

@property (nonatomic, strong) SSAiCustomerDataView *cview;
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) SSAiCustomerDataModel *model;

@end

@implementation SSAiCustomerDataVC

- (instancetype)initWithUserId:(NSString *)userId{
    if(self = [super init]){
        _userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客户资料";
    self.model = [SSAiCustomerDataModel new];
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetCustomerDetailWithUid:_userId SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        if([responseObject.data isKindOfClass:[NSDictionary class]]){
            strongSelf.model = [SSAiCustomerDataModel mj_objectWithKeyValues:responseObject.data];
        }
        [strongSelf.view addSubview:strongSelf.scrollerView];
        [strongSelf.scrollerView addSubview:strongSelf.cview];
        [strongSelf.cview reloadUI];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)updataCustomerData{
    self.model.token = kMeUnNilStr(kCurrentUser.token);
    self.model.uid = kMeUnNilStr(_userId);
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetCustomerDetailWithModel:self.model SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(id object) {
        
    }];
}

- (UIScrollView *)scrollerView{
    if(!_scrollerView){
        _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight)];
        _scrollerView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _scrollerView.backgroundColor = [UIColor whiteColor];
        _scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, kSSAiCustomerDataViewHeight);
        _scrollerView.bounces = YES;
        _scrollerView.showsVerticalScrollIndicator =NO;
        _scrollerView.delegate = self;
    }
    return _scrollerView;
}

- (SSAiCustomerDataView *)cview{
    if(!_cview){
        _cview = [[[NSBundle mainBundle]loadNibNamed:@"SSAiCustomerDataView" owner:nil options:nil] lastObject];
        _cview.frame = CGRectMake(0, 0, SCREEN_WIDTH, kSSAiCustomerDataViewHeight);
        _cview.model = self.model;
        kMeWEAKSELF
        _cview.saveBlock = ^{
            kMeSTRONGSELF
            [strongSelf updataCustomerData];
        };
    }
    return _cview;
}


@end
