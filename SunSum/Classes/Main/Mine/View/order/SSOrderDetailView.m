//
//  SSOrderDetailView.m
//  SunSum
//
//  Created by hank on 2018/9/11.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSOrderDetailView.h"
#import "SSOrderDetailModel.h"
//#import "SSLogisticsVC.h"
#import "SSMyOrderDetailVC.h"
#import "SSAppointDetailModel.h"
//#import "SSOrderExpressDetailVC.h"
#import "SSOrderExpressDetailVC.h"
#import "ZLWebVC.h"

@interface SSOrderDetailView(){
    NSArray *_arrType;
    NSArray *_arrAppointType;
    SSOrderDetailModel *_modle;
}
@property (weak, nonatomic) IBOutlet UILabel *lblOrderStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderNum;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIView *viewForLogist;
@property (weak, nonatomic) IBOutlet UILabel *lblLogist;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatTime;



@end

@implementation SSOrderDetailView

- (void)awakeFromNib{
    [super awakeFromNib];
   _arrType = SSOrderStyleTitle;
    _arrAppointType = SSAppointmenyStyleTitle;
    _lblName.adjustsFontSizeToFitWidth = YES;
    _viewForLogist.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logistAction:)];
    [_viewForLogist addGestureRecognizer:ges];
}

- (void)logistAction:(UITapGestureRecognizer *)ges{
    SSMyOrderDetailVC *orderVC = (SSMyOrderDetailVC *)[SSCommonTool getVCWithClassWtihClassName:[SSMyOrderDetailVC class] targetResponderView:self];
    if(orderVC){
        NSArray *arr = kMeUnArr(_modle.express_detail);
        if(arr.count==1){
            SSexpressDetailModel *detailmodel = [arr firstObject];
            NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                            (CFStringRef)kMeUnNilStr(detailmodel.express_url),(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8));
            ZLWebVC *vc = [[ZLWebVC alloc]initWithUrl:encodedString];
            vc.title = @"物流信息";
            [orderVC.navigationController pushViewController:vc animated:YES];
        }else if(arr.count>1){
            SSOrderExpressDetailVC *logistVC = [[SSOrderExpressDetailVC alloc]initWithModel:_modle];
            [orderVC.navigationController pushViewController:logistVC animated:YES];
        }else{
            
        }
    }
}

- (void)setUIWithModel:(SSOrderDetailModel *)model orderType:(SSOrderStyle)type{
    _modle = model;
//    if(type == SSAllNeedReceivedOrder || type == SSAllFinishOrder){
        _viewForLogist.hidden = NO;
        _viewForLogist.userInteractionEnabled = YES;
//        SSLogistModel *lmodel = model.logistics;
        NSArray *arr = kMeUnArr(model.express_detail);
        if(arr.count>0){
            _viewForLogist.hidden = NO;
            _viewForLogist.userInteractionEnabled = YES;
//            SSLogistDataModel *ldModel = [lmodel.data firstObject];
            _lblLogist.text = @"查看物流";
        }else{
//            _lblLogist.text = @"暂无快递信息";
            _viewForLogist.hidden = YES;
            _viewForLogist.userInteractionEnabled = NO;
        }
//    }else{
//        _viewForLogist.hidden = YES;
//        _viewForLogist.userInteractionEnabled = NO;
//    }
//    _lblOrderStatus.text = [NSString stringWithFormat:@"订单%@",_arrType[type]];
    _lblOrderStatus.text = [NSString stringWithFormat:@"订单%@",kMeUnNilStr(model.order_status_name)];

    _lblOrderNum.text = [NSString stringWithFormat:@"订单编号:%@",kMeUnNilStr(model.order_sn)];
    _lblName.text = kMeUnNilStr(model.address.name);
    _lblPhone.text = kMeUnNilStr(model.address.mobile);
    _lblCreatTime.text = [NSString stringWithFormat:@"创建时间:%@",kMeUnNilStr(model.created_at)];;
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",kMeUnNilStr(model.address.province_id),kMeUnNilStr(model.address.city_id),kMeUnNilStr(model.address.area_id),kMeUnNilStr(model.address.detail)];
    _lblAddress.text  = address;
}

- (void)setAppointUIWithModel:(SSAppointDetailModel *)model orderType:(SSAppointmenyStyle)type{
    _viewForLogist.hidden = YES;
    _viewForLogist.userInteractionEnabled = NO;
    _lblOrderStatus.text = [NSString stringWithFormat:@"订单%@",_arrAppointType[type]];
    
//    _lblOrderNum.text = kMeUnNilStr(model.reserve_sn);
    _lblOrderNum.text = [NSString stringWithFormat:@"订单编号:%@",kMeUnNilStr(model.reserve_sn)];
    _lblCreatTime.text = [NSString stringWithFormat:@"创建时间:%@",kMeUnNilStr(model.created_at)];;
    _lblName.text = kMeUnNilStr(model.true_name);
    _lblPhone.text = kMeUnNilStr(model.cellphone);
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",kMeUnNilStr(model.province),kMeUnNilStr(model.city),kMeUnNilStr(model.district),kMeUnNilStr(model.address)];
    _lblAddress.text  = address;
}

+ (CGFloat)getViewHeightWithType:(SSOrderStyle)type Model:(SSOrderDetailModel *)model{
    NSArray *arr = kMeUnArr(model.express_detail);
    if(arr.count>0){
        return kSSOrderDetailViewHeight + kSSOrderDetailViewLogistHeight;
    }else{
        return kSSOrderDetailViewHeight;
    }
}

@end
