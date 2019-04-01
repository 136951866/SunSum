//
//  SSBynamicPublishVC.m
//  SunSum
//
//  Created by hank on 2019/3/7.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBynamicPublishVC.h"
#import "SSBynamicPublishGridView.h"
#import "SSBynamicPublishGridModel.h"
#import <TZImagePickerController.h>
#import "SSTextView.h"
#import "YBImageBrowser.h"
#import "SSBynamicPublishGridContentView.h"

const static CGFloat SSBynamicPublishVCTextHeight = 135;

@interface SSBynamicPublishVC ()<TZImagePickerControllerDelegate,YBImageBrowserDataSource>{
    NSInteger _currentIndex;
    NSMutableArray *_arrImage;
    NSString *_token;
    BOOL _isError;
}
//@property (weak, nonatomic) IBOutlet SSBynamicPublishGridView *gridView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consGridViewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;
@property (nonatomic , strong) SSTextView *textView;
@property (nonatomic , strong) SSBynamicPublishGridView *gridView;
@property (strong, nonatomic) NSMutableArray *arrModel;
@property (nonatomic, strong) UIButton *btnRight;
@end

@implementation SSBynamicPublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发表";
    kMeWEAKSELF
    _isError = NO;
    MBProgressHUD *HUD = [SSPublicNetWorkTool commitWithHUD:@""];
    [SSPublicNetWorkTool postgetQiuNiuTokkenWithSuccessBlock:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kMeSTRONGSELF
        strongSelf->_token = responseObject.data[@"token"];
    } failure:^(id object) {
        [SSShowViewTool SHOWHUDWITHHUD:HUD test:kApiError];
        kMeSTRONGSELF
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
    _currentIndex = 0;
    _arrImage = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnRight];
    _consTopMargin.constant = kMeNavBarHeight;
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    CGFloat sheight = ((kSSBynamicPublishGridViewOneHeight*3)+(kSSBynamicPublishGridViewPadding *4));
    sheight = sheight<(SCREEN_HEIGHT-kMeNavBarHeight)?(SCREEN_HEIGHT-kMeNavBarHeight):sheight;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, sheight);
    [_scrollView addSubview:self.textView];
    [_scrollView addSubview:self.gridView];
    [self reloadGridView];
    // Do any additional setup after loading the view from its nib.
}

- (void)reloadGridView{
    [_gridView setUIWithArr:self.arrModel];
}

- (void)pushlishAction:(UIButton *)btn{
    [self.view endEditing:YES];
    NSString *content = kMeUnNilStr(_textView.textView.text);
    if(content.length == 0 && self.arrModel.count ==1){
        [SSShowViewTool showMessage:@"内容不能为空" view:self.view];
        return;
    }
    
    _isError = NO;
    [_arrImage removeAllObjects];
   
    kMeWEAKSELF
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    MBProgressHUD *hub =  [SSPublicNetWorkTool commitWithHUD:@"发表中"];
    dispatch_group_async(group, queue, ^{
        kMeSTRONGSELF
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        for (SSBynamicPublishGridModel *model in self.arrModel) {
            if(!model.isAdd){
                [SSPublicNetWorkTool postQiNiuUpFileWithToken:strongSelf->_token filePath:model.filePath successBlock:^(id object) {
                    NSLog(@"%@",object);
                    if([object isKindOfClass:[NSDictionary class]]){
                        [strongSelf->_arrImage addObject:kMeUnNilStr(object[@"key"])];
                    }else{
                       strongSelf->_isError = YES;
                    }
                    dispatch_semaphore_signal(semaphore);
                } failure:^(id object) {
                    strongSelf->_isError = YES;
                    [strongSelf->_arrImage addObject:@""];
                    dispatch_semaphore_signal(semaphore);
                }];
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//                [SSPublicNetWorkTool posUploadImagesWithFile:model.image successBlock:^(ZLRequestResponse *responseObject) {
//                    [strongSelf->_arrImage addObject:kMeUnNilStr(responseObject.data[@"images_url"])];
//                    NSLog(@"---------%@",responseObject.data);
//                    NSLog(@"%@",kMeUnNilStr(responseObject.data[@"images_url"]));
//                    dispatch_semaphore_signal(semaphore);
//                } failure:^(id object) {
//                    [strongSelf->_arrImage addObject:@""];
//                    dispatch_semaphore_signal(semaphore);
//                }];
//                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            }
        }
    });
    
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kMeSTRONGSELF
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!strongSelf->_isError){
                [hub hideAnimated:YES];
                NSError *error = nil;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:strongSelf->_arrImage
                                                                   options:kNilOptions
                                                                     error:&error];
                NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                             encoding:NSUTF8StringEncoding];
                [SSPublicNetWorkTool postdynamicVotingCommentWithConten:content images:jsonString successBlock:^(ZLRequestResponse *responseObject) {
                    kMeSTRONGSELF
                    kMeCallBlock(strongSelf.publishSucessBlock);
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                } failure:^(id object) {
                    
                }];
            }else{
                [SSShowViewTool SHOWHUDWITHHUD:hub test:@"图片上传失败"];
            }
        });
    });
}

