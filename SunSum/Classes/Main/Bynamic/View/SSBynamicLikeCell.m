//
//  SSBynamicLikeCell.m
//  SunSum
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBynamicLikeCell.h"
#import "SSBynamicHomeModel.h"

#define kSSBynamicLikeCelllMagin (10+36+10+10+10+10+10+14)

@interface SSBynamicLikeCell (){
    
}

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeight;

@end


@implementation SSBynamicLikeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
//    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, self.bounds.size.width);
    // Initialization code
}

- (void)setUIWithModel:(NSArray *)arrmodel{
    NSString *str = @"";
    for (NSInteger i=0; i<arrmodel.count; i++) {
        SSBynamicHomepraiseModel *model = arrmodel[i];
        NSLog(@"%@",model.nick_name);
        if(i==arrmodel.count-1){
             str = [str stringByAppendingString:[NSString stringWithFormat:@"%@",kMeUnNilStr(model.nick_name)]];
        }else{
             str = [str stringByAppendingString:[NSString stringWithFormat:@"%@,",kMeUnNilStr(model.nick_name)]];
        }
    }
    NSLog(@"%@",str);
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:SCREEN_WIDTH-kSSBynamicLikeCelllMagin lineH:0 maxLine:0];
    _consTitleHeight.constant = titleHeight>17?titleHeight:17;
    [_lblTitle setAtsWithStr:str lineGap:0];
}

+ (CGFloat)getCellHeightWithhModel:(NSArray *)arrmodel{
    CGFloat height = 8;
    NSString *str = @"";
    for (NSInteger i=0; i<arrmodel.count; i++) {
        SSBynamicHomepraiseModel *model = arrmodel[i];
        if(i==arrmodel.count-1){
             str = [str stringByAppendingString:[NSString stringWithFormat:@"%@",kMeUnNilStr(model.nick_name)]];
            
        }else{
             str = [str stringByAppendingString:[NSString stringWithFormat:@"%@,",kMeUnNilStr(model.nick_name)]];
        }
    }
    CGFloat titleHeight = [NSAttributedString heightForAtsWithStr:str font:[UIFont systemFontOfSize:14] width:SCREEN_WIDTH-kSSBynamicLikeCelllMagin lineH:0 maxLine:0];
    height+=titleHeight>17?titleHeight:17;
    return height;
}



@end
