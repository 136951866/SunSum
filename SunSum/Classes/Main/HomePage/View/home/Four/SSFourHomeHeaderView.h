//
//  SSFourHomeHeaderView.h
//  SunSum
//
//  Created by hank on 2019/4/12.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSFourHomeHeaderViewHeight = 320;

@protocol  SSFourHomeHeaderViewDelegate <NSObject>
- (void) toAiVC;
- (void) toStoreDiagnosisVC;
- (void) toPAVC;
- (void) toClerkManngerVC;
- (void) toCaseVC;
@end

@interface SSFourHomeHeaderView : UITableViewHeaderFooterView

@property(nonatomic, weak) id<SSFourHomeHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
