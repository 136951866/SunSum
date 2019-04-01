//
//  SSDynamicGoodApplyNineGridCell.h
//  SunSum
//
//  Created by hank on 2019/3/25.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSBynamicPublishGridModel;
typedef void (^kMeGridModelBlock)(SSBynamicPublishGridModel *object);
const static CGFloat kSSGridViewMagin = 15;
const static CGFloat kSSGridViewPadding = 6;
#define kSSGridViewOneHeight ((SCREEN_WIDTH - (kSSBynamicPublishGridViewMagin *2) - (kSSBynamicPublishGridViewPadding *2))/3)

@interface SSDynamicGoodApplyNineGridCell : UITableViewCell
- (void)setUIWithArr:(NSMutableArray *)arrModel;
- (void)setUIWithUrlArr:(NSMutableArray *)arrModel;

+ (CGFloat)getCellHeightWithArr:(NSMutableArray *)arrModel;

@property (nonatomic, copy) kMeGridModelBlock selectBlock;
@property (nonatomic, copy) kMeIndexBlock selectIndexBlock;
@property (nonatomic, copy) kMeIndexBlock delBlock;
@property (nonatomic, strong) NSMutableArray *arrImageView;

@end

NS_ASSUME_NONNULL_END
