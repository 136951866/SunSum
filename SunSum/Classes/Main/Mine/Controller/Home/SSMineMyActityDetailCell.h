//
//  SSMineMyActityDetailCell.h
//  SunSum
//
//  Created by hank on 2019/1/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSMineMyActityDetailCellHeight = 62;

@class  SSMineActiveLeveModel;
@interface SSMineMyActityDetailCell : UITableViewCell

- (void)setUIWIthModel:(SSMineActiveLeveModel *)model finish:(BOOL)finish nowNum:(NSString*)nowNum;

@end

NS_ASSUME_NONNULL_END
