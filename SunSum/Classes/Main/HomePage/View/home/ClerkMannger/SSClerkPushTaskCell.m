//
//  SSClerkPushTaskCell.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkPushTaskCell.h"

@interface SSClerkPushTaskCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblPushContentP;
@property (weak, nonatomic) IBOutlet UILabel *lblPushTimeP;
@property (weak, nonatomic) IBOutlet UILabel *lblClerkP;

@end

@implementation SSClerkPushTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
}

- (void)setUIWIthModel:(id)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(@""));
    _lblName.text = kMeUnNilStr(@"11");
    _lblTime.text = kMeUnNilStr(@"222");
    
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
