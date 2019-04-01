//
//  SSThridProductDetailsVC.h
//  SunSum
//
//  Created by hank on 2019/1/22.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseVC.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, SSThridProductDetailsVCType) {
    SSThridProductDetailsVCNormalType=0,
    SSThridProductDetailsVCRudeType=1,
    SSThridProductDetailsVCNoticeType=2,
    
};
@interface SSThridProductDetailsVC : SSBaseVC

- (instancetype)initWithId:(NSInteger)detailsId;
//来自好友分享
@property(nonatomic, copy) NSString *uid;
@property (nonatomic, assign) BOOL isGift;
@property (nonatomic, strong) NSString *time;

@end

NS_ASSUME_NONNULL_END
