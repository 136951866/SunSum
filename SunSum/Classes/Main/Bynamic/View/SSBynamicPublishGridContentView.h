//
//  SSBynamicPublishGridContentView.h
//  SunSum
//
//  Created by hank on 2019/3/7.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBynamicPublishGridModel;
@interface SSBynamicPublishGridContentView : UIView

- (void)setUIWithModel:(SSBynamicPublishGridModel*)model;
- (void)setUIWIthUrl:(NSString *)url;
@property (nonatomic, copy) kMeBasicBlock block;
@property (nonatomic,strong)UIImageView *imageVIew;
@end

NS_ASSUME_NONNULL_END
