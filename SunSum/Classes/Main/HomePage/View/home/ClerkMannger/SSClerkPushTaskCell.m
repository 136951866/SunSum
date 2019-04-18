//
//  SSClerkPushTaskCell.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkPushTaskCell.h"
#import "SSClerkCreateClerkTaskModel.h"

@interface SSClerkPushTaskCell ()

//@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
//@property (weak, nonatomic) IBOutlet UILabel *lblName;
//@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblPushContentP;
@property (weak, nonatomic) IBOutlet UILabel *lblPushTimeP;
@property (weak, nonatomic) IBOutlet UILabel *lblClerkP;
@property (weak, nonatomic) IBOutlet UILabel *lblPushTitleP;

@end

@implementation SSClerkPushTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
}

- (void)setUIWIthModel:(SSClerkCreateClerkTaskModel *)model{
    _lblPushTitleP.text = kMeUnNilStr(model.task_title).length?kMeUnNilStr(model.task_title):@"发布任务标题";
   _lblPushContentP.text = kMeUnNilStr(model.task_content).length?kMeUnNilStr(model.task_content):@"发布任务内容";
   _lblPushTimeP.text = kMeUnNilStr(model.last_time).length?kMeUnNilStr(model.last_time):@"选择任务时间";
    _lblClerkP.text = kMeUnArr(model.arrclerk_id).count?@"已选择":@"指定店员跟进";
}

- (IBAction)pushtitleAction:(UIButton *)sender {
    kMeCallBlock(_pushTitleBlcok);
}

- (IBAction)pushContentAction:(UIButton *)sender {
    kMeCallBlock(_pushContentBlcok);
}

- (IBAction)pushTimeAction:(UIButton *)sender {
    kMeCallBlock(_pushTimeBlcok);

}

- (IBAction)selectClerkAction:(UIButton *)sender {
    kMeCallBlock(_SelectClerkBlcok);
}
@end
