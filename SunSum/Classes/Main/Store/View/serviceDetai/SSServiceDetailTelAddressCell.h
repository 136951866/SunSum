//
//  SSServiceDetailTelAddressCell.h
//  SunSum
//
//  Created by hank on 2018/9/14.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSStoreDetailModel;
const static CGFloat kSSServiceDetailTelAddressCellHeight = 101;

@interface SSServiceDetailTelAddressCell : UITableViewCell

- (void)setUIWithModel:(SSStoreDetailModel *)model;

@end
