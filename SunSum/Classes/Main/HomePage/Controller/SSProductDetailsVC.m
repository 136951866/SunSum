//
//  SSProductDetailsVC.m
//  SunSum
//
//  Created by hank on 2018/9/7.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSProductDetailsVC.h"
#import "SSProductDetailsBottomView.h"
#import "TDWebViewCell.h"
//#import "SSProductDetailsHeaderView.h"
#import "SSNewProductDetailsHeaderView.h"
//#import "SSProductDetailsSectionView.h"
#import "SSNewProductDetailsSectionView.h"
#import "SSProductDetalsBuyedCell.h"
#import "SSGoodsAttributeVC.h"
#import "SSSkuBuyView.h"
#import "SSMakeOrderVC.h"
#import "SSGoodDetailModel.h"
#import "SSShoppingCartAttrModel.h"
#import "SSGoodModel.h"
#import "SSLoginVC.h"
#import "SSRCConversationVC.h"
#import "SSGiftVC.h"
typedef NS_ENUM(NSUInteger, kpurchaseViewType) {
    kpurchaseSelectSkuViewType,
    kpurchaseViewBuyType,
    kpurchaseViewShoppingType,
};
@interface SSProductDetailsVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _detailsId;
    NSArray *_arrTitle;
//    BOOL _isShopping;
    kpurchaseViewType _selectType;
    NSString *_customId;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) SSProductDetailsBottomView *bottomView;
@property (nonatomic, strong) SSNewProductDetailsHeaderView *headerView;;
@property (strong, nonatomic) TDWebViewCell                  *webCell;
@property (nonatomic, strong) UIView *tableViewBottomView;
@property (nonatomic, strong) SSSkuBuyView *purchaseView;
@property (nonatomic, strong) SSGoodDetailModel *model;
@property (nonatomic, strong) NSArray *arrCommendModel;

@end

@implementation SSProductDetailsVC

- (void)dealloc{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    if(_purchaseView){
        [_purchaseView removeFromSuperview];
        [_purchaseView.layer removeAllAnimations];
    }
    kTDWebViewCellDidFinishLoadNotificationCancel
}

- (instancetype)initWithId:(NSInteger)detailsId{
    if(self = [super init]){
        _detailsId = detailsId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品详情";
    _arrTitle = @[@"商品详情",@"买了这件商品的人也买了"];
    [self initWithSomeThing];
    kTDWebViewCellDidFinishLoadNotification
    // Do any additional setup after loading the view.
}

kTDWebViewCellDidFinishLoadNotificationMethod

- (void)initWithSomeThing{
    kMeWEAKSELF
    [SSPublicNetWorkTool postGoodsDetailWithGoodsId:_detailsId successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        SSGoodDetailModel *model = [SSGoodDetailModel mj_objectWithKeyValues:responseObject.data];
        model.buynum = 1;
        [strongSelf setUIWIthModel:model];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)setUIWIthModel:(SSGoodDetailModel *)model{
    _model = model;
    _selectType = kpurchaseSelectSkuViewType;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.tableViewBottomView;
    [self.headerView setUIWithModel:model];
    [self.view addSubview:self.bottomView];
    self.bottomView.is_clerk_share = [_model.is_clerk_share integerValue];
    self.bottomView.productId = @(_model.product_id).description;
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kSSProductDetailsBottomViewHeight));
//        make.width.equalTo(@(self.view.width));
        make.top.equalTo(@(self.view.bottom-kSSProductDetailsBottomViewHeight));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
    }];
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    NSString *header = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>",width];
    [self.webCell.webView loadHTMLString:[NSString stringWithFormat:@"%@%@",header,kMeUnNilStr(_model.content)] baseURL:nil];
    kMeWEAKSELF
    self.purchaseView.confirmBlock = ^{
        kMeSTRONGSELF
        switch (strongSelf->_selectType) {
            case kpurchaseSelectSkuViewType:{
                [strongSelf.headerView reloadStockAndSaled:strongSelf->_model];
            }
                break;
            case kpurchaseViewBuyType:{
                //生成订单
                SSMakeOrderVC *vc = [[SSMakeOrderVC alloc]initWithIsinteral:NO goodModel:strongSelf->_model];
                vc.uid = kMeUnNilStr(strongSelf.uid);
                [strongSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case kpurchaseViewShoppingType:{
                //加入购物车
                SSShoppingCartAttrModel *attrModle = [[SSShoppingCartAttrModel alloc]initWithGoodmodel:strongSelf->_model];
                if(strongSelf.isGift){
                    attrModle.type = 6;
                }
                attrModle.uid = kMeUnNilStr(strongSelf.uid);
                [SSPublicNetWorkTool postAddGoodForShopWithAttrModel:attrModle successBlock:^(ZLRequestResponse *responseObject) {
                    kMeSTRONGSELF
                    kNoticeReloadShopCart
                    if(strongSelf.isGift){
                        SSGiftVC *vc = (SSGiftVC *)[SSCommonTool getClassWtihClassName:[SSGiftVC class] targetVC:strongSelf];
                        [strongSelf.navigationController popToViewController:vc animated:YES];
                    }
                    
                } failure:^(id object) {
                }];
            }
                break;
            default:
                break;
        }
        
    };
    self.purchaseView.failGetStoreBlock = ^{
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    };
    self.purchaseView.sucessGetStoreBlock = ^{
        kMeSTRONGSELF
        [strongSelf.headerView reloadStockAndSaled:strongSelf->_model];
    };
    self.headerView.selectSkuBlock = ^{
        kMeSTRONGSELF
        [strongSelf showBuyViewWithTypy:kpurchaseSelectSkuViewType];
    };
    [MBProgressHUD showMessage:@"获取详情中" toView:self.view];
    [SSPublicNetWorkTool postGoodsListWithType:SSGoodsTypeNetCommendStyle successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        NSArray *arr = [SSGoodModel mj_objectArrayWithKeyValuesArray:responseObject.data];
        strongSelf.arrCommendModel = arr;
        [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(id object) {
        
    }];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return self.webCell;
    }else if(indexPath.section == 1){
        SSProductDetalsBuyedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSProductDetalsBuyedCell class]) forIndexPath:indexPath];
        [cell setUIWithArr:kMeUnArr(self.arrCommendModel)];
        return cell;
    }else{
        return [UITableViewCell new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(!_webCell){
            return 0;
        }else{
            return [[self.webCell.webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] intValue];
        }
    }else if(indexPath.section == 1){
        return kMeUnArr(self.arrCommendModel).count?kSSProductDetalsBuyedNewCellHeight:1;
    }else{
        return 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.section);

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kSSNewProductDetailsSectionViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SSNewProductDetailsSectionView *headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SSNewProductDetailsSectionView class])];
    headview.lbltitle.text = kMeUnArr(_arrTitle)[section];
    return headview;
}


