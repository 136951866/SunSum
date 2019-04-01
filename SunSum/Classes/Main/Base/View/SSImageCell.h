//
//  SSImageCell.h
//  SunSum
//
//  Created by hank on 2018/9/25.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SSImageCellHeight ((SCREEN_WIDTH * 240)/790)
#define SSImageMenberCellHeight ((SCREEN_WIDTH * 1334)/750)
@interface SSImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagePic;;

@end

