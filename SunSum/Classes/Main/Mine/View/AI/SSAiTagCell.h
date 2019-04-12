//
//  SSAiTagCell.h
//  SS时代
//
//  Created by hank on 2019/4/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kSSAiTagCellW (SCREEN_WIDTH - 90)/3
#define kSSAiTagCellH 30
#define kSSAiTagCellMargin 15

@class SSAiCustomerTagchildrenModel;
@interface SSAiTagCell : UICollectionViewCell

- (void)setUIWithModel:(SSAiCustomerTagchildrenModel *)model;

@end

NS_ASSUME_NONNULL_END
