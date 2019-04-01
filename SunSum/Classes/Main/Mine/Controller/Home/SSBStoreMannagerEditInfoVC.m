//
//  SSBStoreMannagerEditInfoVC.m
//  SunSum
//
//  Created by hank on 2019/2/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBStoreMannagerEditInfoVC.h"
#import "SSBStoreMannagerInfoModel.h"

@interface SSBStoreMannagerEditInfoVC (){
    
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;
@property (weak, nonatomic) IBOutlet UITextField *tfContent;
@property (strong , nonatomic) SSBStoreMannagercontentInfoModel *model;
@property (nonatomic, strong) UIButton *btnRight;
@end

@implementation SSBStoreMannagerEditInfoVC

- (instancetype)initWithContent:(SSBStoreMannagercontentInfoModel*)model{
    if(self = [super init]){
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑";
    _consTopMargin.constant = kMeNavBarHeight+35;
    _tfContent.text = kMeUnNilStr(self.model.subTitle);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnRight];
}

- (void)saveInfo:(UIButton *)btn{
    if(self.model.type == SSBStoreMannagerInfoStoreTelType){
        if(!kMeUnNilStr(_tfContent.text).length){
            [SSShowViewTool showMessage:@"手机号不能为空" view:kMeCurrentWindow];
            return;
        }
        if(![SSCommonTool isValidPhoneNum:kMeUnNilStr(_tfContent.text)]){
            [SSShowViewTool showMessage:@"请填写正确的手机号码" view:kMeCurrentWindow];
            return;
        }
    }
    self.model.subTitle = kMeUnNilStr(_tfContent.text);
    kMeCallBlock(_contenBlock,kMeUnNilStr(_tfContent.text));
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter
- (UIButton *)btnRight{
    if(!_btnRight){
        _btnRight= [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRight setTitle:@"确定" forState:UIControlStateNormal];
        [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnRight.backgroundColor = kSSPink;
        _btnRight.cornerRadius = 2;
        _btnRight.clipsToBounds = YES;
        _btnRight.frame = CGRectMake(0, 0, 63, 30);
        _btnRight.titleLabel.font = kMeFont(15);
        [_btnRight addTarget:self action:@selector(saveInfo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}


@end
