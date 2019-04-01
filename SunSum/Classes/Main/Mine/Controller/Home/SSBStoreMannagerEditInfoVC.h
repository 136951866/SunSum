//
//  SSBStoreMannagerEditInfoVC.h
//  SunSum
//
//  Created by hank on 2019/2/19.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@class SSBStoreMannagercontentInfoModel;
@interface SSBStoreMannagerEditInfoVC : SSBaseVC

- (instancetype)initWithContent:(SSBStoreMannagercontentInfoModel*)model;

@property (nonatomic, copy) kMeTextBlock contenBlock;

@end

NS_ASSUME_NONNULL_END
