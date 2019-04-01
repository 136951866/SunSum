//
//  SSBynamicPublishGridView.h
//  SunSum
//
//  Created by hank on 2019/3/7.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBynamicPublishGridModel;
typedef void (^kMePublishGridModelBlock)(SSBynamicPublishGridModel *object);
const static CGFloat kSSBynamicPublishGridViewMagin = 15;
const static CGFloat kSSBynamicPublishGridViewPadding = 6;
#define kSSBynamicPublishGridViewOneHeight ((SCREEN_WIDTH - (kSSBynamicPublishGridViewMagin *2) - (kSSBynamicPublishGridViewPadding *2))/3)

@interface SSBynamicPublishGridView : UIView

+ (CGFloat)getViewHeightWIth:(NSArray *)arr;
- (void)setUIWithArr:(NSArray *)arr;
@property (nonatomic, copy) kMePublishGridModelBlock selectBlock;
@property (nonatomic, copy) kMeIndexBlock delBlock;
@property (nonatomic, strong) NSMutableArray *arrImageView;
@end

NS_ASSUME_NONNULL_END
