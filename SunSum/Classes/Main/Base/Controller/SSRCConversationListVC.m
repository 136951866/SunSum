//
//  SSRCConversationListVC.m
//  SunSum
//
//  Created by hank on 2018/9/29.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSRCConversationListVC.h"
#import "TConversationController.h"
#import "AppDelegate.h"
#import "SSRCConversationVC.h"
#import "TChatController.h"
#import "SSNavigationVC.h"
//
@interface SSRCConversationListVC ()<TConversationControllerDelegagte>{
    NSString *_customId;
}

@property (nonatomic, strong) UIButton *btnRight;

@end

@implementation SSRCConversationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBarHidden = NO;
    TConversationController *conv = [[TConversationController alloc] init];
    conv.isAi = self.isAi;
    conv.delegate = self;
    [self addChildViewController:conv];
    [self.view addSubview:conv.view];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnRight];
    
    // Do any additional setup after loading the view.
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SSNavigationVC *nav = (SSNavigationVC *)self.navigationController;
    nav.canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    SSNavigationVC *nav = (SSNavigationVC *)self.navigationController;
    nav.canDragBack = YES;;
}

- (void)conversationController:(TConversationController *)conversationController didSelectConversation:(TConversationCellData *)conversation
{
    SSRCConversationVC *chat = [[SSRCConversationVC alloc] initWIthconversationData:conversation];
    //    chat.conversation = conversation;
    [self.navigationController pushViewController:chat animated:YES];
}
- (void)toCustom{
    TConversationCellData *data = [[TConversationCellData alloc] init];
    data.convId = @"msd_store_test_58800";
    data.convType = TConv_Type_C2C;
    data.title = kMeUnNilStr(data.title);
    SSRCConversationVC *chat = [[SSRCConversationVC alloc] initWIthconversationData:data];
    //    chat.conversation = data;
    
    [self.navigationController pushViewController:chat animated:YES];
}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}
//
//- (void)toCustom{
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
//
//}


- (UIButton *)btnRight{
    if(!_btnRight){
        _btnRight= [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = CGRectMake(-20, 0, 30, 25);
        [_btnRight setTitle:@"客服" forState:UIControlStateNormal];
        _btnRight.titleLabel.font = kMeFont(14);
        [_btnRight setTitleColor:kSSblack forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(toCustom) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}

@end
