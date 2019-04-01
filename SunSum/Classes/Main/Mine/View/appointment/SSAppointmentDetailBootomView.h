//
//  SSAppointmentDetailBootomView.h
//  SunSum
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kSSAppointmentDetailBootomViewheight = 84;

@interface SSAppointmentDetailBootomView : UIView

@property (nonatomic, copy) kMeBasicBlock cancelBlock;
@property (nonatomic, copy) kMeBasicBlock finishBlock;

@end
