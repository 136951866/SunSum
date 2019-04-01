//
//  SSMineExchangeDetailVC.m
//  SunSum
//
//  Created by hank on 2018/9/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMineExchangeDetailVC.h"
#import "TDWebViewCell.h"
#import "SSProductDetailsHeaderView.h"
#import "SSProductDetailsSectionView.h"
#import "SSProductDetalsBuyedCell.h"
#import "SSMineExchangeRudeCell.h"
#import "SSMineExchangeRudeSectionView.h"
#import "SSSkuBuyView.h"
#import "SSMakeOrderVC.h"
#import "SSGoodModel.h"
#import "SSGoodDetailModel.h"
#import "SSExchangDetailsBottomView.h"
#import "SSRCConversationVC.h"

@interface SSMineExchangeDetailVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrTitle;
    BOOL _isExpand;
    NSString *_str;
    NSInteger _detailsId;
    SSGoodDetailModel *_model;
    NSString *_customId;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) SSProductDetailsHeaderView *headerView;;
@property (nonatomic, strong) SSExchangDetailsBottomView *bottomView;;
@property (strong, nonatomic) TDWebViewCell                  *webCell;
@property (nonatomic, strong) UIView *tableViewBottomView;
@property (nonatomic, strong) SSSkuBuyView *purchaseView;
@property (nonatomic, strong) NSArray *arrCommendModel;
@end

@implementation SSMineExchangeDetailVC

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
    self.title = @"兑换详情";
    _str=@"1、注册、分享、邀请好友，产生都获得不同的美豆\n2、使用美豆可以在兑换区兑换产品\n3、不同产品的美豆兑换比不一样\n4、兑换流程为：进入我的美豆，点击兑换商品，开始兑换";
    _arrTitle = @[@"详情",@"买了这件商品的人也买了",@"兑换规则"];
    _isExpand = NO;
    [self initWithSomeThing];
    kTDWebViewCellDidFinishLoadNotification
    // Do any additional setup after loading the view.
}

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
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kSSExchangDetailsBottomViewHeight));
        make.width.equalTo(@(self.view.width));
        make.top.equalTo(@(self.view.bottom-kSSExchangDetailsBottomViewHeight));
    }];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.tableViewBottomView;
    [self.headerView setIntergalUIWithModel:_model];

    kMeWEAKSELF
    self.purchaseView.confirmBlock = ^{
        kMeSTRONGSELF
        SSMakeOrderVC *vc = [[SSMakeOrderVC alloc]initWithIsinteral:YES goodModel:strongSelf->_model];
        [strongSelf.navigationController pushViewController:vc animated:YES];
    };
    self.purchaseView.failGetStoreBlock = ^{
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    };
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    NSString *header = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>",width];
    [self.webCell.webView loadHTMLString:[NSString stringWithFormat:@"%@%@",header,kMeUnNilStr(_model.content)] baseURL:nil];
    
    [MBProgressHUD showMessage:@"获取详情中" toView:self.view];

    [SSPublicNetWorkTool postGoodsListWithType:SSGoodsTypeNetCommendStyle successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        NSArray *arr = [SSGoodModel mj_objectArrayWithKeyValuesArray:responseObject.data];
        strongSelf.arrCommendModel = arr;
        [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(id object) {

    }];
}


kTDWebViewCellDidFinishLoadNotificationMethod
- (void)toExchange:(UIButton *)btn{
    [self.purchaseView show];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 2?(_isExpand?1:0):1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return self.webCell;
    }else if(indexPath.section == 1){
        SSProductDetalsBuyedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSProductDetalsBuyedCell class]) forIndexPath:indexPath];
        [cell setUIWithArr:kMeUnArr(self.arrCommendModel)];
        return cell;
    } else if(indexPath.section == 2){
        SSMineExchangeRudeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSMineExchangeRudeCell class]) forIndexPath:indexPath];
        [cell setUIWithModel:_str];
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
        return kMeUnArr(self.arrCommendModel).count?kSSProductDetalsBuyedCellHeight:1;
    }else if(indexPath.section == 2){
        return _isExpand?[SSMineExchangeRudeCell getCellHeight:_str]:0;
    }else{
        return 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.section);

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section!=2?kSSProductDetailsSectionViewHeight:kSSMineExchangeRudeSectionViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section!=2){
        SSProductDetailsSectionView *headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SSProductDetailsSectionView class])];
        headview.lblTitle.text = kMeUnArr(_arrTitle)[section];
        return headview;
    }else{
        SSMineExchangeRudeSectionView *headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SSMineExchangeRudeSectionView class])];
        kMeWEAKSELF
        [headview setUIWihtStr:kMeUnArr(_arrTitle)[section] isExpand:_isExpand ExpandBlock:^(BOOL isExpand) {
            kMeSTRONGSELF
            strongSelf->_isExpand = isExpand;
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:2];
            [strongSelf.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        return headview;
    }
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

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kSSExchangDetailsBottomViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDWebViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDWebViewCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSProductDetalsBuyedCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSProductDetalsBuyedCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSProductDetailsSectionView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SSProductDetailsSectionView class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMineExchangeRudeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSMineExchangeRudeCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSMineExchangeRudeSectionView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SSMineExchangeRudeSectionView class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (SSProductDetailsHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSProductDetailsHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [SSProductDetailsHeaderView getViewHeight]);
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

- (SSExchangDetailsBottomView *)bottomView{
    if(!_bottomView){
        _bottomView = [[[NSBundle mainBundle]loadNibNamed:@"SSExchangDetailsBottomView" owner:nil options:nil] lastObject];
        kMeWEAKSELF
        _bottomView.exchangeBlock  = ^{
            //            kMeSTRONGSELF
            //            [SSCommonTool showWithTellPhone:kMeUnNilStr(strongSelf->_storeDetailModel.cellphone) inView:strongSelf.view];
            if([SSUserInfoModel isLogin]){
                kMeSTRONGSELF
                [strongSelf.purchaseView show];
            }else{
                [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
                    kMeSTRONGSELF
                    [strongSelf.purchaseView show];
                } failHandler:nil];
            }
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

- (TDWebViewCell *)webCell{
    if(!_webCell){
        _webCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDWebViewCell class])];
    }
    return _webCell;
}

- (SSSkuBuyView *)purchaseView{
    if(!_purchaseView){
        _purchaseView = [[SSSkuBuyView alloc]initPurchaseViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) serviceModel:_model WithSuperView:self.view isInteral:YES];
    }
    return _purchaseView;
}

@end