- (void)showPhotoWithModel:(SSBynamicPublishGridModel*)model{
    _currentIndex = model.selectIndex;
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSource = self;
    browser.currentIndex = model.selectIndex;
    [browser show];
}

- (NSUInteger)yb_numberOfCellForImageBrowserView:(YBImageBrowser *)imageBrowser {
    return self.arrModel.count -1;
}

- (id<YBImageBrowserCellDataProtocol>)yb_imageBrowserView:(YBImageBrowserView *)imageBrowserView dataForCellAtIndex:(NSUInteger)index {
    YBImageBrowseCellData *data = [YBImageBrowseCellData new];
    data.imageBlock = ^__kindof UIImage * _Nullable{
        SSBynamicPublishGridModel *gmodel = [self.arrModel objectAtIndex:index];
        return gmodel.image;
    };
    SSBynamicPublishGridContentView *contenView = [_gridView.arrImageView objectAtIndex:_currentIndex];
    data.sourceObject = contenView.imageVIew;
    return data;
}

//- (NSInteger)numberInYBImageBrowser:(YBImageBrowser *)imageBrowser {
//
//}
//#warning --
//- (YBImageBrowserModel *)yBImageBrowser:(YBImageBrowser *)imageBrowser modelForCellAtIndex:(NSInteger)index {
//    SSBynamicPublishGridModel *gmodel = [self.arrModel objectAtIndex:index];
//    YBImageBrowserModel *model = [YBImageBrowserModel new];
//    model.image = gmodel.image;
//    return model;
//}
//- (UIImageView *)imageViewOfTouchForImageBrowser:(YBImageBrowser *)imageBrowser {
//    SSBynamicPublishGridContentView *contenView = [_gridView.arrImageView objectAtIndex:_currentIndex];
//    return contenView.imageVIew;
//}

- (NSMutableArray *)arrModel{
    if(!_arrModel){
        _arrModel = [NSMutableArray array];
        SSBynamicPublishGridModel *model = [SSBynamicPublishGridModel modelWithImage:[UIImage imageNamed:@"icon_bynamicAdd"] isAdd:YES];
        [_arrModel addObject:model];
    }
    return _arrModel;
}

- (UIButton *)btnRight{
    if(!_btnRight){
        _btnRight= [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRight setTitle:@"发表" forState:UIControlStateNormal];
        [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnRight.backgroundColor = kSSPink;
        _btnRight.cornerRadius = 2;
        _btnRight.clipsToBounds = YES;
        _btnRight.frame = CGRectMake(0, 0, 63, 30);
        _btnRight.titleLabel.font = kMeFont(15);
        [_btnRight addTarget:self action:@selector(pushlishAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}

- (SSBynamicPublishGridView *)gridView{
    if(!_gridView){
        _gridView = [[SSBynamicPublishGridView alloc]initWithFrame:CGRectMake(0, SSBynamicPublishVCTextHeight, SCREEN_WIDTH, 0)];
        kMeWEAKSELF
        _gridView.selectBlock = ^(SSBynamicPublishGridModel *model) {
            kMeSTRONGSELF
            if(model.isAdd){
                NSInteger maxIndex= 10 - strongSelf.arrModel.count;
                TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:maxIndex columnNumber:3 delegate:strongSelf pushPhotoPickerVc:YES];
                imagePicker.allowPickingOriginalPhoto = NO;
                imagePicker.allowPickingVideo = NO;
                [imagePicker setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
                    kMeSTRONGSELF
                    [strongSelf.arrModel removeLastObject];
                    for (int i = 0; i < assets.count; i ++) {
                        PHAsset *phAsset = assets[i];
                        if (phAsset.mediaType == PHAssetMediaTypeImage) {
                            UIImage *image = photos[i];
                            NSDictionary *info = infos[i];
                            SSBynamicPublishGridModel *model = [SSBynamicPublishGridModel modelWithImage:image isAdd:NO];
                            NSString *filename = [phAsset valueForKey:@"filename"];
//                            NSURL *url = [info valueForKey:@"PHImageFileURLKey"];
                            model.filePath = [SSCommonTool getImagePath:image filename:filename];
                            [strongSelf.arrModel addObject:model];
                        }
                    }
                    SSBynamicPublishGridModel *lastmodel = [SSBynamicPublishGridModel modelWithImage:[UIImage imageNamed:@"icon_bynamicAdd"] isAdd:YES];
                    [strongSelf.arrModel addObject:lastmodel];
                    [strongSelf reloadGridView];
                }];
                [strongSelf presentViewController:imagePicker animated:YES completion:nil];
            }else{
                kMeSTRONGSELF
                [strongSelf showPhotoWithModel:model];
            }
            
        };
        _gridView.delBlock = ^(NSInteger index) {
            kMeSTRONGSELF
            [strongSelf.arrModel removeObjectAtIndex:index];
            [strongSelf reloadGridView];
        };
    }
    return _gridView;
}

- (SSTextView *)textView{
    if(!_textView){
        _textView = [[SSTextView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, SSBynamicPublishVCTextHeight)];
        _textView.placeholderTextView.text = @"这一刻的想法....";
        _textView.textView.font = kMeFont(17);
        _textView.textView.textColor = kSSblack;
    }
    return _textView;
}

@end
