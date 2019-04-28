//
//  MEBrandStoryVC.m
//  ME时代
//
//  Created by hank on 2019/4/26.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBrandStoryVC.h"
#import "MEBrandStoryHeaderView.h"
#import "MEBrandStoryModel.h"
#import "SSPushContentVC.h"
#import "SSBrandStoryContentCell.h"
#import <TZImagePickerController.h>
#import "SSBasePlayerVC.h"
#import "ZHMapAroundInfoViewController.h"
#import "ZHPlaceInfoModel.h"
#import "MEBrandStoryDetailModel.h"
#import "YBImageBrowser.h"

@interface MEBrandStoryVC ()<UITableViewDelegate,UITableViewDataSource,MEBrandStoryHeaderViewDelegate,TZImagePickerControllerDelegate,YBImageBrowserDataSource>{
    MEBrandStoryModel *_model;
    NSString *_token;
    NSInteger _currentPicIndex;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MEBrandStoryHeaderView         *headerView;
@property (nonatomic, strong) UIButton *btnSave;
@end

@implementation MEBrandStoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"品牌故事";
    _currentPicIndex = 0;
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetcommonbrandstorybrandStoryWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        if([responseObject.data isKindOfClass:[NSDictionary class]]){
            MEBrandStoryDetailModel *model = [MEBrandStoryDetailModel mj_objectWithKeyValues:responseObject.data];
            strongSelf->_model = [MEBrandStoryModel new];
            strongSelf->_model.token = kMeUnNilStr(kCurrentUser.token);
            strongSelf->_model.header_mediamodel = model.header_media;
            strongSelf->_model.title = kMeUnNilStr(model.title);
            strongSelf->_model.business_time = kMeUnNilStr(model.business_time);
            strongSelf->_model.phone = kMeUnNilStr(model.phone);
            strongSelf->_model.province = kMeUnNilStr(model.province);
            strongSelf->_model.city = kMeUnNilStr(model.city);
            strongSelf->_model.area = kMeUnNilStr(model.area);
            strongSelf->_model.address = kMeUnNilStr(model.address);
            strongSelf->_model.arrdata = [NSMutableArray arrayWithArray:kMeUnArr(model.content)];
            strongSelf->_model.latitude = kMeUnNilStr(model.latitude);
            strongSelf->_model.longitude = kMeUnNilStr(model.longitude);
        }else{
            strongSelf->_model = [MEBrandStoryModel new];
            strongSelf->_model.token = kMeUnNilStr(kCurrentUser.token);
        }
        [strongSelf initSomeThing];
    } failure:^(id object) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
    // Do any additional setup after loading the view.
}

