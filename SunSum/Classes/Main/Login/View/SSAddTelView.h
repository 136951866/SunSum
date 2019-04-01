//
//  SSAddTelView.h
//  SunSum
//
//  Created by hank on 2018/9/15.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSAddTelView : UIView

- (void)setUIWithModel:(id)model;
- (void)show;
- (void)hide;
@property (nonatomic, copy) kMeBOOLBlock finishBlock;

@end
