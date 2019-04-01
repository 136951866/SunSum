//
//  SSNewProductDetailsSectionView.h
//  SunSum
//
//  Created by hank on 2019/1/9.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSNewProductDetailsSectionViewHeight = 55;

@interface SSNewProductDetailsSectionView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@end

NS_ASSUME_NONNULL_END
