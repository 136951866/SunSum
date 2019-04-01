//
//  SSBynamicHomeModel.m
//  SunSum
//
//  Created by hank on 2019/1/24.
//  Copyright © 2019 hank. All rights reserved.
//

#import "SSBynamicHomeModel.h"

@implementation SSBynamicHomepraiseModel

@end

@implementation SSBynamicHomecommentModel

@end

@implementation SSBynamicHomeModel

SSModelIdToIdField

SSModelObjectClassInArrayWithDic((@{@"praise" : [SSBynamicHomepraiseModel class],@"comment" : [SSBynamicHomecommentModel class]}))

- (NSString *)content{
    if(!_content || kMeUnNilStr(_content).length == 0){
        return @" ";
    }else{
        return _content;
    }
}

@end
