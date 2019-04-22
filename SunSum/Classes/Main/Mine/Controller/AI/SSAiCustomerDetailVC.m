//
//  SSAiCustomerDetailVC.m
//  SS时代
//
//  Created by hank on 2019/4/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAiCustomerDetailVC.h"
#import "SSAiCustomerDetailCell.h"
#import "SSAIDataHomeTimeModel.h"
#import "SSAiCustomerDetailModel.h"
#import "SSRCConversationVC.h"
#import "SSAIDataHomeTimeCell.h"
#import "SSAIDataHomeTimeModel.h"
#import "SSAiCustomerDataVC.h"
#import "SSAiCustomerTagVC.h"

const static CGFloat bottomBtnHeight = 47;

@interface SSAiCustomerDetailVC ()<UITableViewDelegate, UITableViewDataSource,RefreshToolDelegate>{
    SSAiCustomerDetailModel *_model;
    NSString *_userId;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) UIButton         *btnCall;
@property (nonatomic, strong) UIButton         *btnMessage;

@end

@implementation SSAiCustomerDetailVC

- (instancetype)initWithUserId:(NSString *)userId{
    if(self = [super init]){
        _userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客户详情";
    _model = [SSAiCustomerDetailModel new];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.btnMessage];
    [self.view addSubview:self.btnCall];
    [self.refresh addRefreshView];
}

- (void)reloadCustomData{
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetMemberBehaviorWithUid:_userId SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_model = [SSAiCustomerDetailModel mj_objectWithKeyValues:responseObject.data];
        [strongSelf.tableView reloadData];
    } failure:^(id object) {
//        kMeSTRONGSELF
//        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        [self reloadCustomData];
    }
    return @{@"token":kMeUnNilStr(kCurrentUser.token),@"uid":kMeUnNilStr(_userId)};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[SSAIDataHomeTimeModel mj_objectArrayWithKeyValuesArray:data]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section){
       return self.refresh.arrData.count;
    }else{
       return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section){
        SSAIDataHomeTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAIDataHomeTimeCell class]) forIndexPath:indexPath];
        cell.imgArrow.hidden = YES;
        SSAIDataHomeTimeModel *model = self.refresh.arrData[indexPath.row];
        [cell setUIWithModel:model];
        return cell;
    }else{
        SSAiCustomerDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAiCustomerDetailCell class]) forIndexPath:indexPath];
        [cell setUIWithModel:_model];
        kMeWEAKSELF
        cell.followBlock = ^{
            kMeSTRONGSELF
            SSCustomActionSheet *sheet = [[SSCustomActionSheet alloc]initWithTitles:@[@"20%",@"40%",@"80%",@"成交",@"无法签单"]];
            NSArray *arrTitle = @[@"20",@"40",@"80",@"成交",@"无法签单"];
            sheet.blockBtnTapHandle = ^(NSInteger index){
                [strongSelf updataFollowDataWithStr:arrTitle[index]];
            };
            [sheet show];
        };
        cell.addTagBlock = ^{
            kMeSTRONGSELF
            [strongSelf toTagVC];
        };
        return cell;
    }
}

- (void)toTagVC{
    if(_model.member_id == 0){
        [SSShowViewTool showMessage:@"未获取到用户信息" view:self.view];
        return;
    }
    SSAiCustomerTagVC *vc = [[SSAiCustomerTagVC alloc]initWithArrId:kMeUnArr(_model.label_id) uid:_userId];
    kMeWEAKSELF
    vc.finishBlock = ^{
        kMeSTRONGSELF
        [strongSelf reloadCustomData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updataFollowDataWithStr:(NSString*)str{
    if(_model.member_id == 0){
        [SSShowViewTool showMessage:@"未获取到用户信息" view:self.view];
        return;
    }
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetCustomerupdateFollowWithUid:_userId follow_up:str SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_model.follow_up = str;
        [strongSelf.tableView reloadData];
    } failure:^(id object) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section){
        return kSSAIDataHomeTimeCellHeight;
    }else{
        return [SSAiCustomerDetailCell getCellHeightWithModel:_model];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        SSAiCustomerDataVC *vc = [[SSAiCustomerDataVC alloc]initWithUserId:_userId];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section){
      return 49;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        UILabel *lblb = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEN_HEIGHT - 30, 29)];
        lblb.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        lblb.text = @"来访记录";
        [view addSubview:lblb];
        return view;
    }
    return [UIView new];
}

- (void)callAction{
    if(kMeUnNilStr(_model.cellphone).length == 0){
        [SSShowViewTool showMessage:@"未获取到用户信息" view:self.view];
        return;
    }
    [SSPublicNetWorkTool postgetSSIPcommonclerknotFollowUpMemberWithUid:@(_model.member_id).description type:4 SuccessBlock:nil failure:nil];
    [SSCommonTool showWithTellPhone:kMeUnNilStr(_model.cellphone) inView:self.view];
}

- (void)messageAction{
    if(kMeUnNilStr(_model.tls_id).length == 0){
        [SSShowViewTool showMessage:@"未获取到用户信息" view:self.view];
        return;
    }
    if([kMeUnNilStr(_model.tls_id) isEqualToString:kCurrentUser.tls_data.tls_id]){
        [SSShowViewTool showMessage:@"暂不支持和自己聊天" view:self.view];
        return;
    }else{
        TConversationCellData *data = [[TConversationCellData alloc] init];
        data.convId = kMeUnNilStr(_model.tls_id);
        data.convType = TConv_Type_C2C;
        data.title = kMeUnNilStr(_model.nick_name);;
        SSRCConversationVC *chat = [[SSRCConversationVC alloc] initWIthconversationData:data];
        [self.navigationController pushViewController:chat animated:YES];
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight - bottomBtnHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAiCustomerDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAiCustomerDetailCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAIDataHomeTimeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAIDataHomeTimeCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =[UIColor colorWithHexString:@"f4f4f4"];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url: kGetApiWithUrl(SSIPcommonaigetMemberVisit)];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        _refresh.showFailView = NO;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有客户";
            failView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        }];
    }
    return _refresh;
}

- (UIButton *)btnCall{
    if(!_btnCall){
        _btnCall = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCall.frame = CGRectMake(0, SCREEN_HEIGHT - bottomBtnHeight, SCREEN_WIDTH/2, bottomBtnHeight);
        [_btnCall addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
        _btnCall.backgroundColor =[UIColor colorWithHexString:@"21202e"];
        [_btnCall setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnCall setImage:[UIImage imageNamed:@"aiDetailCall"] forState:UIControlStateNormal];
        [_btnCall setTitle:@" 打电话" forState:UIControlStateNormal];
        _btnCall.titleLabel.font = kMeFont(17);
    }
    return _btnCall;
}

- (UIButton *)btnMessage{
    if(!_btnMessage){
        _btnMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnMessage.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - bottomBtnHeight, SCREEN_WIDTH/2, bottomBtnHeight);
        [_btnMessage addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
        _btnMessage.backgroundColor =[UIColor colorWithHexString:@"55ba14"];
        [_btnMessage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnMessage setImage:[UIImage imageNamed:@"aiDetailMessage"] forState:UIControlStateNormal];
        [_btnMessage setTitle:@" 发消息" forState:UIControlStateNormal];
        _btnMessage.titleLabel.font = kMeFont(17);
    }
    return _btnMessage;
}

@end
