//
//  SSBrandManngerAllContentVC.h
//  SunSum
//
//  Created by hank on 2019/3/8.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@class SSBrandMemberInfo;

typedef void (^kSSBrandMemberInfoBlock)(SSBrandMemberInfo *model);

@interface SSBrandManngerAllContentVC : SSBaseVC

@property (nonatomic ,copy) kSSBrandMemberInfoBlock modelBlock;

@end

NS_ASSUME_NONNULL_END
