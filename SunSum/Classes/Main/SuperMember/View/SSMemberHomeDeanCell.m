//
//  SSMemberHomeDeanCell.m
//  SunSum
//
//  Created by hank on 2018/10/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSMemberHomeDeanCell.h"
#import "SSGoodModel.h"

const static NSInteger kSSMemberHomeDeanCellLimit  = 3;
#define kSSMemberHomeDeanCellBaseTag (1000)

@interface SSMemberHomeDeanCell ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrView;

@end

@implementation SSMemberHomeDeanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    [_arrView enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = kSSMemberHomeDeanCellBaseTag + idx;
        obj.userInteractionEnabled = NO;
        obj.hidden = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        [obj addGestureRecognizer:ges];
    }];
    // Initialization code
}

- (void )tapView:(UITapGestureRecognizer *)ges{
    UIView *view = ges.view;
    NSInteger tag = view.tag-kSSMemberHomeDeanCellBaseTag;
    kMeCallBlock(_indexBlock,tag);
}

- (void)setUIWithArr:(NSArray *)arrModel{
    for (int i=0; i<arrModel.count; i++) {
        if(i >= kSSMemberHomeDeanCellLimit){
            break;
        }
        SSGoodModel *model = arrModel[i];
        UIView *view = _arrView[i];
        view.userInteractionEnabled = YES;
        view.hidden = NO;
        UIImageView *img = [view viewWithTag:100];
        UILabel *lblTitle = [view viewWithTag:101];
        UILabel *lblDean = [view viewWithTag:102];
        kSDLoadImg (img,SSLoadQiniuImagesWithUrl(kMeUnNilStr(model.images)));
//        kSDLoadImg(img, SSLoadQiniuImagesWithUrl(kMeUnNilStr(@"")));
        lblTitle.text = kMeUnNilStr(model.title);
        lblDean.text =[NSString stringWithFormat:@"%@美豆",model.integral_lines];
    }
}

@end
