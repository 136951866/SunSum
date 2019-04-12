//
//  SSAiTagCollectionReusableView.h
//  SS时代
//
//  Created by hank on 2019/4/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kSSAiTagCollectionReusableViewHeight = 50;


@interface SSAiTagCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

NS_ASSUME_NONNULL_END
