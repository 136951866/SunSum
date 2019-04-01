//
//  SSServiceDetailsModel.h
//  SunSum
//
//  Created by hank on 2018/10/17.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSBaseModel.h"
#import "SSGoodDetailModel.h"

@interface SSServiceDetailsModel : SSBaseModel

@property (nonatomic, copy) SSGoodDetailModel *serviceDetail;
@property (nonatomic, copy) NSArray *recommendService;

@end
