//
//  SSAddGoodVC.m
//  SunSum
//
//  Created by hank on 2019/3/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAddGoodVC.h"
#import "SSAddGoodBasicCell.h"
#import "SSAddGoodAssembleCell.h"
#import "SSAddGoodDivideCell.h"
#import "SSAddGoodGoodAttributeCell.h"
#import "SSGoodManngerSpecVC.h"
#import "SSAddGoodModel.h"
#import "SSAddGoodStoreGoodsTypeVC.h"
#import "SSAddGoodStoreGoodsType.h"
#import <TZImagePickerController.h>
#import "YBImageBrowser.h"
#import "SSGoodManngerAddSpecModel.h"
#import "SSGoodManngerGoodSpec.h"
#import "SSAddGoodDetailModel.h"
#import "SSGoodManngerStorePowerModel.h"
#import "MERichTextVC.h"

@interface SSAddGoodVC ()<UITableViewDelegate, UITableViewDataSource,TZImagePickerControllerDelegate,YBImageBrowserDataSource>{
    //0 good 1 hot 2rec
    NSInteger _type;
    NSString *_token;
    BOOL _isEdit;
    NSString *_productId;
    SSGoodManngerStorePowerModel *_powermodel;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *btnAdd;
@property (nonatomic, strong) SSAddGoodModel *addModel;
@property (nonatomic, strong) SSAddGoodGoodAttributeCell *cell;
@end

@implementation SSAddGoodVC

- (instancetype)initWithProductId:(NSString *)productId{
    if(self = [super init]){
        _isEdit = YES;
        _productId = productId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _isEdit?@"修改商品":@"添加商品";
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetStorePowerWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        strongSelf->_powermodel = [SSGoodManngerStorePowerModel mj_objectWithKeyValues:responseObject.data];
        if(strongSelf->_isEdit){
            [strongSelf initWithSomethingEdit];
        }else{
            [strongSelf initWithSomething];
        }
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];

}

- (void)initWithSomethingEdit{
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetStoreGoodsDetailWithProduct_id:_productId SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        if(![responseObject.data isKindOfClass:[NSDictionary class]]){
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
        SSAddGoodDetailModel *model = [SSAddGoodDetailModel mj_objectWithKeyValues:responseObject.data];
        SSAddGoodModel *addmodel = [SSAddGoodModel getModel];
        addmodel.list_order = kMeUnNilStr(model.list_order);
        addmodel.title = kMeUnNilStr(model.title);
        
        addmodel.desc = kMeUnNilStr(model.desc);
        addmodel.market_price = kMeUnNilStr(model.market_price);
        addmodel.money = kMeUnNilStr(model.money);
        addmodel.postage = kMeUnNilStr(model.postage);
        
        addmodel.store_product_type = model.store_product_type;
        addmodel.ratio_after_sales = model.ratio_after_sales;
        addmodel.ratio_marketing = model.ratio_marketing;
        addmodel.ratio_store = model.ratio_store;
        
        //拼团
        addmodel.group_num =kMeUnNilStr(model.group.group_num);
        addmodel.over_time = kMeUnNilStr(model.group.over_time);
        addmodel.red_packet = kMeUnNilStr(model.group.red_packet);
        addmodel.start_time = kMeUnNilStr(model.group.start_time);
        addmodel.end_time = kMeUnNilStr(model.group.end_time);
        
        
        addmodel.images = kMeUnNilStr(model.images);
        addmodel.images_hot = kMeUnNilStr(model.images_hot);
        addmodel.image_rec = kMeUnNilStr(model.image_rec);
        addmodel.keywords = kMeUnNilStr(model.keywords);
        
        
        addmodel.product_position = model.state;
        addmodel.state = model.state;
        addmodel.is_new = model.is_new;
        addmodel.is_hot = model.is_hot;
        addmodel.is_recommend = model.is_recommend;
        addmodel.is_clerk_share = model.is_clerk_share;
        addmodel.restrict_num = kMeUnNilStr(model.restrict_num);
        addmodel.category_id = model.category_id;
        addmodel.category = kMeUnNilStr(model.category_name);
        
        addmodel.content = kMeUnNilStr(model.content);
        addmodel.product_id = strongSelf->_productId;
        __block NSMutableArray *arrSpec = [NSMutableArray array];
        //            __block NSMutableArray *arrSpecTrueName = [NSMutableArray array];
        //            __block NSMutableArray *arrSpecTrueID = [NSMutableArray array];
        [model.spec_name enumerateObjectsUsingBlock:^(SSAddGoodDetailSpecNameModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SSGoodManngerGoodSpec *spec = [SSGoodManngerGoodSpec new];
            spec.spec_name = kMeUnNilStr(obj.name);
            spec.idField = kMeUnNilStr(obj.key);
            //                [arrSpecTrueName addObject:kMeUnNilStr(obj.name)];
            
            //                spec.specContent = kMeUnNilStr(obj.value);
            [arrSpec addObject:spec];
        }];
        addmodel.arrSpec = [NSMutableArray arrayWithArray:arrSpec];
        
        __block NSMutableArray *arrAddSpec = [NSMutableArray array];
        [model.spec_ids enumerateObjectsUsingBlock:^(SSAddGoodDetailSpecIdsModel *obj, NSUInteger idxx, BOOL * _Nonnull stop) {
            SSGoodManngerAddSpecModel *addspecModel = [SSGoodManngerAddSpecModel new];
            addspecModel.saleIntegral = obj.integral;
            addspecModel.shareIntegral = obj.shop_integral;
            addspecModel.price = obj.goods_price;
            addspecModel.stock = obj.stock;
            addspecModel.sepc_img = obj.spec_img;
            __block NSMutableArray *arrSpecc = [NSMutableArray array];
            [obj.spec_ids_value enumerateObjectsUsingBlock:^(SSAddGoodDetailSpecIdsValueModel *objvalue, NSUInteger idx, BOOL * _Nonnull stop) {
                SSGoodManngerGoodSpec *specModel = [SSGoodManngerGoodSpec new];
                SSGoodManngerGoodSpec *sssModel = arrSpec[idx];
                specModel.spec_name = kMeUnNilStr(sssModel.spec_name);
                specModel.idField = kMeUnNilStr(sssModel.idField);
                specModel.specContent = kMeUnNilStr(objvalue.value);
                [arrSpecc addObject:specModel];
            }];
            addspecModel.arrSpec = [NSMutableArray arrayWithArray:arrSpecc];;
            [arrAddSpec addObject:addspecModel];
        }];
        addmodel.arrAddSpec = [NSMutableArray arrayWithArray:arrAddSpec];
        strongSelf.addModel = addmodel;
        [strongSelf initWithSomething];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)initWithSomething{
    [self.view addSubview:self.tableView];
    UIView *viewForBottom = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-67, SCREEN_WIDTH, 67)];
    _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnAdd.frame = CGRectMake(16, 10, SCREEN_WIDTH-32, 47);
    _btnAdd.backgroundColor = kSSPink;
    [_btnAdd setTitle:@"保存" forState:UIControlStateNormal];
    _btnAdd.cornerRadius =2;
    _btnAdd.clipsToBounds = YES;
    [_btnAdd addTarget:self action:@selector(addGoodAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewForBottom addSubview:_btnAdd];
    [self.view addSubview:viewForBottom];
    kMeWEAKSELF
    MBProgressHUD *HUD = [SSPublicNetWorkTool commitWithHUD:@""];
    [SSPublicNetWorkTool postgetQiuNiuTokkenWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        [HUD hideAnimated:YES];
        strongSelf->_token = responseObject.data[@"token"];
    } failure:^(id object) {
        kMeSTRONGSELF
        [HUD hideAnimated:YES];
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];

}

- (void)addGoodAction:(UIButton *)btn{
    [self.view endEditing:YES];
    if(!kMeUnNilStr(self.addModel.list_order).length){
        [SSShowViewTool showMessage:@"排序不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.addModel.title).length){
        [SSShowViewTool showMessage:@"商品名称不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.addModel.desc).length){
        [SSShowViewTool showMessage:@"商品描述不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.addModel.market_price).length){
        [SSShowViewTool showMessage:@"市场价格不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.addModel.money).length){
        [SSShowViewTool showMessage:@"现价不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.addModel.postage).length){
        [SSShowViewTool showMessage:@"邮费不能为空" view:kMeCurrentWindow];
        return;
    }
    if(self.addModel.store_product_type == 7){
        if(!kMeUnNilStr(self.addModel.group_num).length){
            [SSShowViewTool showMessage:@"拼团人数不能为空" view:kMeCurrentWindow];
            return;
        }
        if(!kMeUnNilStr(self.addModel.over_time).length){
            [SSShowViewTool showMessage:@"拼团结束时间不能为空" view:kMeCurrentWindow];
            return;
        }
        if(!kMeUnNilStr(self.addModel.red_packet).length){
            [SSShowViewTool showMessage:@"平团成功红包金额不能为空" view:kMeCurrentWindow];
            return;
        }
        if(!kMeUnNilStr(self.addModel.start_time).length){
            [SSShowViewTool showMessage:@"开始时间不能为空" view:kMeCurrentWindow];
            return;
        }
        if(!kMeUnNilStr(self.addModel.end_time).length){
            [SSShowViewTool showMessage:@"结束时间不能为空" view:kMeCurrentWindow];
            return;
        }
        
        if(![SSCommonTool compareOneDay:self.addModel.end_time withAnotherDay:self.addModel.start_time]){
            [SSShowViewTool showMessage:@"拼团开始时间不能大于结束时间" view:kMeCurrentWindow];
            return;
        }
        
    }
    
    if(_powermodel.is_brokerage == 1){
        CGFloat alldivide = self.addModel.ratio_store + self.addModel.ratio_marketing + self.addModel.ratio_after_sales;
        if(alldivide>100){
            [SSShowViewTool showMessage:@"分成相加不能大于100" view:kMeCurrentWindow];
            return;
        }
    }

    if(!kMeUnNilStr(self.addModel.keywords).length){
        [SSShowViewTool showMessage:@"关键词不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.addModel.restrict_num).length){
        [SSShowViewTool showMessage:@"限制购买个数不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.addModel.category).length){
        [SSShowViewTool showMessage:@"商品分类不能为空" view:kMeCurrentWindow];
        return;
    }
    
    if(self.addModel.arrSpec.count == 0){
        [SSShowViewTool showMessage:@"请选择规格" view:kMeCurrentWindow];
        return;
    }
    __block BOOL isreturn = NO;
    [self.addModel.arrAddSpec enumerateObjectsUsingBlock:^(SSGoodManngerAddSpecModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __block BOOL iserror = NO;
        [obj.arrSpec enumerateObjectsUsingBlock:^(SSGoodManngerGoodSpec *objSpec, NSUInteger idx, BOOL * _Nonnull stopspec) {
            if(!kMeUnNilStr(objSpec.specContent).length){
                [SSShowViewTool showMessage:@"请输入完整规格规格" view:kMeCurrentWindow];
                iserror = YES;
                isreturn = YES;
                *stopspec = YES;
            }
        }];
        if(iserror){
            isreturn = YES;
            *stop = YES;
        }
        if(!kMeUnNilStr(obj.stock).length){
            [SSShowViewTool showMessage:@"请输入完整规格规格" view:kMeCurrentWindow];
            isreturn = YES;
            *stop = YES;
        }
        if(!kMeUnNilStr(obj.price).length){
            [SSShowViewTool showMessage:@"请输入完整规格规格" view:kMeCurrentWindow];
            isreturn = YES;
            *stop = YES;
        }
        if(!kMeUnNilStr(obj.shareIntegral).length){
            [SSShowViewTool showMessage:@"请输入完整规格规格" view:kMeCurrentWindow];
            isreturn = YES;
            *stop = YES;
        }
        if(!kMeUnNilStr(obj.saleIntegral).length){
            [SSShowViewTool showMessage:@"请输入完整规格规格" view:kMeCurrentWindow];
            isreturn = YES;
            *stop = YES;
        }
    }];
    
    if(isreturn){
        return;
    }
    __block NSMutableArray *arrSpecName = [NSMutableArray array];
    [self.addModel.arrSpec enumerateObjectsUsingBlock:^(SSGoodManngerGoodSpec *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SSAddGoodspecNameModel *specNameModel = [SSAddGoodspecNameModel new];
        specNameModel.key = kMeUnNilStr(obj.idField);
        __block NSMutableArray *arrValue = [NSMutableArray array];
        [self.addModel.arrAddSpec enumerateObjectsUsingBlock:^(SSGoodManngerAddSpecModel *addobj, NSUInteger idx, BOOL * _Nonnull stopadd) {
            [addobj.arrSpec enumerateObjectsUsingBlock:^(SSGoodManngerGoodSpec *addSpecobj, NSUInteger idx, BOOL * _Nonnull stopaddspec) {
                if([obj.idField isEqualToString:addSpecobj.idField]){
                    [arrValue addObject:addSpecobj.specContent];
                    *stopaddspec = YES;
                }
            }];
        }];
        specNameModel.value = [NSArray arrayWithArray:arrValue];
        NSDictionary *dic = [specNameModel mj_keyValues];
        [arrSpecName addObject:dic];
    }];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrSpecName
                                                       options:kNilOptions
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    self.addModel.spec_name = jsonString;
    
    __block NSMutableArray *arrjson = [NSMutableArray array];
    [self.addModel.arrAddSpec enumerateObjectsUsingBlock:^(SSGoodManngerAddSpecModel *addobj, NSUInteger idx, BOOL * _Nonnull stopadd) {
        SSAddGoodspecJsoneModel *jsonModel = [SSAddGoodspecJsoneModel new];
        __block NSMutableArray *arrvalue = [NSMutableArray new];
        [addobj.arrSpec enumerateObjectsUsingBlock:^(SSGoodManngerGoodSpec *addSpecobj, NSUInteger idx, BOOL * _Nonnull stopaddspec) {
            [arrvalue addObject:kMeUnNilStr(addSpecobj.specContent)];
        }];
        jsonModel.value = [arrvalue componentsJoinedByString:@","];
        jsonModel.goods_price = addobj.price;
        jsonModel.stock = addobj.stock;
        jsonModel.integral = addobj.saleIntegral;
        jsonModel.shop_integral = addobj.shareIntegral;
        jsonModel.spec_img = addobj.sepc_img;
        NSDictionary *dic = [jsonModel mj_keyValues];

        [arrjson addObject:dic];
    }];
    
    NSData *jsonDatajson = [NSJSONSerialization dataWithJSONObject:arrjson
                                                       options:kNilOptions
                                                         error:&error];
    NSString *jsonStringjson = [[NSString alloc] initWithData:jsonDatajson
                                                 encoding:NSUTF8StringEncoding];
    self.addModel.spec_json = jsonStringjson;
    kMeWEAKSELF
    [SSPublicNetWorkTool postcommonAddOrEditGoodsWithParModel:self.addModel successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        kMeCallBlock(strongSelf.finishAddBlock);
        [strongSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(id object) {
        
    }];
    
}

- (void)dealActionWithType:(NSInteger)type{
    _type = type;
    switch (type) {
        case 0:{
            NSString *imgStr = self.addModel.images;
            [self delaActionWithModel:imgStr];
        }
            break;
        case 1:{
            NSString *imgHotStr = self.addModel.images_hot;
            [self delaActionWithModel:imgHotStr];
        }
            break;
        case 2:{
            NSString *imgRecStr = self.addModel.image_rec;
            [self delaActionWithModel:imgRecStr];
        }
            break;
        default:
            break;
    }
}

- (void)delaActionWithModel:(NSString *)model{
    NSString *str = kMeUnNilStr(model);
    if(str.length == 0){
        kMeWEAKSELF
        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
        imagePicker.allowPickingOriginalPhoto = NO;
        imagePicker.allowPickingVideo = NO;
        [imagePicker setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
            kMeSTRONGSELF
            for (int i = 0; i < assets.count; i ++) {
                PHAsset *phAsset = assets[i];
                if (phAsset.mediaType == PHAssetMediaTypeImage) {
                    UIImage *image = photos[i];
//                    SSBynamicPublishGridModel *gmodel = [SSBynamicPublishGridModel modelWithImage:image isAdd:NO];
                    NSString *filename = [phAsset valueForKey:@"filename"];
                    NSString *path = [SSCommonTool getImagePath:image filename:filename];
                    MBProgressHUD *HUD = [SSPublicNetWorkTool commitWithHUD:@""];

                    [SSPublicNetWorkTool postQiNiuUpFileWithToken:strongSelf->_token filePath:path successBlock:^(id object) {
                        NSLog(@"%@",object);
                        if([object isKindOfClass:[NSDictionary class]]){
                            NSString *key = kMeUnNilStr(object[@"key"]);
                            switch (strongSelf->_type) {
                                case 0:{
                                    strongSelf->_addModel.images = key;
                                }
                                    break;
                                case 1:{
                                    strongSelf->_addModel.images_hot = key;
                                }
                                    break;
                                case 2:{
                                    strongSelf->_addModel.image_rec = key;
                                }
                                    break;
                                default:
                                    break;
                            }
                            
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            kMeSTRONGSELF
                           [strongSelf->_cell setUIWithModel:strongSelf->_addModel];
                        });
                        [HUD hideAnimated:YES];
                    } failure:^(id object) {
                        [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"图片上传失败"];
                        
                    }];
                }
            }
        }];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
        [self showPhotoWithModel:str];
    }
}

- (void)showPhotoWithModel:(NSString*)model{
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSource = self;
    browser.currentIndex = 0;
    [browser show];
}

- (NSUInteger)yb_numberOfCellForImageBrowserView:(YBImageBrowser *)imageBrowser {
    return 1;
}

- (id<YBImageBrowserCellDataProtocol>)yb_imageBrowserView:(YBImageBrowserView *)imageBrowserView dataForCellAtIndex:(NSUInteger)index {
    YBImageBrowseCellData *model = [YBImageBrowseCellData new];
    switch (_type) {
        case 0:{
            NSString *imgStr = SSLoadQiniuImagesWithUrl(self.addModel.images);
            model.url = [NSURL URLWithString:imgStr];
            model.sourceObject = _cell.imgGood;
        }
            break;
        case 1:{
            NSString *imgHotStr = SSLoadQiniuImagesWithUrl(self.addModel.images_hot);
            model.url = [NSURL URLWithString:imgHotStr];
            model.sourceObject = _cell.imgGoodHot;

        }
            break;
        case 2:{
            NSString *imgRecStr = SSLoadQiniuImagesWithUrl(self.addModel.image_rec);
            model.url = [NSURL URLWithString:imgRecStr];
            model.sourceObject = _cell.imgRecommend;
        }
            break;
        default:
            break;
    }
    return model;
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        SSAddGoodBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAddGoodBasicCell class]) forIndexPath:indexPath];
        [cell setUIWithModel:self.addModel];
        kMeWEAKSELF
        cell.selectType = ^{
            kMeSTRONGSELF
            [strongSelf.tableView reloadData];
        };
        cell.selectGoodType = ^{
            kMeSTRONGSELF
            SSAddGoodStoreGoodsTypeVC *vc = [[SSAddGoodStoreGoodsTypeVC alloc]init];
            vc.blcok = ^(SSAddGoodStoreGoodsType *model) {
                strongSelf.addModel.category_id = model.idField;
                strongSelf.addModel.category = model.category_name;
                [strongSelf.tableView reloadData];
            };
            [strongSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else if(indexPath.row == 1){
        if(self.addModel.store_product_type == 1){
            return [UITableViewCell new];
        }else{
            SSAddGoodAssembleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAddGoodAssembleCell class]) forIndexPath:indexPath];
            [cell setUIWithModel:self.addModel];
            return cell;
        }
    }else if(indexPath.row == 2){
        if(_powermodel.is_brokerage == 1){
            SSAddGoodDivideCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAddGoodDivideCell class]) forIndexPath:indexPath];
            [cell setUIWithModel:self.addModel];
            return cell;
        }else{
            return [UITableViewCell new];
        }
    }else if(indexPath.row == 3){
        _cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSAddGoodGoodAttributeCell class]) forIndexPath:indexPath];
        [_cell setUIWithModel:self.addModel];
        kMeWEAKSELF
        _cell.selectSpecBlock = ^{
            kMeSTRONGSELF
            SSGoodManngerSpecVC *vc = [[SSGoodManngerSpecVC alloc]initWithModel:strongSelf.addModel];
            vc.token = strongSelf->_token;
            vc.finishBlcok = ^{
                [strongSelf.tableView reloadData];
            };
            [strongSelf.navigationController pushViewController:vc animated:YES];
        };
        _cell.selectImgBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            [strongSelf dealActionWithType:index];
        };
        _cell.selectRichEditBlock = ^{
            kMeSTRONGSELF
            MERichTextVC *vc = [[MERichTextVC alloc]init];
            vc.model = strongSelf.addModel;
            vc.token = strongSelf->_token;
            vc.finishBlcok = ^{
                [strongSelf.tableView reloadData];
            };
            [strongSelf.navigationController pushViewController:vc animated:YES];
        };
        return _cell;
    }else{
        return [UITableViewCell new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        return kSSAddGoodBasicCellHeight;
    }else if(indexPath.row == 1){
        if(self.addModel.store_product_type == 1){
            return 0.1;
        }else{
            return kSSAddGoodAssembleCellHeight;
        }
    }else if(indexPath.row == 2){
        if(_powermodel.is_brokerage == 1){
            return kSSAddGoodDivideCellHeight;
        }else{
            return 0.1;
        }
    }else if(indexPath.row == 3){
        return kSSAddGoodGoodAttributeCellHeight;
    }else{
        return 0.1;
    }
}


#pragma mark - Set And Get

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-67) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAddGoodBasicCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAddGoodBasicCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAddGoodAssembleCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAddGoodAssembleCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAddGoodDivideCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAddGoodDivideCell class])];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSAddGoodGoodAttributeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSAddGoodGoodAttributeCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];;
    }
    return _tableView;
}

- (SSAddGoodModel *)addModel{
    if(!_addModel){
        _addModel = [SSAddGoodModel getModel];
    }
    return _addModel;
}

@end
