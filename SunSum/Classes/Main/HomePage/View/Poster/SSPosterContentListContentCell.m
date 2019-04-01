//
//  SSPosterContentListContentCell.m
//  SunSum
//
//  Created by hank on 2018/11/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSPosterContentListContentCell.h"
#import "SSPosterModel.h"

@interface SSPosterContentListContentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblShare;

@end

@implementation SSPosterContentListContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblShare.adjustsFontSizeToFitWidth  = YES;
    // Initialization code
}

- (void)setUIWithModel:(SSPosterChildrenModel *)model{
    kSDLoadImg(_imgPic,kMeUnNilStr(model.image));
    _lblShare.text = [NSString stringWithFormat:@"被分享%@次",kMeUnNilStr(model.share_amount)];
    
}

@end
