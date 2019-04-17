//
//  SSClerkWorkDaliyCell.h
//  SunSum
//
//  Created by hank on 2019/4/13.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSClerkWorkDaliyCellHeight = 318;


@interface SSClerkWorkDaliyCell : UITableViewCell

- (void)setUiWithModel:(NSArray *)model Xtitle:(NSArray*)Xtitle title:(NSString *)title progress:(NSString*)progress;

@end

NS_ASSUME_NONNULL_END
