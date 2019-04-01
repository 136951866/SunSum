//
//  SSArticleCell.h
//  SunSum
//
//  Created by hank on 2018/11/27.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSArticelModel;
const static CGFloat kSSArticleCellheight = 111;

@interface SSArticleCell : UITableViewCell

- (void)setUIWithModel:(SSArticelModel *)model;
- (void)setUIWithModel:(SSArticelModel *)model withKey:(NSString *)key;
@end
