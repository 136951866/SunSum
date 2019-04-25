//
//  SSArticleAdCell.h
//  SunSum
//
//  Created by hank on 2019/4/25.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define kSSArticleAdCellWdith (SCREEN_WIDTH - 30)
const static CGFloat kSSArticleAdCellheight = 0.1;
@interface SSArticleAdCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@end

NS_ASSUME_NONNULL_END
