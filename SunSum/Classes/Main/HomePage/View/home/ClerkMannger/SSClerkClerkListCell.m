//
//  SSClerkClerkListCell.m
//  SunSum
//
//  Created by hank on 2019/4/15.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSClerkClerkListCell.h"

@interface SSClerkClerkListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;

@end

@implementation SSClerkClerkListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWIthModel:(id)model{
    kSDLoadImg(_imgPic, kMeUnNilStr(@""));
    _lbltitle.text = kMeUnNilStr(@"11");
    _lblSubtitle.text = kMeUnNilStr(@"11");
}

@end
