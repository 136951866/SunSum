//
//  SSJDCoupleMailDetalVC.m
//  SunSum
//
//  Created by hank on 2019/2/20.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSJDCoupleMailDetalVC.h"
#import "SSJDCoupleModel.h"
#import "SSCoupleMailHeaderVIew.h"
#import "SSCoupleMailDetalImageCell.h"

#define SSJDCoupleMailDetalVCbottomViewHeight 50

@interface SSJDCoupleMailDetalVC ()<UITableViewDelegate,UITableViewDataSource>{
     SSJDCoupleModel *_detailModel;
    NSString *_Tpwd;
    NSString *_shareTpwd;
}
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic,strong) SSCoupleMailHeaderVIew *headerView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *btnShare;
@property (nonatomic,strong) UIButton *btnBuy;

@end

@implementation SSJDCoupleMailDetalVC


- (instancetype)initWithModel:(SSJDCoupleModel *)model{
    if(self = [super init]){
        _detailModel = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    self.tableView.tableHeaderView = self.headerView;
    [self.headerView setJDUIWithModel:_detailModel];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _detailModel.imageInfo.imageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSCoupleMailDetalImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSCoupleMailDetalImageCell class]) forIndexPath:indexPath];
    ImageContentInfo *couponInfoModel = _detailModel.imageInfo.imageList[indexPath.row];
    kSDLoadImg(cell.imageView, kMeUnNilStr(couponInfoModel.url));
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UIView *viewGary = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    viewGary.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-160)/2, 22.5, 160, 1)];
    viewLine.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, 0, 80, 44)];
    lbl.text = @"宝贝详情";
    lbl.font = kMeFont(12);
    lbl.textColor = [UIColor colorWithHexString:@"333333"];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.backgroundColor = [UIColor whiteColor];
    [view addSubview:viewLine];
    [view addSubview:lbl];
    [view addSubview:viewGary];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
    
}

- (void)buyAction:(UIButton *)btn{
    if(kMeUnNilStr(_Tpwd).length){
        [self openTb];
    }else{
        CouponContentInfo *couponInfoModel = [CouponContentInfo new];
        if(kMeUnArr(_detailModel.couponInfo.couponList).count>0){
            couponInfoModel = _detailModel.couponInfo.couponList[0];
        }
        kMeWEAKSELF
        [SSPublicNetWorkTool postJDPromotionUrlGenerateWithUid:@"" materialUrl:kMeUnNilStr(_detailModel.materialUrl) couponUrl:kMeUnNilStr(couponInfoModel.link) successBlock:^(ZLRequestResponse *responseObject) {
            if(responseObject.data[@"msg"]){
                [SSShowViewTool showMessage:kMeUnNilStr(responseObject.data[@"msg"]) view:kMeCurrentWindow];
            }else{
                kMeSTRONGSELF
                strongSelf->_Tpwd = responseObject.data[@"shortURL"];
                [strongSelf openTb];
            }
        } failure:^(id object) {
            
        }];
    }
}

