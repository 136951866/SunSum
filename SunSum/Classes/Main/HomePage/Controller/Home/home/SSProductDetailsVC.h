//
//  SSProductDetailsVC.h
//  SunSum
//
//  Created by hank on 2018/9/7.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseVC.h"

@interface SSProductDetailsVC : SSBaseVC

- (instancetype)initWithId:(NSInteger)detailsId;
//来自好友分享
@property(nonatomic, copy) NSString *uid;
@property (nonatomic, assign) BOOL isGift;
@end
