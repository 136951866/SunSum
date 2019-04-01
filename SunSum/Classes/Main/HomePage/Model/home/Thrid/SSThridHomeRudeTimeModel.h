//
//  SSThridHomeRudeTimeModel.h
//  SunSum
//
//  Created by hank on 2019/1/25.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
/*
 "time": "11:00",
 "status": 1,
 "tip": "正在抢购"
 */
@interface SSThridHomeRudeTimeModel : SSBaseModel

@property (nonatomic, strong) NSString * time;
@property (nonatomic, assign) NSInteger  status;
@property (nonatomic, strong) NSString * tip;

@end

NS_ASSUME_NONNULL_END
