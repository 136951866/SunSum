//
//  SSSuperMemberHomeModel.h
//  SunSum
//
//  Created by hank on 2018/10/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"

/*
 "meidou_exchang": [],
 "member_buy": []
 */

@interface SSSuperMemberHomeModel : SSBaseModel

@property (nonatomic, copy) NSArray *meidou_exchang;
@property (nonatomic, copy) NSArray *member_buy;

@end
