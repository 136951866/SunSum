//
//  SSGoodManngerContentVC.h
//  SunSum
//
//  Created by hank on 2019/3/27.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSGoodManngerContentVCBootomHeigt = 67;

@interface SSGoodManngerContentVC : SSBaseVC
//是否上架;1是;2否
- (instancetype)initWithType:(NSInteger)index;
@property (nonatomic, copy)SSRequestNetListModelBlock finishBlock;
- (void)reloadNetData;
@end

NS_ASSUME_NONNULL_END
