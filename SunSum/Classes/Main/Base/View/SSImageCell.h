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

#define SSImageEduCellHeight ((SCREEN_WIDTH * 5897)/1125)
#define SSImageTourCellHeight ((SCREEN_WIDTH * 6062)/1125)
#define SSImageCarCellHeight ((SCREEN_WIDTH * 5688)/1125)
#define SSImageZXCellHeight ((SCREEN_WIDTH * 6328)/1125)

@interface SSImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagePic;;

@end

