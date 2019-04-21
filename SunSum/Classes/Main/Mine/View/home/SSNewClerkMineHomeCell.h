//
//  SSNewClerkMineHomeCell.h
//  SunSum
//
//  Created by hank on 2019/4/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSFourClerkHomeHeaderViewHeight = 214;

@protocol  SSNewClerkMineHomeCellDelegate <NSObject>
- (void) toSetVC;
- (void) toTaskVC;
- (void) toposterVC;
- (void) toArticelkVC;
- (void) toDataVC;
- (void) toChatVC;
@end
const static CGFloat kSSNewClerkMineHomeCellHeight = 345;

@interface SSNewClerkMineHomeCell : UITableViewCell
@property(nonatomic, weak) id<SSNewClerkMineHomeCellDelegate> delegate;

- (void)reloadUI;

@end

NS_ASSUME_NONNULL_END
