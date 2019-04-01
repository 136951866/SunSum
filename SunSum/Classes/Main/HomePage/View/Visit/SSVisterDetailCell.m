//
//  SSVisterDetailCell.m
//  SunSum
//
//  Created by hank on 2018/11/29.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSVisterDetailCell.h"
#import "SSVisterDetailVC.h"
#import "SSRCConversationVC.h"
#import "SSVistorUserModel.h"
#import "SSSpreadUserModel.h"

@interface SSVisterDetailCell (){
    SSVistorUserModel *_model;
}
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblCountPage;
@property (weak, nonatomic) IBOutlet UILabel *lblChatTime;
@property (weak, nonatomic) IBOutlet UILabel *lblZFNum;
@property (weak, nonatomic) IBOutlet UILabel *lblInVialRead;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblSex;

@end

@implementation SSVisterDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _lblCountPage.adjustsFontSizeToFitWidth = YES;
    _lblChatTime.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setUIWithModle:(SSVistorUserModel *)model dicUser:(SSSpreadUserModel *)dicUser{
    _model = model;
    kSDLoadImg(_imgHeader, kMeUnNilStr(model.user.header_pic));
    _lblName.text = kMeUnNilStr(model.user.nick_name);
    _lblCountPage.text =  [NSString stringWithFormat:@"%@篇",kMeUnNilStr(dicUser.browse)];
    _lblChatTime.text = [NSString stringWithFormat:@"%@/篇",kMeUnNilStr(dicUser.wait_time)];
    _lblZFNum.text = [NSString stringWithFormat:@"%@次",kMeUnNilStr(dicUser.share_total)];
    _lblInVialRead.text = [NSString stringWithFormat:@"%@篇",kMeUnNilStr(dicUser.valid)];
    _lblAddress.text = kMeUnNilStr(model.user.address);
    _lblSex.text = kMeUnNilStr(model.user.sex);
}

- (IBAction)toChatAction:(UIButton *)sender {
    SSVisterDetailVC *homeVC = [SSCommonTool getVCWithClassWtihClassName:[SSVisterDetailVC class] targetResponderView:self];
    if(homeVC){
        if([kMeUnNilStr(_model.tls_id) isEqualToString:kCurrentUser.tls_data.tls_id]){
            [SSShowViewTool showMessage:@"暂不支持和自己聊天" view:self];
        }else{
            TConversationCellData *data = [[TConversationCellData alloc] init];
            data.convId = kMeUnNilStr(_model.tls_id);
            data.convType = TConv_Type_C2C;
            data.title = kMeUnNilStr(_model.user.nick_name);;
            SSRCConversationVC *chat = [[SSRCConversationVC alloc] initWIthconversationData:data];
            //            chat.conversation = data;
            [homeVC.navigationController pushViewController:chat animated:YES];
        }
    }
    //        SSRCConversationVC *conversationVC = [[SSRCConversationVC alloc]init];
    //        conversationVC.conversationType = ConversationType_PRIVATE;
    //        conversationVC.targetId = @(_model.member_id).description ;//RONGYUNCUSTOMID;
    //        conversationVC.title = kMeUnNilStr(_model.user.nick_name);
    //        if([@((_model.member_id)).description isEqualToString:kCurrentUser.uid]){
    //            [SSShowViewTool showMessage:@"暂不支持和自己聊天" view:self];
    //        }else{
    //            [homeVC.navigationController pushViewController:conversationVC animated:YES];
    //        }
    
}


@end
