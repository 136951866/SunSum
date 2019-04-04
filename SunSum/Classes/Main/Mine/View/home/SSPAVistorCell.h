//
//  SSPAVistorCell.h
//  SS时代
//
//  Created by hank on 2019/4/4.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


const static CGFloat kSSPAVistorCellHeight = 70;
@class SSVistorUserModel;
@interface SSPAVistorCell : UITableViewCell

- (void)setUIWithModel:(SSVistorUserModel *)model;

@end

NS_ASSUME_NONNULL_END
