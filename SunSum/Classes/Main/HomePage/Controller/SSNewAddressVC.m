//
//  SSNewAddressVC.m
//  SunSum
//
//  Created by hank on 2018/9/13.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSNewAddressVC.h"
#import "SSBlockTextField.h"
#import "SSBlockTextView.h"
#import "SSAddressModel.h"
#import "SSAddAddressAttrModel.h"
#import "SSAddressPickerView.h"

@interface SSNewAddressVC (){
    SSAddressModel *_model;
    BOOL _isEdit;
}
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfPhone;
@property (weak, nonatomic) IBOutlet SSBlockTextField *tfName;

@property (weak, nonatomic) IBOutlet SSBlockTextView *tvAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblTip;
@property (weak, nonatomic) IBOutlet UISwitch *sDefault;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;
@property (nonatomic, strong) UIButton *btnRight;
@property (weak, nonatomic) IBOutlet UIButton *btnDel;
@property (strong, nonatomic) SSAddAddressAttrModel *attrModel;

@property (weak, nonatomic) IBOutlet UIButton *btnCity;

//@property (copy, nonatomic) NSString *province;
//@property (copy, nonatomic) NSString *city;
//@property (copy, nonatomic) NSString *area;

@end

@implementation SSNewAddressVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kSSHexColor(@"eeeeee");
    _consTopMargin.constant = kMeNavBarHeight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnRight];
    if(_isEdit){
        self.navigationItem.title = @"编辑地址";
        _tfPhone.text = kMeUnNilStr(_model.telphone);
        _tfName.text = kMeUnNilStr(_model.truename);
        [_btnCity setTitle: [NSString stringWithFormat:@"%@%@%@",kMeUnNilStr(_model.province),kMeUnNilStr(_model.city),kMeUnNilStr(_model.district)] forState:UIControlStateNormal];
        _sDefault.on = _model.is_default;
        _tvAddress.text = kMeUnNilStr(_model.detail_address);
        _lblTip.hidden = YES;
        _attrModel = [[SSAddAddressAttrModel alloc]initWithAddressModel:_model];
    }else{
        self.navigationItem.title = @"添加收获地址";
        _sDefault.on = NO;
        _btnDel.hidden = YES;
        _attrModel = [SSAddAddressAttrModel new];
        _attrModel.token = kMeUnNilStr(kCurrentUser.token);
    }
    kMeWEAKSELF
    _tfName.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_attrModel.truename = str;
    };
    _tfPhone.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_attrModel.telphone = str;
    };
    
    _tvAddress.contentBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_lblTip.hidden = str.length != 0;
        strongSelf->_attrModel.detail_address = str;
    };
}


#pragma mark - UITableViewDelegate
 
#pragma mark - Public

- (instancetype)initWithModel:(SSAddressModel *)model{
    if(self = [super init]){
        _model = model;
        _isEdit = YES;
    }
    return self;
}

#pragma mark - Private

- (IBAction)touView:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (IBAction)delAction:(UIButton *)sender {
    SSAlertView *aler = [[SSAlertView alloc] initWithTitle:@"" message:@"确定要删除该地址吗?"];
    [aler addButtonWithTitle:@"取消"];
    kMeWEAKSELF
    [aler addButtonWithTitle:@"确定" block:^{
        kMeSTRONGSELF
        [SSPublicNetWorkTool postDelAddressWithAddressId:strongSelf->_model.address_id successBlock:^(ZLRequestResponse *responseObject) {
            kMeCallBlock(strongSelf->_reloadBlock);
        } failure:^(id object) {
            
        }];
    }];
    [aler show];
}

- (void)saveAddress:(UIButton *)btn{
    kMeWEAKSELF
    if(_isEdit){
        [SSPublicNetWorkTool postEditAddressWithAttrModel:_attrModel successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            kMeCallBlock(strongSelf->_reloadBlock);
        } failure:nil];
    }else{
        [SSPublicNetWorkTool postAddAddressWithAttrModel:_attrModel successBlock:^(ZLRequestResponse *responseObject) {
            kMeSTRONGSELF
            kMeCallBlock(strongSelf->_reloadBlock);
        } failure:^(id object) {
            
        }];
    }
}

- (IBAction)defactAddressAction:(UISwitch *)sender {
    BOOL isDefault = sender.on;
    _attrModel.is_default = isDefault;
}

- (IBAction)selectCityAction:(UIButton *)sender {
    [self.view endEditing:YES];
    kMeWEAKSELF
    [SSAddressPickerView areaPickerViewWithProvince:kMeUnNilStr(_attrModel.province) city:kMeUnNilStr(_attrModel.city) area:kMeUnNilStr(_attrModel.district) areaBlock:^(NSString *province, NSString *city, NSString *area) {
        kMeSTRONGSELF
        strongSelf.attrModel.province = kMeUnNilStr(province);
        strongSelf.attrModel.city = kMeUnNilStr(city);
        strongSelf.attrModel.district = kMeUnNilStr(area);
        [strongSelf.btnCity setTitle:[NSString stringWithFormat:@"%@%@%@", kMeUnNilStr(province),kMeUnNilStr(city),kMeUnNilStr(area)] forState:UIControlStateNormal];
    }];
}

#pragma mark - Getter
- (UIButton *)btnRight{
    if(!_btnRight){
        _btnRight= [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRight setTitle:@"保存" forState:UIControlStateNormal];
        [_btnRight setTitleColor:kSSblack forState:UIControlStateNormal];
        _btnRight.frame = CGRectMake(-20, 0, 30, 25);
        _btnRight.titleLabel.font = kMeFont(14);
        [_btnRight addTarget:self action:@selector(saveAddress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}

#pragma mark - Setter



@end
