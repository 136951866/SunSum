//
//  SSWithdrawalView.m
//  SunSum
//
//  Created by hank on 2018/12/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSWithdrawalView.h"
#import "SSWithdrawalTextField.h"
#import "SSWithdrawalParamModel.h"

@interface SSWithdrawalView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consBtnTopMargin;
@property (nonatomic, strong) SSWithdrawalParamModel *parModel;

@property (weak, nonatomic) IBOutlet SSWithdrawalTextField *tfName;
@property (weak, nonatomic) IBOutlet SSWithdrawalTextField *tfBankName;
@property (weak, nonatomic) IBOutlet SSWithdrawalTextField *tfBnkNo;
@property (weak, nonatomic) IBOutlet SSWithdrawalTextField *tfBankBelong;

@end

@implementation SSWithdrawalView

- (void)awakeFromNib{
    [super awakeFromNib];
    _consBtnTopMargin.constant = 125 * kMeFrameScaleX();
    kMeWEAKSELF
    _tfName.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf.parModel.true_name = str;
    };
    _tfBankName.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf.parModel.bank = str;
    };
    _tfBnkNo.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf.parModel.account = str;
    };
    _tfBankBelong.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf.parModel.branch = str;
    };
}


- (IBAction)applyAction:(UIButton *)sender {
    if(!kMeUnNilStr(self.parModel.true_name).length){
        [SSShowViewTool showMessage:@"名字不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.parModel.bank).length){
        [SSShowViewTool showMessage:@"银行名称不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.parModel.account).length){
        [SSShowViewTool showMessage:@"银行卡号不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.parModel.branch).length){
        [SSShowViewTool showMessage:@"银行支行不能为空" view:kMeCurrentWindow];
        return;
    }
    [self endEditing:YES];
    if(_isCouponMoney){
        self.parModel.order_type = @"1";
    }else{
        self.parModel.order_type = @"";
    }
    kMeWEAKSELF
    [SSPublicNetWorkTool postDestoonFinanceCashWithAttrModel:self.parModel successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        kMeCallBlock(strongSelf->_applyFinishBlock);
    } failure:^(id object) {
        
    }];
}


+ (CGFloat)getViewHeight{
    CGFloat height = 586 - 125;
    height +=(125 * kMeFrameScaleX());
    return height;
}

- (SSWithdrawalParamModel*)parModel{
    if(!_parModel){
        _parModel = [SSWithdrawalParamModel new];
        _parModel.token = kMeUnNilStr(kCurrentUser.token);
    }
    return _parModel;
}

@end