- (void)initSomeThing{
    kMeWEAKSELF
    MBProgressHUD *HUD = [SSPublicNetWorkTool commitWithHUD:@""];
    [SSPublicNetWorkTool postgetForEvenQiuNiuTokkenWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        [HUD hideAnimated:YES];
        strongSelf->_token = responseObject.data[@"token"];
        [strongSelf.view addSubview:strongSelf.tableView];
        [strongSelf.headerView setUiWithModel:strongSelf->_model];
        [strongSelf.view addSubview:[strongSelf getBottomView]];
    } failure:^(id object) {
        kMeSTRONGSELF
        [HUD hideAnimated:YES];
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)saveAction:(UIButton *)btn{
    if(_model.header_mediamodel == nil){
        [SSShowViewTool showMessage:@"头部视频或图片不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(_model.title).length){
        [SSShowViewTool showMessage:@"标题不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(_model.business_time).length){
        [SSShowViewTool showMessage:@"营业时间不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(_model.phone).length){
        [SSShowViewTool showMessage:@"商家电话不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(_model.province).length){
        [SSShowViewTool showMessage:@"地址不能为空" view:kMeCurrentWindow];
        return;
    }
    if(!kMeUnNilStr(_model.address).length){
        [SSShowViewTool showMessage:@"详细地址不能为空" view:kMeCurrentWindow];
        return;
    }
    kMeWEAKSELF
    [SSPublicNetWorkTool postgetbrandstoryeditOrCreateBrandStorytWithmodel:_model SuccessBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(id object) {

    }];
}

#pragma mark - MEBrandStoryHeaderViewDelegate

- (void)uploadVideo{
    SSCustomActionSheet *sheet = [[SSCustomActionSheet alloc]initWithTitles:@[@"上传视频",@"上传图片"]];
    kMeWEAKSELF
    sheet.blockBtnTapHandle = ^(NSInteger index){
        kMeSTRONGSELF
        if(index == 0){
            [strongSelf addActionWithType:MEBrandStoryContentModelVideoType atIndex:0 isHeader:YES];
        }else{
            [strongSelf addActionWithType:MEBrandStoryContentModelPicType atIndex:0 isHeader:YES];
        }
    };
    [sheet show];
}

- (void)tapTimeAction{
    SSPushContentVC *vc =[[SSPushContentVC alloc]init];
    vc.title = @"营业时间";
    vc.content = kMeUnNilStr(_model.business_time);
    kMeWEAKSELF
    vc.textBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_model.business_time = kMeUnNilStr(str);
        [strongSelf.headerView setUiWithModel:strongSelf->_model];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tapTelAction{
    SSPushContentVC *vc =[[SSPushContentVC alloc]init];
    vc.title = @"商家电话";
    vc.content = kMeUnNilStr(_model.phone);
    vc.isNum = YES;
    kMeWEAKSELF
    vc.textBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_model.phone = kMeUnNilStr(str);
        [strongSelf.headerView setUiWithModel:strongSelf->_model];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tapAddressAction{
    kMeWEAKSELF
    ZHMapAroundInfoViewController *mapVC = [[ZHMapAroundInfoViewController alloc]init];
    mapVC.contentBlock = ^(ZHPlaceInfoModel *model) {
        kMeSTRONGSELF
        strongSelf->_model.latitude = @(model.coordinate.latitude).description;
        strongSelf->_model.longitude = @(model.coordinate.latitude).description;
        strongSelf->_model.province = kMeUnNilStr(model.province);
        strongSelf->_model.city = kMeUnNilStr(model.city);
        strongSelf->_model.address = kMeUnNilStr(model.detailsAddress);
        [strongSelf.headerView setUiWithModel:strongSelf->_model];
    };
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)tapdetailAddressAction{
    SSPushContentVC *vc =[[SSPushContentVC alloc]init];
    vc.title = @"详细地址";
    vc.content = kMeUnNilStr(_model.address);
    kMeWEAKSELF
    vc.textBlock = ^(NSString *str) {
        kMeSTRONGSELF
        strongSelf->_model.address = kMeUnNilStr(str);
        [strongSelf.headerView setUiWithModel:strongSelf->_model];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addActionWithType:(NSInteger)type{
    [self addActionWithType:type atIndex:0 isHeader:NO];
}

- (void)addActionWithType:(NSInteger)type atIndex:(NSInteger)atIndex isHeader:(BOOL)isHeader{
    if(type == MEBrandStoryContentModelTXTType){
        SSPushContentVC *vc =[[SSPushContentVC alloc]init];
        vc.title = @"添加文字";
        vc.content = @"";
        kMeWEAKSELF
        vc.textBlock = ^(NSString *str) {
            kMeSTRONGSELF
            MEBrandStoryContentModel *model  = [MEBrandStoryContentModel new];
            model.type =  MEBrandStoryContentModelTXTType;
            model.value = kMeUnNilStr(str);
            [strongSelf->_model.arrdata insertObject:model atIndex:atIndex];
            [strongSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if (type == MEBrandStoryContentModelVideoType){
         [self upFileWIthAllowPickingVideo:YES AtIndex:atIndex isHeader:isHeader];
    }else if (type == MEBrandStoryContentModelPicType){
        [self upFileWIthAllowPickingVideo:NO AtIndex:atIndex isHeader:isHeader];
    }
}

- (void)upFileWIthAllowPickingVideo:(BOOL)allowPickingVideo AtIndex:(NSInteger)atIndex isHeader:(BOOL)isHeader{
    kMeWEAKSELF
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    imagePicker.allowPickingOriginalPhoto = NO;
    if(allowPickingVideo){
        imagePicker.allowPickingVideo = YES;
        imagePicker.allowPickingImage = NO;
    }else{
        imagePicker.allowPickingVideo = NO;
        imagePicker.allowPickingImage = YES;
    }
    if(allowPickingVideo){
        [imagePicker setDidFinishPickingVideoHandle:^(UIImage *coverImage, id asset) {
            PHAsset *phAsset = asset;
            if (phAsset.mediaType == PHAssetMediaTypeVideo) {
                /// 包含该视频的基础
                PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
                options.version = PHImageRequestOptionsVersionCurrent;
                options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
                PHImageManager *manager = [PHImageManager defaultManager];
                [manager requestAVAssetForVideo:asset
                                        options:options
                                  resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                                     kMeSTRONGSELF
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          MBProgressHUD *HUD = [SSPublicNetWorkTool commitWithHUD:@""];
                                          AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
                                          exportSession.shouldOptimizeForNetworkUse = YES;
                                          exportSession.outputFileType = AVFileTypeMPEG4;
                                          NSString *videoPath = [kFilePathForVideo() stringByAppendingPathComponent:[self getUploadFile_type:@"video" fileType:@"mp4"]];
                                          exportSession.outputURL = [NSURL fileURLWithPath:videoPath];;
                                          [exportSession exportAsynchronouslyWithCompletionHandler:^{
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [SSPublicNetWorkTool postQiNiuUpFileWithToken:strongSelf->_token filePath:videoPath successBlock:^(id object) {
                                                      NSLog(@"%@",object);
                                                      if([object isKindOfClass:[NSDictionary class]]){
                                                          NSString *key = kMeUnNilStr(object[@"key"]);
                                                          MEBrandStoryContentModel *model  = [MEBrandStoryContentModel new];
                                                          model.type =  MEBrandStoryContentModelVideoType;
                                                          model.value = kMeUnNilStr(key);
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              kMeSTRONGSELF
                                                              if(isHeader){
                                                                  strongSelf->_model.header_mediamodel = model;
                                                                  [strongSelf.headerView setUiWithModel:strongSelf->_model];
                                                              }else{
                                                                  [strongSelf->_model.arrdata insertObject:model atIndex:atIndex];
                                                                  [strongSelf.tableView reloadData];
                                                              }
                                                          });
                                                          [HUD hideAnimated:YES];
                                                      }else{
                                                          [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"图片上传失败"];
                                                      }
                                                  } failure:^(id object) {
                                                      [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"图片上传失败"];
                                                      
                                                  }];
                                              });
                                          }];
                                      });
                    
                                  }];
            }
        }];
    }else{
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
                            MEBrandStoryContentModel *model  = [MEBrandStoryContentModel new];
                            model.type =  MEBrandStoryContentModelPicType;
                            model.value = kMeUnNilStr(key);
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if(isHeader){
                                    strongSelf->_model.header_mediamodel = model;
                                    [strongSelf.headerView setUiWithModel:strongSelf->_model];
                                }else{
                                    kMeSTRONGSELF
                                    [strongSelf->_model.arrdata insertObject:model atIndex:atIndex];
                                    [strongSelf.tableView reloadData];
                                }
                            });
                            [HUD hideAnimated:YES];
                        }else{
                            [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"图片上传失败"];
                        }
                    } failure:^(id object) {
                        [SSShowViewTool SHOWHUDWITHHUD:HUD test:@"图片上传失败"];
                        
                    }];
                }
            }
        }];
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (NSString *)getUploadFile_type:(NSString *)type fileType:(NSString *)fileType {
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSDate * NowDate = [NSDate dateWithTimeIntervalSince1970:now];
    ;
    NSString *timeStr = [formatter stringFromDate:NowDate];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@.%@",type,timeStr,fileType];
    return fileName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSBrandStoryContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSBrandStoryContentCell class]) forIndexPath:indexPath];
    MEBrandStoryContentModel *model = _model.arrdata[indexPath.row];
    kMeWEAKSELF
    [cell setUIWIthModel:model];
    cell.addBlcok = ^(NSInteger index) {
        kMeSTRONGSELF
        [strongSelf addActionWithType:index atIndex:indexPath.row+1 isHeader:NO];
    };
    cell.delBlcok = ^{
        kMeSTRONGSELF
        [strongSelf->_model.arrdata removeObject:model];
        [strongSelf.tableView reloadData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSSBrandStoryContentCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MEBrandStoryContentModel *model = _model.arrdata[indexPath.row];
    NSInteger type = model.type;
    if(type == MEBrandStoryContentModelTXTType){
      
    }else if (type == MEBrandStoryContentModelVideoType){
        SSBasePlayerVC *vc = [[SSBasePlayerVC alloc]initWithFileUrl:SSLoadAddQiniuImagesWithUrl(model.value)];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (type == MEBrandStoryContentModelPicType){
        if(kMeUnArr(_model.arrdata).count == 0 || _currentPicIndex>kMeUnArr(_model.arrdata).count){
            return;
        }
        _currentPicIndex = indexPath.row;
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.dataSource = self;
        browser.currentIndex = 0;
        [browser show];
    }
}

- (NSUInteger)yb_numberOfCellForImageBrowserView:(YBImageBrowser *)imageBrowser {
    return 1;
}

- (id<YBImageBrowserCellDataProtocol>)yb_imageBrowserView:(YBImageBrowserView *)imageBrowserView dataForCellAtIndex:(NSUInteger)index {
    YBImageBrowseCellData *data = [YBImageBrowseCellData new];
    MEBrandStoryContentModel *model = [kMeUnArr(_model.arrdata) objectAtIndex:_currentPicIndex];
    data.url = [NSURL URLWithString:SSLoadAddQiniuImagesWithUrl(kMeUnNilStr(model.value))];
    return data;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.headerView clearSelect];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-90) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSBrandStoryContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSBrandStoryContentCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headerView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (MEBrandStoryHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"MEBrandStoryHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame =CGRectMake(0, 0, SCREEN_WIDTH, kMEBrandStoryHeaderViewHeight);
        _headerView.deleate = self;
        _headerView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    }
    return _headerView;
}

- (UIView *)getBottomView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 90, SCREEN_WIDTH, 90)];
    _btnSave = [SSView btnWithFrame:CGRectMake(15, (90-40)/2, SCREEN_WIDTH-30, 40) Img:nil title:@"确定发布" target:self Action:@selector(saveAction:)];
    _btnSave.cornerRadius = 20;
    _btnSave.clipsToBounds = YES;
    _btnSave.backgroundColor = kSSPink;
    [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnSave.titleLabel.font = kMeFont(15);
    [view addSubview:_btnSave];
    return view;
}

@end
