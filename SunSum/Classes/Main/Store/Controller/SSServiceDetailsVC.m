//
//  SSServiceDetailsVC.m
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSServiceDetailsVC.h"
#import "SSServiceDetailsHeaderView.h"
#import "TDWebViewCell.h"
#import "SSProductDetailsSectionView.h"
#import "SSProductDetalsBuyedCell.h"
#import "SSProductDetalsBuyedCell.h"
#import "SSServiceDetailsBottomView.h"
#import "SSServiceDetailTelAddressCell.h"
#import "SSGoodDetailModel.h"
#import "SSRCConversationVC.h"
#import "SSLoginVC.h"
#import "SSAppointmentInfoVC.h"
#import "SSServiceDetailsModel.h"
#import "SSStoreDetailModel.h"
#import "SSAppointAttrModel.h"

@interface SSServiceDetailsVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _detailsId;;
    NSArray *_arrTitle;
    SSStoreDetailModel *_storeDetailModel;
    NSString *_customId;
    BOOL _isFromStore;
}

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) SSServiceDetailsBottomView *bottomView;
@property (nonatomic, strong) SSServiceDetailsHeaderView *headerView;;
@property (strong, nonatomic) TDWebViewCell                  *webCell;
@property (nonatomic, strong) UIView *tableViewBottomView;
@property (nonatomic, strong) SSServiceDetailsModel *model;
@property (nonatomic, strong) SSAppointAttrModel *attrModel;
@end

@implementation SSServiceDetailsVC

- (void)dealloc{
    kTDWebViewCellDidFinishLoadNotificationCancel
}

- (instancetype)initWithId:(NSInteger)detailsId{
    if(self = [super init]){
        _detailsId = detailsId;
//        _storeDetailModel = storeDetailModel;
        _isFromStore = NO;
    }
    return self;
}

- (instancetype)initWithId:(NSInteger)detailsId storeDetailModel:(SSStoreDetailModel *)storeDetailModel{
    if(self = [super init]){
        _detailsId = detailsId;
        _storeDetailModel = storeDetailModel;
        _isFromStore = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务详情";
    _arrTitle = @[@"产品介绍",@"SunSum美店",@"预约了这件商品的人也预约了"];
    [self initWithSomeThing];
    kTDWebViewCellDidFinishLoadNotification
    // Do any additional setup after loading the view.
}

- (void)initWithSomeThing{
    kMeWEAKSELF
    [SSPublicNetWorkTool postServiceDetailWithServiceId:_detailsId successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        SSServiceDetailsModel *model = [SSServiceDetailsModel mj_objectWithKeyValues:responseObject.data];
        [strongSelf setUIWithModel:model];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)setUIWithModel:(SSServiceDetailsModel *)model{
    self.model = model;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.tableViewBottomView;
    [self.headerView setUIWithModel:self.model.serviceDetail];
    [self.view addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kSSServiceDetailsBottomViewHeight));
        make.width.equalTo(@(self.view.width));
        make.top.equalTo(@(self.view.bottom-kSSServiceDetailsBottomViewHeight));
    }];
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    NSString *header = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>",width];
    [self.webCell.webView loadHTMLString:[NSString stringWithFormat:@"%@%@",header,kMeUnNilStr(self.model.serviceDetail.content)] baseURL:nil];
    [MBProgressHUD showMessage:@"加载详情" toView:self.view];
}

kTDWebViewCellDidFinishLoadNotificationMethod

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
        if(_isFromStore){
            SSServiceDetailTelAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSServiceDetailTelAddressCell class]) forIndexPath:indexPath];
            [cell setUIWithModel:_storeDetailModel];
            return cell;
        }else{
            return [UITableViewCell new];
        }
    }else if(indexPath.section == 2){
        SSProductDetalsBuyedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSProductDetalsBuyedCell class]) forIndexPath:indexPath];
        [cell setServiceUIWithArr:kMeUnArr(_model.recommendService) storeDetailModel:_storeDetailModel];
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
        return _isFromStore?kSSServiceDetailTelAddressCellHeight:0.1;
    }else if(indexPath.section == 2){
        return kSSProductDetalsBuyedCellHeight;
    }else{
        return 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.section);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kSSProductDetailsSectionViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SSProductDetailsSectionView *headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SSProductDetailsSectionView class])];
    headview.lblTitle.text = kMeUnArr(_arrTitle)[section];
    return headview;
}


#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kSSServiceDetailsBottomViewHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDWebViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDWebViewCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSProductDetalsBuyedCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSProductDetalsBuyedCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSServiceDetailTelAddressCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSServiceDetailTelAddressCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSProductDetailsSectionView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SSProductDetailsSectionView class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (SSServiceDetailsBottomView *)bottomView{
    if(!_bottomView){
        _bottomView = [[[NSBundle mainBundle]loadNibNamed:@"SSServiceDetailsBottomView" owner:nil options:nil] lastObject];
        kMeWEAKSELF
        _bottomView.appointMentBlock = ^{
//            kMeSTRONGSELF
//            [SSCommonTool showWithTellPhone:kMeUnNilStr(strongSelf->_storeDetailModel.cellphone) inView:strongSelf.view];
            if([SSUserInfoModel isLogin]){
                kMeSTRONGSELF
                strongSelf.attrModel.store_id = strongSelf->_storeDetailModel.store_id;
                strongSelf.attrModel.storeName = strongSelf->_storeDetailModel.store_name;
                SSAppointmentInfoVC *infoVC = [[SSAppointmentInfoVC alloc]initWithAttrModel:strongSelf.attrModel serviceDetailModel:strongSelf.model];
                [strongSelf.navigationController pushViewController:infoVC animated:YES];
            }else{
                [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
                    kMeSTRONGSELF
                    strongSelf.attrModel.store_id = strongSelf->_storeDetailModel.store_id;
                    strongSelf.attrModel.storeName = strongSelf->_storeDetailModel.store_name;
                    SSAppointmentInfoVC *infoVC = [[SSAppointmentInfoVC alloc]initWithAttrModel:strongSelf.attrModel serviceDetailModel:strongSelf.model];
                    [strongSelf.navigationController pushViewController:infoVC animated:YES];
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

- (SSServiceDetailsHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"SSServiceDetailsHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [SSServiceDetailsHeaderView getViewHeight]);
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


- (TDWebViewCell *)webCell{
    if(!_webCell){
        _webCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDWebViewCell class])];
    }
    return _webCell;
}

- (SSAppointAttrModel *)attrModel{
    if(!_attrModel){
        _attrModel = [[SSAppointAttrModel alloc]initAttr];
        _attrModel.product_id = _detailsId;
        _attrModel.isFromStroe = _isFromStore;
    }
    return _attrModel;
}


@end