#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kSSProductDetailsBottomViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDWebViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDWebViewCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSProductDetalsBuyedCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSProductDetalsBuyedCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSNewProductDetailsSectionView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SSNewProductDetailsSectionView class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (SSProductDetailsBottomView *)bottomView{
    if(!_bottomView){
        _bottomView = [[[NSBundle mainBundle]loadNibNamed:@"SSProductDetailsBottomView" owner:nil options:nil] lastObject];
        _bottomView.btnGift.hidden = !self.isGift;
        kMeWEAKSELF
        _bottomView.buyBlock = ^{
            kMeSTRONGSELF
            [strongSelf showBuyViewWithTypy:kpurchaseViewBuyType];
        };
        _bottomView.addShopcartBlock = ^{
            kMeSTRONGSELF
            [strongSelf showBuyViewWithTypy:kpurchaseViewShoppingType];
        };
        _bottomView.customBlock = ^{
            kMeSTRONGSELF
            if([SSUserInfoModel isLogin]){
                [strongSelf toCustom];
            }else{
                [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
                    [strongSelf toCustom];
                } failHandler:nil];
            }
        };
    }
    return _bottomView;
}

- (void)toCustom{
    
//    if(kMeUnNilStr(_customId).length){
//        SSRCConversationVC *conversationVC = [[SSRCConversationVC alloc]init];
//        conversationVC.conversationType = ConversationType_PRIVATE;
//        conversationVC.targetId =  kMeUnNilStr(_customId);//RONGYUNCUSTOMID;
//        conversationVC.title = @"客服";
//        if([kMeUnNilStr(_customId) isEqualToString:kCurrentUser.uid]){
//            [SSShowViewTool showMessage:@"暂不支持和自己聊天" view:self.view];
//        }else{
//            [self.navigationController pushViewController:conversationVC animated:YES];
//        }
//    }else{
//        kMeWEAKSELF
//        [SSPublicNetWorkTool postGetCustomIdWithsuccessBlock:^(ZLRequestResponse *responseObject) {
//            kMeSTRONGSELF
//            NSNumber *custom =kMeUnNilNumber(responseObject.data);
//            strongSelf->_customId = kMeUnNilStr(custom.description);
//            SSRCConversationVC *conversationVC = [[SSRCConversationVC alloc]init];
//            conversationVC.conversationType = ConversationType_PRIVATE;
//            conversationVC.targetId = strongSelf->_customId ;//RONGYUNCUSTOMID;
//            conversationVC.title = @"客服";
//            if([kMeUnNilStr(strongSelf->_customId) isEqualToString:kCurrentUser.uid]){
//                [SSShowViewTool showMessage:@"暂不支持和自己聊天" view:self.view];
//            }else{
//                [self.navigationController pushViewController:conversationVC animated:YES];
//            }
//        } failure:^(id object) {
//
//        }];
//    }

}

- (void)showBuyViewWithTypy:(kpurchaseViewType)type{
    if([SSUserInfoModel isLogin]){
        _selectType = type;
        [self.purchaseView show];
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            strongSelf->_selectType = type;
            [strongSelf.purchaseView show];
        } failHandler:nil];
    }
}

- (SSNewProductDetailsHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSNewProductDetailsHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [SSNewProductDetailsHeaderView getHeightWithModel:_model]);
    }
    return _headerView;
}

- (UIView *)tableViewBottomView{
    if(!_tableViewBottomView){
        _tableViewBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _tableViewBottomView.backgroundColor = kSSHexColor(@"eeeeee");
        UIImageView *img = [[UIImageView alloc]initWithImage:kMeGetAssetImage(@"icon-utkkyung")];
        img.frame = _tableViewBottomView.bounds;
        [_tableViewBottomView addSubview:img];
    }
    return _tableViewBottomView;
}

- (SSSkuBuyView *)purchaseView{
    if(!_purchaseView){
        _purchaseView = [[SSSkuBuyView alloc]initPurchaseViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) serviceModel:_model WithSuperView:self.view isInteral:NO];
    }
    return _purchaseView;
}

- (TDWebViewCell *)webCell{
    if(!_webCell){
        _webCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDWebViewCell class])];
    }
    return _webCell;
}

@end
