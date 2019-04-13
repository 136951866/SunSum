//
//  SSRushBuyView.h
//  SunSum
//
//  Created by hank on 2018/11/6.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SSAdModel;
@interface SSRushBuyView : UIView

+ (void)ShowWithModel:(SSAdModel *)model tapBlock:(kMeBasicBlock)tapBlock cancelBlock:(kMeBasicBlock)cancelBlock superView:(UIView*)superView;
- (instancetype)initWithModel:(SSAdModel *)model superView:(UIView*)superView;

@end