- (void)shareAction:(UIButton *)btn{
    if([SSUserInfoModel isLogin]){
        if(_shareTpwd){
            SSShareTool *shareTool = [SSShareTool me_instanceForTarget:self];
            shareTool.sharWebpageUrl =kMeUnNilStr(_shareTpwd);
            shareTool.shareTitle = kMeUnNilStr(_detailModel.skuName);
            shareTool.shareDescriptionBody = kMeUnNilStr(_detailModel.skuName);
            shareTool.shareImage = _headerView.imgPic.image;
            [shareTool showShareView:kShareWebPageContentType success:^(id data) {
                NSLog(@"分享成功%@",data);
            } failure:^(NSError *error) {

            }];
        }else{
            CouponContentInfo *couponInfoModel = [CouponContentInfo new];
            if(kMeUnArr(_detailModel.couponInfo.couponList).count>0){
                couponInfoModel = _detailModel.couponInfo.couponList[0];
            }
            kMeWEAKSELF
            [SSPublicNetWorkTool postJDPromotionUrlGenerateWithUid:kCurrentUser.uid materialUrl:kMeUnNilStr(_detailModel.materialUrl) couponUrl:kMeUnNilStr(couponInfoModel.link) successBlock:^(ZLRequestResponse *responseObject) {
                kMeSTRONGSELF
                strongSelf->_shareTpwd = responseObject.data[@"shortURL"];
                SSShareTool *shareTool = [SSShareTool me_instanceForTarget:strongSelf];
                shareTool.sharWebpageUrl = strongSelf->_shareTpwd;
                shareTool.shareTitle = kMeUnNilStr(strongSelf->_detailModel.skuName);
                shareTool.shareDescriptionBody = kMeUnNilStr(strongSelf->_detailModel.skuName);
                shareTool.shareImage = strongSelf->_headerView.imgPic.image;
                [shareTool showShareView:kShareWebPageContentType success:^(id data) {
                    NSLog(@"分享成功%@",data);
                } failure:^(NSError *error) {
                    
                }];
            } failure:^(id object) {
                
            }];
        }
    }else{
        kMeWEAKSELF
        [SSLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            [strongSelf shareAction:nil];
        } failHandler:nil];
    }
}

 - (void)openTb{
//     NSString *url = [[NSString stringWithFormat:@"openapp.jdmobile://virtual?params={\"category\":\"jump\",\"des\":\"productDetail\",\"skuId\":\"%@\",\"sourceType\":\"JSHOP_SOURCE_TYPE\",\"sourceValue\":\"JSHOP_SOURCE_VALUE\"}",kMeUnNilStr(_detailModel.skuId)] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSString *url = [[NSString stringWithFormat:@"openapp.jdmobile://virtual?params={\"category\":\"jump\",\"des\":\"m\",\"url\":\"%@\"}",kMeUnNilStr(_Tpwd)] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSURL * requestURL = [NSURL URLWithString:url];
     if ([[UIApplication sharedApplication] canOpenURL:requestURL]) {
         [[UIApplication sharedApplication] openURL:requestURL];
     } else {
         NSURL *newurl = [NSURL URLWithString:kMeUnNilStr(_Tpwd)];
         [[UIApplication sharedApplication] openURL:newurl];
     }
 }

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-SSJDCoupleMailDetalVCbottomViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSCoupleMailDetalImageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSCoupleMailDetalImageCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = SCREEN_WIDTH;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (SSCoupleMailHeaderVIew *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSCoupleMailHeaderVIew" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SSCoupleMailHeaderVIewHeight);
        kMeWEAKSELF
        _headerView.getCoupleBlock = ^{
            kMeSTRONGSELF
            [strongSelf buyAction:nil];
        };
    }
    return _headerView;
}

- (UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-SSJDCoupleMailDetalVCbottomViewHeight, SCREEN_WIDTH, SSJDCoupleMailDetalVCbottomViewHeight)];
        _bottomView.backgroundColor =[UIColor colorWithHexString:@"F70054"];
        [_bottomView addSubview:self.btnShare];
        [_bottomView addSubview:self.btnBuy];
    }
    return _bottomView;
}

- (UIButton *)btnBuy{
    if(!_btnBuy){
        _btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBuy.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, SSJDCoupleMailDetalVCbottomViewHeight);
        [_btnBuy addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnBuy.backgroundColor =[UIColor colorWithHexString:@"F70054"];
        [_btnBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnBuy setTitle:@"立即购买" forState:UIControlStateNormal];
        _btnBuy.titleLabel.font = kMeFont(15);
    }
    return _btnBuy;
}

- (UIButton *)btnShare{
    if(!_btnShare){
        _btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnShare.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, SSJDCoupleMailDetalVCbottomViewHeight);
        [_btnShare addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnShare.backgroundColor = [UIColor colorWithHexString:@"FC8F0C"];
        [_btnShare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        NSString *str = [NSString stringWithFormat:@"分享购买最低%.2f佣金",_detailModel.commissionInfo.commission* _detailModel.percent];
        [_btnShare setTitle:str forState:UIControlStateNormal];
        _btnShare.titleLabel.font = kMeFont(15);
        _btnShare.hidden = ![WXApi isWXAppInstalled];
    }
    return _btnShare;
}


@end
