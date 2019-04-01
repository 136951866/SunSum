//
//  SSArticleDetailVC.m
//  SunSum
//
//  Created by hank on 2018/11/28.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSArticleDetailVC.h"
#import "SSArticelModel.h"
#import "SSArticelDetailModel.h"
#import "TDWebViewCell.h"
#import "SSWebTitleCell.h"

@interface SSArticleDetailVC ()<UITableViewDelegate,UITableViewDataSource>{
    SSArticelModel *_model;
    SSArticelDetailModel *_detailModel;
}
//@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;
@property (nonatomic, strong) UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consBootom;
@property (strong, nonatomic) TDWebViewCell                  *webCell;
@end

@implementation SSArticleDetailVC

#pragma mark - LifeCycle

- (void)dealloc{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    kTDWebViewCellDidFinishLoadNotificationCancel
}

- (instancetype)initWithModel:(SSArticelModel *)model{
    if(self = [super init]){
        _model = model;
        kSDLoadImg(self.imgIcon, kMeUnNilStr(_model.images_url));
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kMeUnNilStr(_model.title);
//    if([WXApi isWXAppInstalled]){
//        _btnShare.hidden = NO;
//        _consBootom.constant = 0;
//    }else{
//        _btnShare.hidden = YES;
//        _consBootom.constant = -46;
//    }
    _consTopMargin.constant = kMeNavBarHeight;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDWebViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDWebViewCell class])];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSWebTitleCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSWebTitleCell class])];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    kMeWEAKSELF
    [SSPublicNetWorkTool postArticleClassWithId:@(_model.article_id).description successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_detailModel = [SSArticelDetailModel mj_objectWithKeyValues:responseObject.data];
        strongSelf.title = kMeUnNilStr(strongSelf->_detailModel.title);
        kSDLoadImg(strongSelf.imgIcon, kMeUnNilStr(strongSelf->_detailModel.images_url));
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
        NSString *header = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>",width];
//        [strongSelf->_webView loadHTMLString:[NSString stringWithFormat:@"%@%@",header,kMeUnNilStr(strongSelf->_detailModel.content)] baseURL:nil];
        [strongSelf.webCell.webView loadHTMLString:[NSString stringWithFormat:@"%@%@",header,kMeUnNilStr(strongSelf->_detailModel.content)] baseURL:nil];
        
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
    kTDWebViewCellDidFinishLoadNotification
}

kTDWebViewCellDidFinishLoadNotificationMethod

- (IBAction)shareAction:(UIButton *)sender {
    if([SSUserInfoModel isLogin]){
        [self toShare];
    }else{
        kMeWEAKSELF
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            kMeSTRONGSELF
            [strongSelf toShare];
        } failHandler:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 1){
        return self.webCell;
    }else{
        SSWebTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSWebTitleCell class])];
        [cell setUiWithModel:_detailModel];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==1){
        if(!_webCell){
            return 0;
        }else{
            return [[self.webCell.webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] intValue];
        }
    }
    else{
        return [SSWebTitleCell getCellHeightWithModel:_detailModel];
    }
}

#pragma MARK - Setter

- (TDWebViewCell *)webCell{
    if(!_webCell){
        _webCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDWebViewCell class])];
    }
    return _webCell;
}

- (void)toShare{
    SSShareTool *shareTool = [SSShareTool me_instanceForTarget:self];
    shareTool.sharWebpageUrl = [NSString stringWithFormat:@"%@%@",SSIPArticelShare,@(_detailModel.article_id).description];
    shareTool.shareTitle = kMeUnNilStr(_model.title);
    shareTool.shareDescriptionBody = kMeUnNilStr(_model.author);
    shareTool.shareImage = self.imgIcon.image;
    shareTool.articelId = @(_model.article_id).description;
    [shareTool showShareView:kShareWebPageContentType success:^(id data) {
        NSLog(@"分享成功%@",data);
    } failure:^(NSError *error) {
        NSLog(@"分享失败");
    }];
    
}

- (UIImageView *)imgIcon{
    if(!_imgIcon){
        _imgIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    }
    return _imgIcon;
}

@end
