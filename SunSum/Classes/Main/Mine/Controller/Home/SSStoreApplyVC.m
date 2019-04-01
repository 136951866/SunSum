//
//  SSStoreApplyVC.m
//  SunSum
//
//  Created by hank on 2019/3/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSStoreApplyVC.h"
#import "SSStoreApplyView.h"
#import "SSStoreApplyParModel.h"
#import <TZImagePickerController.h>
#import "YBImageBrowser.h"
#import "ZHMapAroundInfoViewController.h"
#import "ZHPlaceInfoModel.h"
#import "SSStoreApplyStatusVC.h"
#import "SSStoreApplyModel.h"

@interface SSStoreApplyVC ()<UIScrollViewDelegate,TZImagePickerControllerDelegate,YBImageBrowserDataSource>{
    SSStoreApplyViewImgType _type;
    NSString *_token;
    BOOL _isError;
}
@property (nonatomic, strong) SSStoreApplyView *cview;
@property (nonatomic, strong) UIScrollView *scrollerView;

@end

@implementation SSStoreApplyVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"门店申请";
    _isError = NO;
    MBProgressHUD *HUD = [SSPublicNetWorkTool commitWithHUD:@""];
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetQiuNiuTokkenWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeSTRONGSELF
        strongSelf->_token = responseObject.data[@"token"];
        [strongSelf.view addSubview:self.scrollerView];
        [strongSelf.scrollerView addSubview:self.cview];
    } failure:^(id object) {
        [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)submitAction{
    if(!kMeUnNilStr(self.parModel.true_name).length){
        [SSShowViewTool showMessage:@"名字不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.parModel.id_number).length){
        [SSShowViewTool showMessage:@"身份证不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.parModel.cellphone).length){
        [SSShowViewTool showMessage:@"手机号不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.parModel.name).length){
        [SSShowViewTool showMessage:@"登录名不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.parModel.store_name).length){
        [SSShowViewTool showMessage:@"店铺名称不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.parModel.mobile).length){
        [SSShowViewTool showMessage:@"店铺电话不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.parModel.intro).length){
        [SSShowViewTool showMessage:@"店铺简介不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.parModel.province).length){
        [SSShowViewTool showMessage:@"地址不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(self.parModel.address).length){
        [SSShowViewTool showMessage:@"详情地址不能为空" view:kMeCurrentWindow];
        return;
    }
    SSBynamicPublishGridModel *business_imagesModel = self.parModel.business_imagesModel;
    if(business_imagesModel.isAdd){
        [SSShowViewTool showMessage:@"请上传营业执照" view:kMeCurrentWindow];
        return;
    }
    SSBynamicPublishGridModel *mask_imgModel = self.parModel.mask_imgModel;
    if(mask_imgModel.isAdd){
        [SSShowViewTool showMessage:@"请上传店铺封面" view:kMeCurrentWindow];
        return;
    }
    SSBynamicPublishGridModel *mask_info_imgModel = self.parModel.mask_info_imgModel;
    if(mask_info_imgModel.isAdd){
        [SSShowViewTool showMessage:@"请上传店铺详情" view:kMeCurrentWindow];
        return;
    }
    
    _isError = NO;
    kMeWEAKSELF
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    MBProgressHUD *hub =  [SSPublicNetWorkTool commitWithHUD:@"提交中"];
    dispatch_group_async(group, queue, ^{
        kMeSTRONGSELF
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
   
        [SSPublicNetWorkTool postQiNiuUpFileWithToken:strongSelf->_token filePath:self.parModel.business_imagesModel.filePath successBlock:^(id object) {
            NSLog(@"%@",object);
            if([object isKindOfClass:[NSDictionary class]]){
                strongSelf.parModel.business_images = kMeUnNilStr(object[@"key"]);
            }else{
                strongSelf->_isError = YES;
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            strongSelf->_isError = YES;
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        [SSPublicNetWorkTool postQiNiuUpFileWithToken:strongSelf->_token filePath:self.parModel.mask_imgModel.filePath successBlock:^(id object) {
            NSLog(@"%@",object);
            if([object isKindOfClass:[NSDictionary class]]){
                strongSelf.parModel.mask_img = kMeUnNilStr(object[@"key"]);
            }else{
                strongSelf->_isError = YES;
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            strongSelf->_isError = YES;
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        [SSPublicNetWorkTool postQiNiuUpFileWithToken:strongSelf->_token filePath:self.parModel.mask_info_imgModel.filePath successBlock:^(id object) {
            NSLog(@"%@",object);
            if([object isKindOfClass:[NSDictionary class]]){
                strongSelf.parModel.mask_info_img = kMeUnNilStr(object[@"key"]);
            }else{
                strongSelf->_isError = YES;
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(id object) {
            strongSelf->_isError = YES;
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kMeSTRONGSELF
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!strongSelf->_isError){
                [hub hideAnimated:YES];
                [SSPublicNetWorkTool postStoreApplyWithModel:strongSelf.parModel SuccessBlock:^(ZLRequestResponse *responseObject) {
                    SSStoreApplyStatusVC *vc = [[SSStoreApplyStatusVC alloc]init];
                    SSStoreApplyModel *model = [SSStoreApplyModel new];
                    model.state = 1;
                    vc.model = model;
                    [strongSelf.navigationController pushViewController:vc animated:YES];
                } failure:^(id object) {
                }];
            }else{
                [SSShowViewTool SHOWHUDWITHHUD:hub test:@"图片上传失败"];
            }
        });
    });
    
}

- (void)dealActionWithType:(SSStoreApplyViewImgType )type{
    _type = type;
    switch (type) {
        case SSStoreApplyViewImgBusinnessType:{
            //营业执照
            SSBynamicPublishGridModel *business_imagesModel = self.parModel.business_imagesModel;
            [self delaActionWithModel:business_imagesModel];
        }
            break;
        case SSStoreApplyViewImgMaskType:{
            //店铺封面上传
            SSBynamicPublishGridModel *mask_imgModel = self.parModel.mask_imgModel;
            [self delaActionWithModel:mask_imgModel];
        }
            break;
        case SSStoreApplyViewImgMaskInfoType:{
            //店铺详情上传
            SSBynamicPublishGridModel *mask_info_imgModel = self.parModel.mask_info_imgModel;
            [self delaActionWithModel:mask_info_imgModel];
        }
            break;
        default:
            break;
    }
}

- (void)delaActionWithModel:(SSBynamicPublishGridModel *)model{
    if(model.isAdd){
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
                    SSBynamicPublishGridModel *gmodel = [SSBynamicPublishGridModel modelWithImage:image isAdd:NO];
                    NSString *filename = [phAsset valueForKey:@"filename"];
                    gmodel.filePath = [SSCommonTool getImagePath:image filename:filename];
                    switch (strongSelf->_type) {
                        case SSStoreApplyViewImgBusinnessType:{
                            //营业执照
                            strongSelf.parModel.business_imagesModel = gmodel;
                        }
                            break;
                        case SSStoreApplyViewImgMaskType:{
                            //店铺封面上传
                            strongSelf.parModel.mask_imgModel = gmodel;
                        }
                            break;
                        case SSStoreApplyViewImgMaskInfoType:{
                            //店铺详情上传
                            strongSelf.parModel.mask_info_imgModel = gmodel;
                        }
                            break;
                        default:
                            break;
                    }
                }
            }
            [strongSelf.cview reloadUI];
        }];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
        [self showPhotoWithModel:model];
    }
}

- (void)showPhotoWithModel:(SSBynamicPublishGridModel*)model{
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSource = self;
    browser.currentIndex = 0;
    [browser show];
}

- (NSUInteger)yb_numberOfCellForImageBrowserView:(YBImageBrowser *)imageBrowser {
    return 1;
}
- (id<YBImageBrowserCellDataProtocol>)yb_imageBrowserView:(YBImageBrowserView *)imageBrowserView dataForCellAtIndex:(NSUInteger)index {
    YBImageBrowseCellData *data = [YBImageBrowseCellData new];
    switch (_type) {
        case SSStoreApplyViewImgBusinnessType:{
            SSBynamicPublishGridModel *business_imagesModel = self.parModel.business_imagesModel;
                data.imageBlock = ^__kindof UIImage * _Nullable{
                    return business_imagesModel.image;
                };
            data.sourceObject = self.cview.imgbusiness;
        }
            break;
        case SSStoreApplyViewImgMaskType:{
            SSBynamicPublishGridModel *mask_imgModel = self.parModel.mask_imgModel;
            data.imageBlock = ^__kindof UIImage * _Nullable{
                return mask_imgModel.image;
            };
            data.sourceObject = mask_imgModel.image;
        }
            break;
        case SSStoreApplyViewImgMaskInfoType:{
            SSBynamicPublishGridModel *mask_info_imgModel = self.parModel.mask_info_imgModel;
            data.imageBlock = ^__kindof UIImage * _Nullable{
                return mask_info_imgModel.image;
            };
            data.sourceObject = mask_info_imgModel.image;
        }
            break;
        default:
            break;
    }
    return data;
}

- (UIImageView *)imageViewOfTouchForImageBrowser:(YBImageBrowser *)imageBrowser {
    switch (_type) {
        case SSStoreApplyViewImgBusinnessType:{
            return self.cview.imgbusiness;
        }
            break;
        case SSStoreApplyViewImgMaskType:{
            return self.cview.imgMask;

        }
            break;
        case SSStoreApplyViewImgMaskInfoType:{
            return self.cview.imgMaskInfo;
        }
            break;
        default:
            return [UIImageView new];
            break;
    }
}

- (SSStoreApplyParModel *)parModel{
    if(!_parModel){
        _parModel = [SSStoreApplyParModel getModel];
    }
    return _parModel;
}

- (UIScrollView *)scrollerView{
    if(!_scrollerView){
        _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight)];
        _scrollerView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _scrollerView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithHexString:@"fbfbfb"];
        _scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, kSSStoreApplyViewHeight);
        _scrollerView.bounces = YES;
        _scrollerView.showsVerticalScrollIndicator =NO;
        _scrollerView.delegate = self;
    }
    return _scrollerView;
}

- (SSStoreApplyView *)cview{
    if(!_cview){
        _cview = [[[NSBundle mainBundle]loadNibNamed:@"SSStoreApplyView" owner:nil options:nil] lastObject];
        _cview.frame = CGRectMake(0, 0, SCREEN_WIDTH, kSSStoreApplyViewHeight);
        _cview.model = self.parModel;
        kMeWEAKSELF
        _cview.selectImgBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            [strongSelf dealActionWithType:index];

        };
        _cview.locationBlock = ^{
            kMeSTRONGSELF
            ZHMapAroundInfoViewController *mapVC = [[ZHMapAroundInfoViewController alloc]init];
            mapVC.contentBlock = ^(ZHPlaceInfoModel *model) {
                kMeSTRONGSELF
                strongSelf.parModel.latitude = @(model.coordinate.latitude).description;
                strongSelf.parModel.longitude = @(model.coordinate.latitude).description;
                strongSelf.parModel.province = kMeUnNilStr(model.province);
                strongSelf.parModel.city = kMeUnNilStr(model.city);
                strongSelf.parModel.district = kMeUnNilStr(model.district);
                strongSelf.parModel.address = kMeUnNilStr(model.detailsAddress);
                
                [strongSelf.cview reloadUI];
            };
            [strongSelf.navigationController pushViewController:mapVC animated:YES];
        };
        _cview.applyBlock = ^{
            kMeSTRONGSELF
            [strongSelf submitAction];
        };
        
        [_cview reloadUI];
    }
    return _cview;
}


@end
