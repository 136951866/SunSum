//
//  SSThridHomeTimeSecionView.h
//  SunSum
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSThridHomeTimeSecionViewHeight = 55;

@interface SSThridHomeTimeSecionView : UITableViewHeaderFooterView

- (void)setUIWithArr:(NSArray *)arrModel selectIndex:(NSInteger)selextIndex selectBlock:(kMeIndexBlock)selectBlock;

@end

NS_ASSUME_NONNULL_END
