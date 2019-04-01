//
//  SSActiveCell.h
//  SunSum
//
//  Created by hank on 2018/10/25.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSSActiveCellHeight ((180 * kMeFrameScaleY())+24)

@interface SSActiveCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;

@end
