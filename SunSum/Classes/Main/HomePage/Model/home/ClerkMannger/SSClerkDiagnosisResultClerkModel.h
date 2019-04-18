//
//  SSClerkDiagnosisResultClerkModel.h
//  SunSum
//
//  Created by hank on 2019/4/17.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSClerkDiagnosisResultClerkModel : SSBaseModel
@property (nonatomic, strong) NSString * member_id;
@property (nonatomic, assign) NSInteger  member_count;
@property (nonatomic, strong) NSString * header_pic;
@property (nonatomic, strong) NSString * name;

@end

NS_ASSUME_NONNULL_END
