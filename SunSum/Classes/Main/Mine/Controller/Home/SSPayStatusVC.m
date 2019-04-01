//
//  SSPayStatusVC.m
//  SunSum
//
//  Created by hank on 2018/9/15.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSPayStatusVC.h"
#import "SSProductListVC.h"
#define kImgTopMargin (70* kMeFrameScaleY()+kMeStatusBarHeight)

#define kFristBtnSucesstopMargin (124 * kMeFrameScaleY())
#define kFristBtnFailtopMargin (156 * kMeFrameScaleY())

@interface SSPayStatusVC (){
    SSOrderStatusStyle _status;
    kMeBasicBlock _confirmblock;
    kMeBasicBlock _rePayBlock;
    kMeBasicBlock _checkOrderBlock;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImgTopMArgin;
@property (weak, nonatomic) IBOutlet UIImageView *imgStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@property (weak, nonatomic) IBOutlet UIButton *btnRpayOrComfire;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckOrder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consFristBtnTopMargin;


@end

@implementation SSPayStatusVC

#pragma mark - LifeCycle

- (instancetype)initWithSucessConfireBlock:(kMeBasicBlock)block{
    if(self = [super init]){
        _status = SSOrderStatusSucessStyle;
        _confirmblock = block;
    }
    return self;
}

- (instancetype)initWithFailRePayBlock:(kMeBasicBlock)rePayBlock CheckOrderBlock:(kMeBasicBlock)checkOrderBlock{
    if(self = [super init]){
        _status = SSOrderStatusFailStyle;
        _rePayBlock = rePayBlock;
        _checkOrderBlock = checkOrderBlock;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付结果";
    _consImgTopMArgin.constant = kImgTopMargin;
    if(_status == SSOrderStatusFailStyle){
        _imgStatus.image = kMeGetAssetImage(@"icon-fcwfrwmt");
        _consFristBtnTopMargin.constant = kFristBtnFailtopMargin;
         _btnCheckOrder.hidden = YES;
        _lblStatus.text = @"支付失败";
    }else{
        _imgStatus.image = kMeGetAssetImage(@"icon-fcwfdnal");
        _consFristBtnTopMargin.constant = kFristBtnSucesstopMargin;
        _btnCheckOrder.hidden = YES;
        [_btnRpayOrComfire setTitle:@"确定" forState:UIControlStateNormal];
        _lblStatus.text = @"支付成功";
        [SSPublicNetWorkTool getUserCheckFirstBuyWithSuccessBlock:^(ZLRequestResponse *responseObject) {
            if([responseObject.data isKindOfClass:[NSDictionary class]]){
                NSInteger f = [responseObject.data[@"first_buy"] integerValue];
                if(f){
                    SSAlertView *aler = [[SSAlertView alloc] initWithTitle:@"提示" message:@"您有一次免费预约门店服务的机会"];
                    [aler addButtonWithTitle:@"取消"];
                    kMeWEAKSELF
                    [aler addButtonWithTitle:@"确定" block:^{
                        kMeSTRONGSELF
                        SSProductListVC *productList = [[SSProductListVC alloc]initWithType:SSGoodsTypeNetServiceStyle];
                        [strongSelf.navigationController pushViewController:productList animated:YES];
                    }];
                    [aler show];
                }
            }
        } failure:^(id object) {
            
        }];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rpayOrComfireAction:(UIButton *)sender {
    if(_status == SSOrderStatusFailStyle){
        kMeCallBlock(_rePayBlock);
    }else{
        kMeCallBlock(_confirmblock);
    }
}

- (IBAction)checkOrderAction:(UIButton *)sender {
    kMeCallBlock(_checkOrderBlock);
}

@end
