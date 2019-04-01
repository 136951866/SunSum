//
//  SSOrderSelectStoreCell.m
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSOrderSelectStoreCell.h"

@interface SSOrderSelectStoreCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;


@end

@implementation SSOrderSelectStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}

- (void)setUIWithSubtitle:(NSString *)subtitle title:(NSString *)title{
    if(kMeUnNilStr(subtitle).length){
        _lblSubtitle.text = kMeUnNilStr(subtitle);
    }else{
        _lblSubtitle.text = @"请选择";
    }
    _lblTitle.text = kMeUnNilStr(title);
}

@end
