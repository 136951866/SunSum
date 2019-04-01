//
//  SSBStoreMannagerVC.m
//  SunSum
//
//  Created by hank on 2019/2/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBStoreMannagerVC.h"
#import "SSBStoreMannagerInfoModel.h"
#import "SSBStoreMannagerCell.h"
#import "SSBStoreMannagerEditInfoVC.h"
#import "ZHMapAroundInfoViewController.h"
#import "ZHPlaceInfoModel.h"
#import "SSBStoreMannagerModel.h"
#import "SSBStoreMannagerEditModel.h"

@interface SSBStoreMannagerVC ()<UITableViewDataSource,UITableViewDelegate>{
    SSBStoreMannagerModel *_model;
    SSBStoreMannagerEditModel *_editModel;
}

@property (nonatomic, strong) NSMutableArray *arrModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SSBStoreMannagercontentInfoModel *addrssModel;
@property (nonatomic, strong) SSBStoreMannagercontentInfoModel *dAddrssModel;
@property (nonatomic, strong) UIButton *btnRight;


@end

@implementation SSBStoreMannagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息管理";
    _arrModel = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnRight];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData{
    kMeWEAKSELF
    [SSPublicNetWorkTool postStroeFindStoreInfoWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_model = [SSBStoreMannagerModel mj_objectWithKeyValues:responseObject.data];
        [strongSelf initSomething];
    } failure:^(id object) {
       kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)initSomething{
    [_arrModel removeAllObjects];
    SSBStoreMannagerInfoModel *basicModel =  [SSBStoreMannagerInfoModel new];
    basicModel.title = @"基本信息";
    [basicModel.arrModel addObject:[SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerInfoNameType title:@"真实姓名:" subTitle:kMeUnNilStr(_model.true_name)]];
    [basicModel.arrModel addObject:[SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerInfoTelType title:@"手机号:" subTitle:kMeUnNilStr(_model.cellphone)]];
    
    
    SSBStoreMannagerInfoModel *idModel =  [SSBStoreMannagerInfoModel new];
    idModel.title = @"身份信息";
    [idModel.arrModel addObject:[SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerInfolevelType title:@"当前级别:" subTitle:kMeUnNilStr(_model.current)]];
    [idModel.arrModel addObject:[SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerInfoLoginNameType title:@"登录名:" subTitle:kMeUnNilStr(_model.login_name)]];
    [idModel.arrModel addObject:[SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerInfoTopNameType title:@"顶级名称:" subTitle:kMeUnNilStr(_model.top_name)]];
    [idModel.arrModel addObject:[SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerInfoSupoirNameType title:@"上级名称:" subTitle:kMeUnNilStr(_model.on_name)]];
    
    
    SSBStoreMannagerInfoModel *storeModel =  [SSBStoreMannagerInfoModel new];
    storeModel.title = @"店铺信息";
    [storeModel.arrModel addObject:[SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerInfoStoreNameType title:@"店铺名称:" subTitle:kMeUnNilStr(_model.store_name)]];
    [storeModel.arrModel addObject:[SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerInfoStoreTelType title:@"店铺电话:" subTitle:kMeUnNilStr(_model.mobile)]];
    [storeModel.arrModel addObject:[SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerInfocodeIdType title:@"身份证号:" subTitle:kMeUnNilStr(_model.id_number)]];
    [storeModel.arrModel addObject:[SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerStoreIntoduceType title:@"店铺简介:" subTitle:kMeUnNilStr(_model.intro)]];
    
    self.addrssModel = [SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerInfoAddressType title:@"地址:" subTitle:[NSString stringWithFormat:@"%@ %@ %@",kMeUnNilStr(_model.province),kMeUnNilStr(_model.city),kMeUnNilStr(_model.district)]];
    self.dAddrssModel = [SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerInfodetailAddressType title:@"详细地址:" subTitle:kMeUnNilStr(_model.address)];
    [storeModel.arrModel addObject:self.addrssModel];
    [storeModel.arrModel addObject:self.dAddrssModel];
    
    [storeModel.arrModel addObject:[SSBStoreMannagercontentInfoModel initWithType:SSBStoreMannagerInfoTimeType title:@"认证通过时间:" subTitle:kMeUnNilStr(_model.auth_at)]];
    
    [_arrModel addObject:basicModel];
    [_arrModel addObject:idModel];
    [_arrModel addObject:storeModel];
    
    _editModel = [SSBStoreMannagerEditModel editModelWIthModel:_model];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - tableView deleagte and sourcedata

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrModel.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 39)];
    view.backgroundColor  = kSSfbfbfb;
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 39)];
    lbl.textColor = kSS333333;
    lbl.font = kMeFont(14);
    SSBStoreMannagerInfoModel *model = _arrModel[section];
    lbl.text = kMeUnNilStr(model.title);
    [view addSubview:lbl];
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 39;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SSBStoreMannagerInfoModel *model = _arrModel[section];
    return model.arrModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSBStoreMannagerInfoModel *model = _arrModel[indexPath.section];
    SSBStoreMannagercontentInfoModel *subModel = model.arrModel[indexPath.row];
    SSBStoreMannagerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSBStoreMannagerCell class]) forIndexPath:indexPath];
    [cell setUiWithModel:subModel];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSBStoreMannagerInfoModel *model = _arrModel[indexPath.section];
    SSBStoreMannagercontentInfoModel *subModel = model.arrModel[indexPath.row];
    return [SSBStoreMannagerCell getCellHeightWithModel:subModel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSBStoreMannagerInfoModel *model = _arrModel[indexPath.section];
    SSBStoreMannagercontentInfoModel *subModel = model.arrModel[indexPath.row];
    if(subModel.type == SSBStoreMannagerInfoStoreNameType || subModel.type == SSBStoreMannagerInfoStoreTelType ||subModel.type == SSBStoreMannagerInfocodeIdType ||subModel.type == SSBStoreMannagerStoreIntoduceType ||subModel.type == SSBStoreMannagerInfoAddressType||subModel.type == SSBStoreMannagerInfodetailAddressType){
        kMeWEAKSELF
        if(subModel.type == SSBStoreMannagerInfoAddressType){
            ZHMapAroundInfoViewController *mapVC = [[ZHMapAroundInfoViewController alloc]init];
            mapVC.contentBlock = ^(ZHPlaceInfoModel *model) {
                kMeSTRONGSELF
                strongSelf.addrssModel.subTitle = kMeUnNilStr(model.address);
                strongSelf.dAddrssModel.subTitle = kMeUnNilStr(model.detailsAddress);
                strongSelf->_editModel.province = kMeUnNilStr(model.province);
                strongSelf->_editModel.city = kMeUnNilStr(model.city);
                strongSelf->_editModel.district = kMeUnNilStr(model.district);
                strongSelf->_editModel.address = kMeUnNilStr(model.detailsAddress);
                
                strongSelf->_editModel.latitude = @(model.coordinate.latitude).description;
                strongSelf->_editModel.longitude = @(model.coordinate.longitude).description;
                [strongSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:mapVC animated:YES];
        }else{
            SSBStoreMannagerEditInfoVC *infoVC = [[SSBStoreMannagerEditInfoVC alloc]initWithContent:subModel];
            infoVC.contenBlock = ^(NSString *text){
                kMeSTRONGSELF
                switch (subModel.type) {
                    case SSBStoreMannagerInfoStoreNameType:{
                        strongSelf->_editModel.store_name = text;
                    }
                    break;
                    case SSBStoreMannagerInfoStoreTelType:{
                        strongSelf->_editModel.mobile = text;
                    }
                        break;
                    case SSBStoreMannagerInfocodeIdType:{
                        strongSelf->_editModel.id_number = text;
                    }
                        break;
                    case SSBStoreMannagerStoreIntoduceType:{
                        strongSelf->_editModel.intro = text;
                    }
                        break;
                    case SSBStoreMannagerInfodetailAddressType:{
                        strongSelf->_editModel.address = text;
                    }
                        break;
                    default:
                        break;
                }
                [strongSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:infoVC animated:YES];
        }
    }
}

- (void)saveInfo:(UIButton *)btn{
    [SSPublicNetWorkTool postStroeFindStoreInfoWithEditModel:_editModel successBlock:^(ZLRequestResponse *responseObject) {
        
    } failure:^(id object) {
        
    }];
}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSBStoreMannagerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSBStoreMannagerCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIButton *)btnRight{
    if(!_btnRight){
        _btnRight= [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRight setTitle:@"保存" forState:UIControlStateNormal];
        [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnRight.backgroundColor = kSSPink;
        _btnRight.cornerRadius = 2;
        _btnRight.clipsToBounds = YES;
        _btnRight.frame = CGRectMake(0, 0, 63, 30);
        _btnRight.titleLabel.font = kMeFont(15);
        [_btnRight addTarget:self action:@selector(saveInfo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}


@end
