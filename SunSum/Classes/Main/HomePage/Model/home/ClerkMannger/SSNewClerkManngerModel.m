//
//  SSNewClerkManngerModel.m
//  SunSum
//
//  Created by hank on 2019/4/17.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSNewClerkManngerModel.h"

@implementation SSNewClerkManngerDataContentModel : SSBaseModel

@end

@implementation SSNewClerkManngerDataModel : SSBaseModel
SSModelObjectClassInArrayWithDic(@{@"data" : [SSNewClerkManngerDataContentModel class]})
@end

@implementation SSNewClerkManngerClerkOrderModel : SSBaseModel

@end



//员工任务

@implementation SSNewClerkManngerClerkTaskpercentModel : SSBaseModel

@end

@implementation SSNewClerkManngerClerkTaskModel : SSBaseModel

SSModelObjectClassInArrayWithDic(@{@"clerk_finish_percent" : [SSNewClerkManngerClerkTaskpercentModel class]})


@end




//员工日志

@implementation SSNewClerkManngerClerkTaskclientModel : SSBaseModel

@end

@implementation SSNewClerkManngerClerkTaskServiceModel : SSBaseModel

SSModelObjectClassInArrayWithDic(@{@"client" : [SSNewClerkManngerClerkTaskclientModel class]})
@end









@implementation SSNewClerkManngerModel

@end
