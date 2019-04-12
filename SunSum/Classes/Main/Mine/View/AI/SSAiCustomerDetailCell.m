//
//  SSAiCustomerDetailCell.m
//  SS时代
//
//  Created by hank on 2019/4/10.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSAiCustomerDetailCell.h"
#import "SSStarControl.h"
#import "SSFlowLabelView.h"
#import "SSAiCustomerDetailModel.h"

#define kSSAiCustomerDetailCellFlowWdith (SCREEN_WIDTH - 60)
const static CGFloat kFlowWdithHeight = 21;

@interface SSAiCustomerDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet SSStarControl *statrt;
@property (weak, nonatomic) IBOutlet SSFlowLabelView *flowlabel;
@property (weak, nonatomic) IBOutlet UILabel *lblAppoint;
@property (weak, nonatomic) IBOutlet UILabel *lblFollow;
@property (weak, nonatomic) IBOutlet UILabel *lblFollowB;
@property (weak, nonatomic) IBOutlet UIButton *btnAddTag;


@end

@implementation SSAiCustomerDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    _flowlabel.flowLabelViewWdith = kSSAiCustomerDetailCellFlowWdith;
    _flowlabel.flowLabelViewLabelHeight = kFlowWdithHeight;
    // Initialization code
}

- (void)setUIWithModel:(SSAiCustomerDetailModel *)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(model.header_pic));
    _lblTitle.text = kMeUnNilStr(model.nick_name);
    _statrt.score = model.star_level;
    _lblAppoint.text = kMeUnNilStr(model.predict_bargain).length?model.predict_bargain:@"0";
    _lblFollow.text = kMeUnNilStr(model.follow_up).length?model.follow_up:@"0";
    _lblFollowB.hidden = ([kMeUnNilStr(model.follow_up) isEqualToString:@"成交"]||[kMeUnNilStr(model.follow_up) isEqualToString:@"无法签单"]);
    if(kMeUnArr(model.label).count){
        [_flowlabel reloaCustomWithArr:kMeUnArr(model.label) font:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithHexString:@"55ba14"] backGroundColor:[UIColor colorWithHexString:@"ddf0d0"]];
    }else{
         [_flowlabel reloaCustomWithArr:@[@"添加标签"] font:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithHexString:@"55ba14"] backGroundColor:[UIColor colorWithHexString:@"ddf0d0"]];
    }
    [self layoutIfNeeded];
}

+ (CGFloat)getCellHeightWithModel:(SSAiCustomerDetailModel *)model{
    CGFloat height = 255-kFlowWdithHeight;
    CGFloat flowHeight = [SSFlowLabelView getCustomMEFlowLabelViewHeightWithArr:kMeUnArr(model.label) wdith:kSSAiCustomerDetailCellFlowWdith LabelViewLabelHeight:kFlowWdithHeight font:[UIFont systemFontOfSize:12]];
    if(kMeUnArr(model.label).count == 0){
        height +=kFlowWdithHeight;
    }
    return (height + flowHeight);
}

- (IBAction)followAction:(UIButton *)sender {
    kMeCallBlock(_followBlock);
}

- (IBAction)addTagAction:(UIButton *)sender {
    kMeCallBlock(_addTagBlock);
}


@end
